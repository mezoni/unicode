import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class FractionDecomposer extends Decomposer {
  const FractionDecomposer();

  @override
  List<int>? decompose(int character) {
    if (character < 0 || character > 1114111) {
      throw RangeError.range(character, 0, 1114111, 'character');
    }

    final result = _data[character];
    return result?.toList();
  }
}

SparseList<List<int>?> _unpack(List<(int, List<int>)> data) {
  final list = <(int, int, List<int>)>[];
  var prev = 0;
  for (var i = 0; i < data.length; i++) {
    final element = data[i];
    final code = element.$1 + prev;
    list.add((code, code, element.$2));
    prev = code;
  }

  return SparseList(list, null, length: 0x110000);
}

final _data = _unpack(const [(188, [49, 8260, 52]), (1, [49, 8260, 50]), (1, [51, 8260, 52]), (8338, [49, 8260, 55]), (1, [49, 8260, 57]), (1, [49, 8260, 49, 48]), (1, [49, 8260, 51]), (1, [50, 8260, 51]), (1, [49, 8260, 53]), (1, [50, 8260, 53]), (1, [51, 8260, 53]), (1, [52, 8260, 53]), (1, [49, 8260, 54]), (1, [53, 8260, 54]), (1, [49, 8260, 56]), (1, [51, 8260, 56]), (1, [53, 8260, 56]), (1, [55, 8260, 56]), (1, [49, 8260]), (42, [48, 8260, 51])]);
