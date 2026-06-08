import 'dart:async';

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
      print('[SAFETY_PIPELINE] Native already blocked screen; syncing Flutter overlay for "$keyword"');
      if (keyword.isNotEmpty) {
        await ThreatValidator.triggerOverlayBlocker(matchedWord: keyword);
      }
    } else if (eventType == 'content_blocked') {
      lastStage = 'native_block:${event['data']}';
      print('[SAFETY_PIPELINE] Native redaction overlay active for ${event['data']}');
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
    print('[SAFETY_PIPELINE] Validating ${texts.length} scraped strings from $package');

    for (final dynamic raw in texts) {
      final String text = raw.toString();
      if (text.trim().isEmpty) continue;

      lastPayload = text.length > 120 ? '${text.substring(0, 120)}…' : text;
      print('[SAFETY_PIPELINE] Checking: "$lastPayload"');

      final String? matched = ThreatValidator.findThreatMatch(text);
      if (matched != null) {
        lastMatchedWord = matched;
        lastStage = 'match_found';
        print('[SAFETY_PIPELINE] Match "$matched" — triggering overlay immediately');
        await ThreatValidator.triggerOverlayBlocker(matchedWord: matched);
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
