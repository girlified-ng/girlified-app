import 'dart:async';

import 'package:get/get.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/utilities/protection_keyword_store.dart';
import 'package:girlified/core/utilities/threat_validator.dart';
import 'package:girlified/data/services/native_service.dart';

/// Bridges native scraped text → Dart threat validation → overlay blocker.
class TextDetectionPipeline {
  TextDetectionPipeline._();
  static final TextDetectionPipeline instance = TextDetectionPipeline._();

  StreamSubscription<Map<String, dynamic>>? _subscription;
  bool _isListening = false;

  /// Last pipeline stage reached — useful for debug UI.
  String lastStage = 'idle';
  String lastPayload = '';
  String? lastMatchedWord;

  void start() {
    if (_isListening) return;
    _isListening = true;
    lastStage = 'listening';

    print('[SAFETY_PIPELINE] Subscribing to native EventChannel');

    _subscription = NativeService().nativeEvents.listen(
      _onNativeEvent,
      onError: (Object error, StackTrace stack) {
        print('[SAFETY_PIPELINE] EventChannel error: $error');
        lastStage = 'error: $error';
      },
      cancelOnError: false,
    );
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
    _isListening = false;
    lastStage = 'stopped';
  }

  Future<void> _onNativeEvent(Map<String, dynamic> event) async {
    final String eventType = event['event']?.toString() ?? '';
    print('[SAFETY_PIPELINE] Native event received: $eventType');

    if (eventType == 'text_scraped') {
      await _handleScrapedTexts(event);
    } else if (eventType == 'threat_detected') {
      final String keyword = event['keyword']?.toString() ?? '';
      lastMatchedWord = keyword.isNotEmpty ? keyword : null;
      lastStage = 'native_threat_detected';
      // Native purple card is the only blocker — do not open a second Flutter overlay.
      print('[SAFETY_PIPELINE] Native purple card active for "$keyword"');
    } else if (eventType == 'content_blocked') {
      lastStage = 'native_block:${event['data']}';
      print('[SAFETY_PIPELINE] Native purple card active for ${event['data']}');
    } else if (eventType == 'open_protection_dashboard') {
      lastStage = 'navigate_protection_dashboard';
      await _returnToSaifeProtectionScreen();
    }
  }

  /// Closes any Flutter overlay and navigates to the SaifeAI protection tab.
  Future<void> _returnToSaifeProtectionScreen() async {
    await ThreatValidator.closeOverlayIfActive();

    try {
      ServiceRegistry.commonRepository.currentScreenIndex.value = 0;

      if (Get.currentRoute != AppRoutes.dashboardRoute) {
        Get.offAllNamed(AppRoutes.dashboardRoute);
      }
    } catch (e, stack) {
      print('[SAFETY_PIPELINE] Navigation to SaifeAI failed: $e\n$stack');
      lastStage = 'navigation_error';
    }
  }

  Future<void> _handleScrapedTexts(Map<String, dynamic> event) async {
    final List<dynamic>? texts = event['texts'] as List<dynamic>?;
    final String package = event['package']?.toString() ?? 'unknown';

    if (texts == null || texts.isEmpty) {
      lastStage = 'empty_batch';
      print('[SAFETY_PIPELINE] text_scraped with empty batch from $package');
      return;
    }

    lastStage = 'validating';
    final keywordCount = ProtectionKeywordStore.readKeywords().length;
    print('[SAFETY_PIPELINE] Validating ${texts.length} scraped strings from $package ($keywordCount stored keywords)');

    if (keywordCount == 0) {
      lastStage = 'no_keywords_configured';
      print('[SAFETY_PIPELINE] No keywords in GetStorage — skipping validation');
      return;
    }

    for (final dynamic raw in texts) {
      final String text = raw.toString();
      if (text.trim().isEmpty) continue;

      lastPayload = text.length > 120 ? '${text.substring(0, 120)}…' : text;
      print('[SAFETY_PIPELINE] Checking: "$lastPayload"');

      final String? matched = ThreatValidator.findThreatMatch(text);
      if (matched != null) {
        lastMatchedWord = matched;
        lastStage = 'match_found_native_only';
        // Native SaifeAccessibilityService shows the purple card — skip Flutter overlay.
        print('[SAFETY_PIPELINE] Match "$matched" — native purple card handles blocking');
        return;
      }
    }

    lastStage = 'no_match';
    lastMatchedWord = null;
  }

  /// Feeds a string directly into validation (debug / mock testing).
  Future<bool> runMockTest(String text) async {
    print('[SAFETY_PIPELINE] Mock test input: "$text"');
    lastPayload = text;
    lastStage = 'mock_test';

    final String? matched = ThreatValidator.findThreatMatch(text);
    if (matched == null) {
      lastStage = 'mock_no_match';
      lastMatchedWord = null;
      print('[SAFETY_PIPELINE] Mock test: no threat detected');
      return false;
    }

    lastMatchedWord = matched;
    lastStage = 'mock_match';
    print('[SAFETY_PIPELINE] Mock test matched "$matched" — triggering overlay');
    await ThreatValidator.triggerOverlayBlocker(matchedWord: matched);
    return true;
  }
}
