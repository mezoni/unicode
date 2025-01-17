import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class MedialDecomposer extends Decomposer {
  const MedialDecomposer();

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

final _data = _unpack(const [(64341, [1659]), (4, [1662]), (4, [1664]), (4, [1658]), (4, [1663]), (4, [1657]), (4, [1700]), (4, [1702]), (4, [1668]), (4, [1667]), (4, [1670]), (4, [1671]), (16, [1705]), (4, [1711]), (4, [1715]), (4, [1713]), (6, [1723]), (6, [1729]), (4, [1726]), (41, [1709]), (17, [1744]), (2, [1609]), (22, [1740]), (224, [1574, 1605]), (1, [1574, 1607]), (1, [1576, 1605]), (1, [1576, 1607]), (1, [1578, 1605]), (1, [1578, 1607]), (1, [1579, 1605]), (1, [1579, 1607]), (1, [1587, 1605]), (1, [1587, 1607]), (1, [1588, 1605]), (1, [1588, 1607]), (1, [1603, 1604]), (1, [1603, 1605]), (1, [1604, 1605]), (1, [1606, 1605]), (1, [1606, 1607]), (1, [1610, 1605]), (1, [1610, 1607]), (1, [1600, 1614, 1617]), (1, [1600, 1615, 1617]), (1, [1600, 1616, 1617]), (64, [1587, 1580]), (1, [1587, 1581]), (1, [1587, 1582]), (1, [1588, 1580]), (1, [1588, 1581]), (1, [1588, 1582]), (1, [1591, 1605]), (1, [1592, 1605]), (310, [1600, 1611]), (6, [1600, 1614]), (2, [1600, 1615]), (2, [1600, 1616]), (2, [1600, 1617]), (2, [1600, 1618]), (13, [1574]), (6, [1576]), (6, [1578]), (4, [1579]), (4, [1580]), (4, [1581]), (4, [1582]), (12, [1587]), (4, [1588]), (4, [1589]), (4, [1590]), (4, [1591]), (4, [1592]), (4, [1593]), (4, [1594]), (4, [1601]), (4, [1602]), (4, [1603]), (4, [1604]), (4, [1605]), (4, [1606]), (4, [1607]), (8, [1610])]);
