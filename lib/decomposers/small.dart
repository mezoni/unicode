import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class SmallDecomposer extends Decomposer {
  const SmallDecomposer();

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

final _data = _unpack(const [(65104, [44]), (1, [12289]), (1, [46]), (2, [59]), (1, [58]), (1, [63]), (1, [33]), (1, [8212]), (1, [40]), (1, [41]), (1, [123]), (1, [125]), (1, [12308]), (1, [12309]), (1, [35]), (1, [38]), (1, [42]), (1, [43]), (1, [45]), (1, [60]), (1, [62]), (1, [61]), (2, [92]), (1, [36]), (1, [37]), (1, [64])]);
