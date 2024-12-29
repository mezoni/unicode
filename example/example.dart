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
