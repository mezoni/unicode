import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class NoBreakDecomposer extends Decomposer {
  const NoBreakDecomposer();

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

final _data = _unpack(const [(160, [32]), (3692, [3851]), (4347, [32]), (10, [8208]), (30, [32])]);
