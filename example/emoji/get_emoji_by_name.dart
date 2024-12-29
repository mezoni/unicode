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
