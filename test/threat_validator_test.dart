import 'package:flutter_test/flutter_test.dart';
import 'package:girlified/core/utilities/protection_keyword_store.dart';

void main() {
  const keywords = [
    'kill',
    'hurt',
    'stalk',
    'bullying',
    'harassment',
    'throw shade',
    'kys',
  ];

  group('ProtectionKeywordStore dynamic matcher', () {
    test('matches single words case-insensitively', () {
      expect(ProtectionKeywordStore.findMatchIn('I will kill you', keywords), 'kill');
      expect(ProtectionKeywordStore.findMatchIn('do not HURT me', keywords), 'HURT');
      expect(ProtectionKeywordStore.findMatchIn('stop bullying me', keywords), 'bullying');
    });

    test('matches multi-word phrases', () {
      expect(
        ProtectionKeywordStore.findMatchIn('they always throw shade online', keywords),
        'throw shade',
      );
    });

    test('returns null when keyword list is empty', () {
      expect(ProtectionKeywordStore.findMatchIn('kill', []), isNull);
      expect(ProtectionKeywordStore.buildMatcher([]), isNull);
    });

    test('returns null for safe text', () {
      expect(ProtectionKeywordStore.findMatchIn('Hello, have a nice day', keywords), isNull);
    });
  });
}
