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
