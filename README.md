unicode
=======

This package is no longer supported because it was flagged by Google Dart developers as being published by an unknown person.  
Publisher Unknown.  
As a normal person, I believe that hardly anyone would want to use software from unknown publishers.  

Unicode characters library auto generated from http://www.unicode.org.

Unicode Version 13.0.0

Example:

```dart
import 'package:unicode/unicode.dart' as unicode;

void main(List<String> args) {
  var ch = unicode.toRune('я');
  if (unicode.isLowercaseLetter(ch)) {
    print(char2Str(ch) + ' is lowercase letter');
  }

  ch = unicode.toRune('{');
  if (unicode.isOpenPunctuation(ch)) {
    print(char2Str(ch) + ' is open punctuation');
  }

  ch = unicode.toRune('©');
  if (unicode.isOtherSymbol(ch)) {
    print(char2Str(ch) + ' is other symbol');
  }

  ch = unicode.toRune('ǁ');
  if (unicode.isOtherLetter(ch)) {
    print(char2Str(ch) + ' is other letter');
  }
}

String char2Str(int c) {
  return String.fromCharCode(c);
}

```
