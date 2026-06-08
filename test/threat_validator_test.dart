import 'package:flutter_test/flutter_test.dart';
import 'package:girlified/core/utilities/threat_validator.dart';

void main() {
  group('ThreatValidator', () {
    test('detects lowercase threatening words', () {
      expect(ThreatValidator.findThreatMatch('I will kill you'), 'kill');
      expect(ThreatValidator.findThreatMatch('do not hurt me'), 'hurt');
      expect(ThreatValidator.findThreatMatch('someone might stalk her'), 'stalk');
    });

    test('detects uppercase and mixed-case threatening words', () {
      expect(ThreatValidator.findThreatMatch('KILL'), 'KILL');
      expect(ThreatValidator.findThreatMatch('HuRt'), 'HuRt');
      expect(ThreatValidator.findThreatMatch('STALK'), 'STALK');
    });

    test('detects threatening words inside sentences', () {
      expect(
        ThreatValidator.findThreatMatch('This is a threatening text'),
        'threatening',
      );
    });

    test('does not match substrings inside other words', () {
      expect(ThreatValidator.findThreatMatch('skillful skating'), isNull);
      expect(ThreatValidator.findThreatMatch('hurtsville'), isNull);
    });

    test('detects bullying and harassment words', () {
      expect(ThreatValidator.findThreatMatch('stop bullying me'), 'bullying');
      expect(ThreatValidator.findThreatMatch('online harassment is wrong'), 'harassment');
      expect(ThreatValidator.findThreatMatch('do not threaten her'), 'threaten');
    });

    test('returns null for safe text', () {
      expect(ThreatValidator.findThreatMatch('Hello, have a nice day'), isNull);
      expect(ThreatValidator.findThreatMatch(''), isNull);
    });
  });
}
