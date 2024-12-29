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
