unicode
=======

Unicode characters library auto generated from http://www.unicode.org.

Version 1.1.5

Unicode Version 16.0.0

Example:

```dart
import 'package:unicode/blocks.dart';
import 'package:unicode/decomposer.dart';
import 'package:unicode/decomposers/circle.dart';
import 'package:unicode/decomposers/font.dart';
import 'package:unicode/decomposers/wide.dart';
import 'package:unicode/unicode.dart' as unicode;

void main(List<String> args) {
  var ch = unicode.toRune('я');
  if (unicode.isLowerCaseLetter(ch)) {
    print('${char2Str(ch)} is lowercase letter');
  }

  ch = unicode.toRune('{');
  if (unicode.isOpenPunctuation(ch)) {
    print('${char2Str(ch)} is open punctuation');
  }

  ch = unicode.toRune('©');
  if (unicode.isOtherSymbol(ch)) {
    print('${char2Str(ch)} is other symbol');
  }

  ch = unicode.toRune('ǁ');
  if (unicode.isOtherLetter(ch)) {
    print('${char2Str(ch)} is other letter');
  }

  ch = 'ソ'.c;
  final block = getUnicodeBlock(ch);
  if (block == UnicodeBlock.katakana) {
    print('${char2Str(ch)} is katakana');
  }

  ch = unicode.charToTitleCase(unicode.toRune('ǆ'));
  print('${char2Str(ch)} is title case of ǆ');

  ch = unicode.charToUpperCase(unicode.toRune('ǆ'));
  print('${char2Str(ch)} is upper case of ǆ');

  const s1 =
      '𝑻𝒉𝒆 ℚ𝕦𝕚𝕔𝕜 Ｂｒｏｗｎ 🅵🅾🆇 𝔍𝔲𝔪𝔭𝔢𝔡 ⓞⓥⓔⓡ ʇɥǝ 𝗟𝗮𝘇𝘆 𝙳𝚘𝚐';
  final s2 = decompose(s1, _decomposers);
  print(s1);
  print(s2);

  const s3 = "Hello, world! i am 'foo'";
  final s4 = _replaceAll(s3, '', const [
    unicode.lowerCaseLetter,
    unicode.upperCaseLetter,
    unicode.spaceSeparator,
    unicode.otherLetter,
    unicode.modifierLetter,
    unicode.titleCaseLetter,
  ]);

  print(s3);
  print(s4);
}

final _decomposer1 = LetterMappingDecomposer([
  ('ʇ'.c, 't'.c),
  ('ɥ'.c, 'h'.c),
  ('ǝ'.c, 'e'.c),
]);

final _decomposer2 = LetterCasingDecomposer([
  ('🅰'.c, '🆉'.c, 'A'.c - '🅰'.c),
]);

final _decomposers = [
  const FontDecomposer(),
  const WideDecomposer(),
  const CircleDecomposer(),
  _decomposer2,
  _decomposer1,
];

String char2Str(int c) {
  return String.fromCharCode(c);
}

String _replaceAll(String str, String replace, List<int> allowedCategories) {
  final codePoints = <int>[];
  final replaceRunes = replace.runes.toList();
  for (final rune in str.runes) {
    final category = unicode.generalCategories[rune];
    var done = false;
    for (var i = 0; i < allowedCategories.length; i++) {
      if (category == allowedCategories[i]) {
        done = true;
        codePoints.add(rune);
        break;
      }
    }

    if (!done) {
      if (replaceRunes.isNotEmpty) {
        codePoints.addAll(replaceRunes);
      }
    }
  }

  return String.fromCharCodes(codePoints);
}

extension on String {
  int get c => unicode.toRune(this);
}

```

Output:

```
я is lowercase letter
{ is open punctuation
© is other symbol
ǁ is other letter
ソ is katakana
ǅ is title case of ǆ
Ǆ is upper case of ǆ
𝑻𝒉𝒆 ℚ𝕦𝕚𝕔𝕜 Ｂｒｏｗｎ 🅵🅾🆇 𝔍𝔲𝔪𝔭𝔢𝔡 ⓞⓥⓔⓡ ʇɥǝ 𝗟𝗮𝘇𝘆 𝙳𝚘𝚐
The Quick Brown FOX Jumped over the Lazy Dog
Hello, world! i am 'foo'
Hello world i am foo
```
