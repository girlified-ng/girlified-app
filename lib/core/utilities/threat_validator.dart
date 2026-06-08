import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class ThreatValidator {
  /// Case-insensitive word-boundary matching for threatening terms.
  static final RegExp threatRegExp = RegExp(
    r'\b(kill|hurt|stalk|stalking|threat|threaten|threatening|attack|abuse|harass|harassment|bully|bullying|violence|violent|hate|weapon)\b',
    caseSensitive: false,
  );

  /// Returns the matched threatening word, or null if the text is safe.
  static String? findThreatMatch(String text) {
    if (text.trim().isEmpty) return null;
    final Match? match = threatRegExp.firstMatch(text);
    return match?.group(0);
  }

  /// Validates text and triggers the overlay blocker when a threat is found.
  static Future<bool> validateAndBlock(String text) async {
    final String? matched = findThreatMatch(text);
    if (matched == null) return false;

    print("[SAFETY_BLOCK] Threatening word matched: '$matched' in text: '$text'");
    await triggerOverlayBlocker(matchedWord: matched);
    return true;
  }

  /// Shows the full-screen overlay window immediately on threat detection.
  static Future<void> triggerOverlayBlocker({String? matchedWord}) async {
    try {
      if (matchedWord != null) {
        print("[SAFETY_BLOCK] Triggering overlay for matched word: '$matchedWord'");
      }

      final bool isGranted = await FlutterOverlayWindow.isPermissionGranted();
      if (!isGranted) {
        print("[SAFETY_BLOCK] Overlay permission not granted — requesting…");
        await FlutterOverlayWindow.requestPermission();
        return;
      }

      final bool isActive = await FlutterOverlayWindow.isActive();
      if (isActive) {
        print("[SAFETY_BLOCK] Overlay already active — content remains blocked.");
        return;
      }

      await FlutterOverlayWindow.showOverlay(
        enableDrag: false,
        flag: OverlayFlag.defaultFlag,
        alignment: OverlayAlignment.center,
        height: WindowSize.fullCover,
        width: WindowSize.fullCover,
        overlayTitle: 'SaifeAI Protection',
        overlayContent: matchedWord != null
            ? 'Blocked threatening content: $matchedWord'
            : 'Harmful content blocked',
      );
      print("[SAFETY_BLOCK] Overlay window triggered successfully.");
    } catch (e, stack) {
      print("[SAFETY_BLOCK] Error triggering overlay window: $e\n$stack");
    }
  }
}
