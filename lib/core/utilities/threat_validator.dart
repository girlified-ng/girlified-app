import 'package:girlified/core/utilities/protection_keyword_store.dart';

class ThreatValidator {
  /// Returns the matched user keyword from GetStorage, or null if the text is safe.
  static String? findThreatMatch(String text) {
    return ProtectionKeywordStore.findMatch(text);
  }

  /// Returns true when [text] matches a stored keyword (no overlay — inline mask handles UI).
  static Future<bool> validateAndBlock(String text) async {
    final String? matched = findThreatMatch(text);
    if (matched == null) return false;

    print("[SAFETY_BLOCK] User keyword matched: '$matched' in text: '$text'");
    return true;
  }
}
