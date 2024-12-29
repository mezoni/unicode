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
