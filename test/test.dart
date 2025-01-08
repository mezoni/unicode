import 'dart:convert';
import 'dart:io';

import 'package:sequence_processor/sequence_processor.dart';
import 'package:test/test.dart';
import 'package:unicode/emoji/emoji.dart';
import 'package:unicode/unicode.dart' as unicode;
import 'package:unicode/unicode.dart';

Future<void> main() async {
  await _testDatabase();
  _testRunes();
  _testStringToLetterCase();
  _testCharToLetterCase();
  _testEmoji();

  group('Category', () {
    test('Other Letter', () {
      for (final char in '名字'.runes) {
        expect(unicode.isOtherLetter(char), isTrue);
      }

      // Symbol
      expect(unicode.isOtherLetter('⺁'.runes.first), isFalse);
    });

    test('Other Symbol', () {
      for (final char in '⺁'.runes) {
        expect(unicode.isOtherSymbol(char), isTrue);
      }

      expect(unicode.isOtherSymbol('名'.runes.first), isFalse);
    });
  });
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

Future<void> _testDatabase() async {
  test('Unicode', () async {
    final source = await _getDatabaseSource();
    final lines = const LineSplitter().convert(source);
    final categoryIds = <String, int>{};
    var categoryId = 0;
    for (final key in categoryNames.keys) {
      categoryIds[key] = categoryId++;
    }

    // https://www.unicode.org/reports/tr44/#Code_Point_Ranges
    bool isStartRange(String name) =>
        name.startsWith('<') && name.endsWith(', First>');
    bool isEndRange(String name) =>
        name.startsWith('<') && name.endsWith(', Last>');

    int? rangeStart;
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.startsWith('#') || line.isEmpty) {
        continue;
      }

      final fields = line.split(';');
      final code = int.parse(fields[0], radix: 16);
      final name = fields[1];

      final ({int start, int end}) range;

      if (rangeStart != null) {
        assert(isEndRange(name), 'Expecting end range $line');
        range = (start: rangeStart, end: code);
        rangeStart = null;
      } else {
        if (isStartRange(name)) {
          rangeStart = code;
          continue;
        }
        range = (start: code, end: code);
      }

      final category = fields[2];

      for (var character = range.start; character <= range.end; character++) {
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
    }
  });
}

void _testEmoji() {
  final emojis = getUnicodeEmojiList();
  final processor = SequenceProcessor<int, Emoji>();
  for (final emoji in emojis) {
    processor.addSequence(emoji.codePoints, emoji);
  }

  test('Emoji', () {
    {
      expect(emojis.length, 5042, reason: 'Emoji list length');

      final count = emojis.map((e) => e.name).toSet().length;
      expect(count, 3790, reason: 'Emoji name count');
    }
    {
      const r1 = 'I 💗 you! ❤️‍🔥 ';
      final r2 = processor.process(r1.runes.toList());
      final foundEmojis = r2.where((e) => e.data is Emoji).toList();
      expect(foundEmojis.length, 2, reason: 'Emoji count');
      expect(foundEmojis[0].index, 2, reason: 'Emoji 1 index');
      expect(foundEmojis[1].index, 9, reason: 'Emoji 2 index');
      expect(
          foundEmojis
              .map((e) => String.fromCharCodes(e.data!.codePoints))
              .toList(),
          ['💗', '❤️‍🔥'],
          reason: 'Found emojis');
      expect(
          r2
              .where((e) => e.data is! Emoji)
              .map((e) => String.fromCharCode(e.element!))
              .join(),
          'I  you!  ',
          reason: 'Text without emoji');
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
