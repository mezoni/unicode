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
