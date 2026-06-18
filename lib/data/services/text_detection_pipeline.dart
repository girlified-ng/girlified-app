import 'dart:async';

import 'package:girlified/core/utilities/protection_keyword_store.dart';
import 'package:girlified/core/utilities/threat_validator.dart';
import 'package:girlified/data/services/native_service.dart';

/// Bridges native scraped text → Dart keyword validation (inline masks are native-only).
class TextDetectionPipeline {
  TextDetectionPipeline._();
  static final TextDetectionPipeline instance = TextDetectionPipeline._();

  StreamSubscription<Map<String, dynamic>>? _subscription;
  bool _isListening = false;

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
    } else if (eventType == 'content_blocked') {
      lastStage = 'full_page_block:${event['data']}';
      print('[SAFETY_PIPELINE] Full-page warning active for ${event['data']}');
    }
  }

  Future<void> _handleScrapedTexts(Map<String, dynamic> event) async {
    final List<dynamic>? texts = event['texts'] as List<dynamic>?;
    final String package = event['package']?.toString() ?? 'unknown';

    if (texts == null || texts.isEmpty) {
      lastStage = 'empty_batch';
      return;
    }

    lastStage = 'validating';
    if (ProtectionKeywordStore.readKeywords().isEmpty) {
      lastStage = 'no_keywords_configured';
      return;
    }

    for (final dynamic raw in texts) {
      final String text = raw.toString();
      if (text.trim().isEmpty) continue;

      lastPayload = text.length > 120 ? '${text.substring(0, 120)}…' : text;
      final String? matched = ThreatValidator.findThreatMatch(text);
      if (matched != null) {
        lastMatchedWord = matched;
        lastStage = 'match_found';
        return;
      }
    }

    lastStage = 'no_match';
    lastMatchedWord = null;
  }

  /// Validates text for the in-app debug panel (returns whether content is flagged).
  Future<bool> runMockTest(String text) async {
    lastPayload = text;
    lastStage = 'mock_test';

    final String? matched = ThreatValidator.findThreatMatch(text);
    if (matched == null) {
      lastStage = 'mock_no_match';
      lastMatchedWord = null;
      return false;
    }

    lastMatchedWord = matched;
    lastStage = 'mock_match';
    return true;
  }
}
