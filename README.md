unicode
=======

Unicode characters library auto generated from http://www.unicode.org.

Version 1.1.6

Unicode Version 16.0.0

Examples:

# example/example.dart

```dart
import 'package:unicode/blocks.dart';
import 'package:unicode/unicode.dart' as unicode;

void main(List<String> args) {
  var ch = unicode.toRune('я');
  if (unicode.isLowerCaseLetter(ch)) {
    print('${ch.s} is lowercase letter');
  }

  ch = unicode.toRune('{');
  if (unicode.isOpenPunctuation(ch)) {
    print('${ch.s} is open punctuation');
  }

  ch = unicode.toRune('©');
  if (unicode.isOtherSymbol(ch)) {
    print('${ch.s} is other symbol');
  }

  ch = unicode.toRune('ǁ');
  if (unicode.isOtherLetter(ch)) {
    print('${ch.s} is other letter');
  }

  ch = 'ソ'.c;
  final block = getUnicodeBlock(ch);
  if (block == UnicodeBlock.katakana) {
    print('${ch.s} is katakana');
  }

  ch = unicode.charToTitleCase(unicode.toRune('ǆ'));
  print('${ch.s} is title case of ǆ');

  ch = unicode.charToUpperCase(unicode.toRune('ǆ'));
  print('${ch.s} is upper case of ǆ');
}

extension on String {
  int get c => unicode.toRune(this);
}

extension on int {
  String get s => String.fromCharCode(this);
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
```

# example\emoji\decompose_characters.dart

```dart
import 'package:unicode/decomposer.dart';
import 'package:unicode/decomposers/circle.dart';
import 'package:unicode/decomposers/font.dart';
import 'package:unicode/decomposers/wide.dart';
import 'package:unicode/unicode.dart' as unicode;

void main(List<String> args) {
  const s1 =
      '𝑻𝒉𝒆 ℚ𝕦𝕚𝕔𝕜 Ｂｒｏｗｎ 🅵🅾🆇 𝔍𝔲𝔪𝔭𝔢𝔡 ⓞⓥⓔⓡ ʇɥǝ 𝗟𝗮𝘇𝘆 𝙳𝚘𝚐';
  final s2 = decompose(s1, _decomposers);
  print(s1);
  print(s2);
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

extension on String {
  int get c => unicode.toRune(this);
}

```

Output:

```
𝑻𝒉𝒆 ℚ𝕦𝕚𝕔𝕜 Ｂｒｏｗｎ 🅵🅾🆇 𝔍𝔲𝔪𝔭𝔢𝔡 ⓞⓥⓔⓡ ʇɥǝ 𝗟𝗮𝘇𝘆 𝙳𝚘𝚐
The Quick Brown FOX Jumped over the Lazy Dog
```

# example/get_emoji_by_name.dart

```dart
import 'dart:math';

import 'package:unicode/emoji/emoji.dart';

void main(List<String> args) {
  // The full names can be found here
  // https://unicode.org/Public/emoji/latest/emoji-test.txt
  print(heartWithArrow);
  print(raisedBackOfHand);
  print(smilingFaceWithHearts);
  print(redHeart);
  print(redHeartUnqualified);

  print('I $redHeart you!');

  final names = getUnicodeEmojiList().map((e) => e.name).toList();
  final names2 = <String>[];
  final r = Random();
  for (var i = 0; i < 10000; i++) {
    final value = r.nextInt(names.length - 1);
    names2.add(names[value]);
  }

  final sw = Stopwatch();
  sw.start();
  for (var i = 0; i < names2.length; i++) {
    final name = names2[i];
    // ignore: unused_local_variable
    final element = Emoji.findByName(name);
  }

  sw.stop();
  print('''
Performance test:
Info: Emoji.getByName()
Number of calls: ${names2.length}
Elapsed time (sec): ${sw.elapsedMilliseconds / 1000}''');
}

final heartWithArrow = _findEmoji('heart with arrow');

final raisedBackOfHand = _findEmoji('raised back of hand: light skin tone');

final redHeart = _findEmoji('red heart');

final redHeartUnqualified =
    _findEmoji('red heart', status: EmojiStatus.unqualified);

final smilingFaceWithHearts = _findEmoji('smiling face with hearts');

String _findEmoji(String fullname, {EmojiStatus? status}) {
  final emoji = Emoji.findByName(fullname, status: status);
  return emoji == null ? '�' : String.fromCharCodes(emoji.codePoints);
}

```

Output

```
💘
🤚🏻
🥰
❤️
❤
I ❤️ you!
Performance test:
Info: Emoji.getByName()
Number of calls: 10000
Elapsed time (sec): 0.015
```

# example/info_about_all_emoji.dart

```dart
import 'package:unicode/emoji/emoji.dart';

void main(List<String> args) {
  final emojis = getUnicodeEmojiList();
  final groups = <String, Set<String>>{};
  final names = <String>[];
  for (final element in emojis) {
    (groups[element.group] ??= {}).add(element.subgroup);
    names.add(element.name);
  }

  print('Total number of emojis: ${emojis.length}');
  print('Total number of unique emojis: ${names.toSet().length}');

  for (final group in groups.entries) {
    print(
        '${group.key}:\n${group.value.map((e) => '- $e (${e.length})').join('\n')}');
  }
}

```

Output:

```
Total number of emojis: 5042
Total number of unique emojis: 3790
Activities:
- award-medal (11)
- event (5)
- sport (5)
- arts & crafts (13)
- game (4)
Symbols:
- alphanum (8)
- transport-sign (14)
- zodiac (6)
- arrow (5)
- other-symbol (12)
- av-symbol (9)
- religion (8)
- warning (7)
- geometric (9)
- currency (8)
- math (4)
- punctuation (11)
- gender (6)
- keycap (6)
Travel & Places:
- place-building (14)
- transport-air (13)
- time (4)
- transport-ground (16)
- transport-water (15)
- place-other (11)
- place-geographic (16)
- hotel (5)
- place-religious (15)
- sky & weather (13)
- place-map (9)
People & Body:
- person-fantasy (14)
- hand-fingers-partial (20)
- body-parts (10)
- person-role (11)
- person (6)
- hand-single-finger (18)
- person-symbol (13)
- hands (5)
- family (6)
- person-gesture (14)
- hand-fingers-open (17)
- person-sport (12)
- hand-fingers-closed (19)
- person-activity (15)
- person-resting (14)
- hand-prop (9)
Animals & Nature:
- animal-reptile (14)
- animal-bug (10)
- animal-bird (11)
- animal-mammal (13)
- plant-flower (12)
- animal-marine (13)
- plant-other (11)
- animal-amphibian (16)
Smileys & Emotion:
- emotion (7)
- face-costume (12)
- face-negative (13)
- face-concerned (14)
- face-smiling (12)
- heart (5)
- cat-face (8)
- face-unwell (11)
- face-hat (8)
- face-neutral-skeptical (22)
- face-sleepy (11)
- face-affection (14)
- face-tongue (11)
- face-hand (9)
- face-glasses (12)
- monkey-face (11)
Objects:
- computer (8)
- musical-instrument (18)
- medical (7)
- science (7)
- tool (4)
- clothing (8)
- mail (4)
- office (6)
- household (9)
- sound (5)
- writing (7)
- book-paper (10)
- light & video (13)
- money (5)
- other-object (12)
- music (5)
- phone (5)
- lock (4)
Food & Drink:
- dishware (8)
- food-vegetable (14)
- drink (5)
- food-prepared (13)
- food-fruit (10)
- food-asian (10)
- food-sweet (10)
Component:
- hair-style (10)
- skin-tone (9)
Flags:
- flag (4)
- country-flag (12)
- subdivision-flag (16)
```

# example\emoji\remove_emoji.dart

```dart
import 'package:sequence_processor/sequence_processor.dart';
import 'package:unicode/emoji/emoji.dart';

void main(List<String> args) {
  const str = 'I 💗 you! 😘❤️‍🔥 ';
  print(str);
  print(_removeEmoji(str));
}

// Should be stored in a static member for performance reasons.
final _emojiProcessor = () {
  final emojis = getUnicodeEmojiList();
  final processor = SequenceProcessor<int, Emoji>();
  for (final emoji in emojis) {
    processor.addSequence(emoji.codePoints, emoji);
  }

  return processor;
}();

/// Removes emoji.
String _removeEmoji(String text) {
  if (text.isEmpty) {
    return '';
  }

  final elements = _emojiProcessor.process(text.runes.toList());
  final clean = elements.where((e) => e.data is! Emoji).map((e) => e.element!);
  return String.fromCharCodes(clean);
}

```

Output:

```
I 💗 you! 😘❤️‍🔥
I  you!
```

# example\emoji\separate_emoji_and_regular_text.dart

```dart
import 'package:sequence_processor/sequence_processor.dart';
import 'package:unicode/emoji/emoji.dart';

void main(List<String> args) {
  const str = 'I 💗 you! 😘❤️‍🔥 ';
  print(str);
  final parts = _separateEmoji(str);
  print(parts);
  for (final element in parts) {
    final kind = element.$1 ? 'Emoji:  ' : 'Regular:';
    print(
      '$kind "${element.$2}"',
    );
  }
}

// Should be stored in a static member for performance reasons.
final _emojiProcessor = () {
  final emojis = getUnicodeEmojiList();
  final processor = SequenceProcessor<int, Emoji>();
  for (final emoji in emojis) {
    processor.addSequence(emoji.codePoints, emoji);
  }

  return processor;
}();

/// Separates emoji and text.
List<(bool, String)> _separateEmoji(String text) {
  if (text.isEmpty) {
    return [];
  }

  final elements = _emojiProcessor.process(text.runes.toList());
  final result = <(bool, List<int>)>[];
  (bool, List<int>)? regular;
  (bool, List<int>)? emojis;
  for (final element in elements) {
    if (element.data is Emoji) {
      regular = null;
      if (emojis == null) {
        emojis = (true, []);
        result.add(emojis);
      }

      emojis.$2.addAll(element.sequence!);
    } else {
      emojis = null;
      if (regular == null) {
        regular = (false, []);
        result.add(regular);
      }

      regular.$2.add(element.element!);
    }
  }

  return result.map((e) => (e.$1, String.fromCharCodes(e.$2))).toList();
}

```

Output:

```
I 💗 you! 😘❤️‍🔥
[(false, I ), (true, 💗), (false,  you! ), (true, 😘❤️‍🔥), (false,  )]
Regular: "I "
Emoji:   "💗"
Regular: " you! "
Emoji:   "😘❤️‍🔥"
Regular: " "
```

# example\emoji\trim_last_characters.dart

```dart
import 'package:sequence_processor/sequence_processor.dart';
import 'package:unicode/decomposers/canonical.dart';
import 'package:unicode/emoji/emoji.dart';

void main(List<String> args) {
  var str = 'I 💗 you! 😘❤️‍🔥 ';
  print('"$str"');
  while (str.isNotEmpty) {
    str = _removeLastChars(str, 1);
    print('"$str"');
  }

  str = 'Amélie';
  print('"$str"');
  while (str.isNotEmpty) {
    str = _removeLastChars(str, 1);
    print('"$str"');
  }

  str = "Hello 😀 World";
  print('"$str"');
  while (str.isNotEmpty) {
    str = _removeLastChars(str, 1);
    print('"$str"');
  }
}

// Should be stored in a static member for performance reasons.
final _processor = () {
  final emojis = getUnicodeEmojiList();
  final processor = SequenceProcessor<int, Object>();
  for (final emoji in emojis) {
    processor.addSequence(emoji.codePoints, emoji);
  }

  // We will also use the mapping information of the canonical decomposition to
  // avoid changing canonically equivalent sequences.
  const decomposer = CanonicalDecomposer();
  final mappingList = decomposer.getMappingList();
  for (var i = 0; i < mappingList.length; i++) {
    final mapping = mappingList[i];
    final sequence = mapping.$2;
    if (sequence.length > 1) {
      if (!processor.hasSequence(sequence)) {
        processor.addSequence(sequence, mapping.$1);
      }
    }
  }

  return processor;
}();

String _removeLastChars(String text, int n) {
  if (text.isEmpty) {
    return '';
  }

  final result = _processor.process(text.runes.toList());
  if (result.length < n) {
    return '';
  }

  return result
      .take(result.length - n)
      .map((e) => e.data == null
          ? String.fromCharCode(e.element!)
          : String.fromCharCodes(e.sequence!))
      .join();
}

```

Output:

```
"I 💗 you! 😘❤️‍🔥 "
"I 💗 you! 😘❤️‍🔥"
"I 💗 you! 😘"
"I 💗 you! "
"I 💗 you!"
"I 💗 you"
"I 💗 yo"
"I 💗 y"
"I 💗 "
"I 💗"
"I "
"I"
""
"Amélie"
"Améli"
"Amél"
"Amé"
"Am"
"A"
""
"Hello 😀 World"
"Hello 😀 Worl"
"Hello 😀 Wor"
"Hello 😀 Wo"
"Hello 😀 W"
"Hello 😀 "
"Hello 😀"
"Hello "
"Hello"
"Hell"
"Hel"
"He"
"H"
""
```



Output:

```
```