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
