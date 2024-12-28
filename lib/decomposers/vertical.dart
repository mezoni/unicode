import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class VerticalDecomposer extends Decomposer {
  const VerticalDecomposer();

  @override
  List<int>? decompose(int character) {
    if (character < 0 || character > 1114111) {
      throw RangeError.range(character, 0, 1114111, 'character');
    }

    final result = _data[character];
    return result?.toList();
  }

  @override
  List<(int, List<int>)> getMappingList() {
    final groups = _data.getGroups();
    final result = groups.map((e) => (e.$1, e.$3!));
    return UnmodifiableListView(result);
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

final _data = _unpack(const [(12447, [12424, 12426]), (96, [12467, 12488]), (52497, [44]), (1, [12289]), (1, [12290]), (1, [58]), (1, [59]), (1, [33]), (1, [63]), (1, [12310]), (1, [12311]), (1, [8230]), (23, [8229]), (1, [8212]), (1, [8211]), (1, [95]), (1, [95]), (1, [40]), (1, [41]), (1, [123]), (1, [125]), (1, [12308]), (1, [12309]), (1, [12304]), (1, [12305]), (1, [12298]), (1, [12299]), (1, [12296]), (1, [12297]), (1, [12300]), (1, [12301]), (1, [12302]), (1, [12303]), (3, [91]), (1, [93])]);
