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
