import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:girlified/data/services/digital_safeguard_service.dart';

/// Reads user keywords from GetStorage (`protection_keywords`) and builds matchers.
class ProtectionKeywordStore {
  ProtectionKeywordStore._();

  static const String storageKey = 'protection_keywords';

  /// Reads the keyword list fresh from GetStorage on every call.
  static List<String> readKeywords() {
    final dynamic raw = GetStorage().read(storageKey);
    if (raw is! List) return [];

    return raw
        .map((e) => e.toString().trim().toLowerCase())
        .where((k) => k.isNotEmpty)
        .toList();
  }

  /// Builds a case-insensitive RegExp from [keywords].
  /// Single words use word boundaries; phrases use literal matching.
  static RegExp? buildMatcher(List<String> keywords) {
    if (keywords.isEmpty) return null;

    final patterns = <String>[];
    for (final String keyword in keywords) {
      final String escaped = RegExp.escape(keyword);
      patterns.add(keyword.contains(' ') ? escaped : '\\b$escaped\\b');
    }

    return RegExp(patterns.join('|'), caseSensitive: false);
  }

  /// Returns the first stored keyword found in [text], or null.
  static String? findMatch(String text) {
    return findMatchIn(text, readKeywords());
  }

  /// Matches [text] against an explicit keyword list (used by tests and hot paths).
  static String? findMatchIn(String text, List<String> keywords) {
    if (text.trim().isEmpty || keywords.isEmpty) return null;

    final RegExp? matcher = buildMatcher(keywords);
    if (matcher == null) return null;

    final Match? match = matcher.firstMatch(text);
    return match?.group(0);
  }

  /// Persists keywords to GetStorage and syncs them to the native accessibility service.
  static Future<void> saveAndSync(List<String> keywords) async {
    final List<String> normalized = keywords
        .map((k) => k.trim().toLowerCase())
        .where((k) => k.isNotEmpty)
        .toList();

    await GetStorage().write(storageKey, normalized);
    await DigitalSafeguardService().startDigitalSafeguard(normalized);

    try {
      FlutterBackgroundService().invoke('updateKeywords');
    } catch (_) {
      // Background service may not be running yet.
    }

    print('[SAFETY_KEYWORDS] Saved ${normalized.length} keywords to GetStorage and native prefs');
  }
}
