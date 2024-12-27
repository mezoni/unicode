import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:unicode/unicode.dart' as unicode;
import 'package:unicode/unicode.dart';

Future<void> main() async {
  await _testDatabase();
  _testRunes();
  _testStringToLetterCase();
  _testCharToLetterCase();
}

const categoryNames = {
  'Cn': 'NOT_ASSIGNED',
  'Cc': 'CONTROL',
  'Cf': 'FORMAT',
  'Co': 'PRIVATE_USE',
  'Cs': 'SURROGATE',
  'Ll': 'LOWER_CASE_LETTER',
  'Lm': 'MODIFIER_LETTER',
  'Lo': 'OTHER_LETTER',
  'Lt': 'TITLE_CASE_LETTER',
  'Lu': 'UPPER_CASE_LETTER',
  'Mc': 'SPACING_MARK',
  'Me': 'ENCLOSING_MARK',
  'Mn': 'NONSPACING_MARK',
  'Nd': 'DECIMAL_NUMBER',
  'Nl': 'LETTER_NUMBER',
  'No': 'OTHER_NUMBER',
  'Pc': 'CONNECTOR_PUNCTUATION',
  'Pd': 'DASH_PUNCTUATION',
  'Pe': 'CLOSE_PUNCTUATION',
  'Pf': 'FINAL_PUNCTUATION',
  'Pi': 'INITIAL_PUNCTUATION',
  'Po': 'OTHER_PUNCTUATION',
  'Ps': 'OPEN_PUNCTUATION',
  'Sc': 'CURRENCY_SYMBOL',
  'Sk': 'MODIFIER_SYMBOL',
  'Sm': 'MATH_SYMBOL',
  'So': 'OTHER_SYMBOL',
  'Zl': 'LINE_SEPARATOR',
  'Zp': 'PARAGRAPH_SEPARATOR',
  'Zs': 'SPACE_SEPARATOR'
};

Future<String> _getDatabaseSource() async {
  final file = File('../UCD/UnicodeData.txt');
  return file.readAsString();
}

Future<void> _testDatabase() async {
  test('Unicode', () async {
    final source = await _getDatabaseSource();
    final lines = const LineSplitter().convert(source);
    final categoryIds = <String, int>{};
    var categoryId = 0;
    for (final key in categoryNames.keys) {
      categoryIds[key] = categoryId++;
    }

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.startsWith('#') || line.isEmpty) {
        continue;
      }

      final fields = line.split(';');
      final character = int.parse(fields[0], radix: 16);
      final category = fields[2];

      void testCategory(bool Function(int c) f) {
        final actual = f(character);
        expect(actual, true,
            reason: 'Is category: name: $category, character: $character');
      }

      switch (category) {
        case 'Cn':
          testCategory(unicode.isNotAssigned);
        case 'Cc':
          testCategory(unicode.isControl);
        case 'Cf':
          testCategory(unicode.isFormat);
        case 'Co':
          testCategory(unicode.isPrivateUse);
        case 'Cs':
          testCategory(unicode.isSurrogate);
        case 'Ll':
          testCategory(unicode.isLowerCaseLetter);
        case 'Lm':
          testCategory(unicode.isModifierLetter);
        case 'Lo':
          testCategory(unicode.isOtherLetter);
        case 'Lt':
          testCategory(unicode.isTitleCaseLetter);
        case 'Lu':
          testCategory(unicode.isUpperCaseLetter);
        case 'Mc':
          testCategory(unicode.isSpacingMark);
        case 'Me':
          testCategory(unicode.isEnclosingMark);
        case 'Mn':
          testCategory(unicode.isNonspacingMark);
        case 'Nd':
          testCategory(unicode.isDecimalNumber);
        case 'Nl':
          testCategory(unicode.isLetterNumber);
        case 'No':
          testCategory(unicode.isOtherNumber);
        case 'Pc':
          testCategory(unicode.isConnectorPunctuation);
        case 'Pd':
          testCategory(unicode.isDashPunctuation);
        case 'Pe':
          testCategory(unicode.isClosePunctuation);
        case 'Pf':
          testCategory(unicode.isFinalPunctuation);
        case 'Pi':
          testCategory(unicode.isInitialPunctuation);
        case 'Po':
          testCategory(unicode.isOtherPunctuation);
        case 'Ps':
          testCategory(unicode.isOpenPunctuation);
        case 'Sc':
          testCategory(unicode.isCurrencySymbol);
        case 'Sk':
          testCategory(unicode.isModifierSymbol);
        case 'Sm':
          testCategory(unicode.isMathSymbol);
        case 'So':
          testCategory(unicode.isOtherSymbol);
        case 'Zl':
          testCategory(unicode.isLineSeparator);
        case 'Zp':
          testCategory(unicode.isParagraphSeparator);
        case 'Zs':
          testCategory(unicode.isSpaceSeparator);
      }

      if (fields[12].isNotEmpty) {
        final upperCase = int.parse(fields[12], radix: 16);
        final r = charToUpperCase(character);
        expect(r, upperCase, reason: 'charToUpperCase(): $character');
      }

      if (fields[13].isNotEmpty) {
        final lowerCase = int.parse(fields[13], radix: 16);
        final r = charToLowerCase(character);
        expect(r, lowerCase, reason: 'charToLowerCase(): $character');
      }

      if (fields[14].isNotEmpty) {
        final titleCase = int.parse(fields[14], radix: 16);
        final r = charToTitleCase(character);
        expect(r, titleCase, reason: 'charToTitleCase(): $character');
      }
    }
  });
}

void _testCharToLetterCase() {
  test('Char to letter case', () {
    {
      final r1 = toRune('а');
      final r2 = charToUpperCase(r1);
      final r3 = toRune('А');
      expect(r2, r3, reason: 'charToUpperCase()');
    }
    {
      final r1 = toRune('А');
      final r2 = charToLowerCase(r1);
      final r3 = toRune('а');
      expect(r2, r3, reason: 'charToLowerCase()');
    }
    {
      final r1 = toRune('а');
      final r2 = charToTitleCase(r1);
      final r3 = toRune('А');
      expect(r2, r3, reason: 'charToTitleCase()');
    }
    {
      final r1 = toRune('ǆ');
      final r2 = charToUpperCase(r1);
      final r3 = toRune('Ǆ');
      expect(r2, r3, reason: 'charToUpperCase()');
    }
    {
      final r1 = toRune('Ǆ');
      final r2 = charToLowerCase(r1);
      final r3 = toRune('ǆ');
      expect(r2, r3, reason: 'charToLowerCase()');
    }
    {
      final r1 = toRune('ǆ');
      final r2 = charToTitleCase(r1);
      final r3 = toRune('ǅ');
      expect(r2, r3, reason: 'charToTitleCase()');
    }
    {
      final r1 = toRune('Ǆ');
      final r2 = charToTitleCase(r1);
      final r3 = toRune('ǅ');
      expect(r2, r3, reason: 'charToTitleCase()');
    }
  });
}

void _testRunes() {
  test('Runes', () {
    {
      const string = '🚀';
      expect(toRune(string), 128640, reason: 'toRune: $string');
    }
    {
      const string = '';
      expect(() => toRune(string), throwsA(isA<ArgumentError>()),
          reason: 'toRune: $string');
    }
    {
      const string = '🚀';
      expect(toRunes(string), [128640], reason: 'toRune: $string');
    }
    {
      const string = '';
      expect(toRunes(string), <int>[], reason: 'toRune: $string');
    }
  });
}

void _testStringToLetterCase() {
  test('String to letter case', () {
    {
      const r1 = 'привет, андрей!';
      final r2 = toUpperCase(r1);
      const r3 = 'ПРИВЕТ, АНДРЕЙ!';
      expect(r2, r3, reason: 'toUpperCase()');
    }
    {
      const r1 = 'ПРИВЕТ, АНДРЕЙ!';
      final r2 = toLowerCase(r1);
      const r3 = 'привет, андрей!';
      expect(r2, r3, reason: 'toLowerCase()');
    }
    {
      const r1 = 'привет, андрей!';
      final r2 = toTitleCase(r1);
      const r3 = 'ПРИВЕТ, АНДРЕЙ!';
      expect(r2, r3, reason: 'toTitleCase()');
    }
    {
      const r1 = 'ǆ';
      final r2 = toUpperCase(r1);
      const r3 = 'Ǆ';
      expect(r2, r3, reason: 'toUpperCase()');
    }
    {
      const r1 = 'Ǆ';
      final r2 = toLowerCase(r1);
      const r3 = 'ǆ';
      expect(r2, r3, reason: 'toLowerCase()');
    }
    {
      const r1 = 'ǆ';
      final r2 = toTitleCase(r1);
      const r3 = 'ǅ';
      expect(r2, r3, reason: 'toTitleCase()');
    }
    {
      const r1 = 'Ǆ';
      final r2 = toTitleCase(r1);
      const r3 = 'ǅ';
      expect(r2, r3, reason: 'toTitleCase()');
    }
  });
}
