const int _asciiEnd = 0x7f;

const int _digit = 0x1;

const int _lower = 0x2;

const int _underscore = 0x4;

const int _upper = 0x8;

const int _alpha = _lower | _upper;

const int _alphaNum = _alpha | _digit;

final List<int> _ascii = <int>[
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  8,
  0,
  0,
  0,
  0,
  4,
  0,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  0
];

String camelize(String string, [bool lower = false]) {
  if (string.isEmpty) {
    return string;
  }

  string = string.toLowerCase();
  var capitalize = true;
  final length = string.length;
  var position = 0;
  var remove = false;
  final sb = StringBuffer();
  for (var i = 0; i < length; i++) {
    final s = string[i];
    final c = s.codeUnitAt(0);
    var flag = 0;
    if (c <= _asciiEnd) {
      flag = _ascii[c];
    }

    if (capitalize && flag & _alpha != 0) {
      if (lower && position == 0) {
        sb.write(s);
      } else {
        sb.write(s.toUpperCase());
      }

      capitalize = false;
      remove = true;
      position++;
    } else {
      if (flag & _underscore != 0) {
        if (!remove) {
          sb.write(s);
          remove = true;
        }

        capitalize = true;
      } else {
        if (flag & _alphaNum != 0) {
          capitalize = false;
          remove = true;
        } else {
          capitalize = true;
          remove = false;
          position = 0;
        }

        sb.write(s);
      }
    }
  }

  return sb.toString();
}
