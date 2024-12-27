import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class SubDecomposer extends Decomposer {
  const SubDecomposer();

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

final _data = _unpack(const [(7522, [105]), (1, [114]), (1, [117]), (1, [118]), (1, [946]), (1, [947]), (1, [961]), (1, [966]), (1, [967]), (790, [48]), (1, [49]), (1, [50]), (1, [51]), (1, [52]), (1, [53]), (1, [54]), (1, [55]), (1, [56]), (1, [57]), (1, [43]), (1, [8722]), (1, [61]), (1, [40]), (1, [41]), (2, [97]), (1, [101]), (1, [111]), (1, [120]), (1, [601]), (1, [104]), (1, [107]), (1, [108]), (1, [109]), (1, [110]), (1, [112]), (1, [115]), (1, [116]), (3040, [106]), (111573, [1072]), (1, [1073]), (1, [1074]), (1, [1075]), (1, [1076]), (1, [1077]), (1, [1078]), (1, [1079]), (1, [1080]), (1, [1082]), (1, [1083]), (1, [1086]), (1, [1087]), (1, [1089]), (1, [1091]), (1, [1092]), (1, [1093]), (1, [1094]), (1, [1095]), (1, [1096]), (1, [1098]), (1, [1099]), (1, [1169]), (1, [1110]), (1, [1109]), (1, [1119])]);
