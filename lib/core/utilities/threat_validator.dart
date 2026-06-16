import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:girlified/core/utilities/protection_keyword_store.dart';

class ThreatValidator {
  /// Returns the matched user keyword from GetStorage, or null if the text is safe.
  static String? findThreatMatch(String text) {
    return ProtectionKeywordStore.findMatch(text);
  }

  /// Validates text and triggers the overlay blocker when a keyword is found.
  static Future<bool> validateAndBlock(String text) async {
    final String? matched = findThreatMatch(text);
    if (matched == null) return false;

    print("[SAFETY_BLOCK] User keyword matched: '$matched' in text: '$text'");
    await triggerOverlayBlocker(matchedWord: matched);
    return true;
  }

  /// Closes the Flutter "display over apps" overlay if it is still open.
  static Future<void> closeOverlayIfActive() async {
    try {
      final bool isActive = await FlutterOverlayWindow.isActive();
      if (isActive) {
        await FlutterOverlayWindow.closeOverlay();
        print('[SAFETY_BLOCK] Closed stray Flutter overlay');
      }
    } catch (e) {
      print('[SAFETY_BLOCK] Error closing overlay: $e');
    }
  }

  /// Shows the full-screen overlay window immediately on threat detection.
  static Future<void> triggerOverlayBlocker({String? matchedWord}) async {
    try {
      if (matchedWord != null) {
        print("[SAFETY_BLOCK] Triggering overlay for matched keyword: '$matchedWord'");
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
            ? 'Blocked content matching: $matchedWord'
            : 'Harmful content blocked',
      );
      print("[SAFETY_BLOCK] Overlay window triggered successfully.");
    } catch (e, stack) {
      print("[SAFETY_BLOCK] Error triggering overlay window: $e\n$stack");
    }
  }
}
