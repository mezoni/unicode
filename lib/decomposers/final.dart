import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class FinalDecomposer extends Decomposer {
  const FinalDecomposer();

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

final _data = _unpack(const [(64337, [1649]), (2, [1659]), (4, [1662]), (4, [1664]), (4, [1658]), (4, [1663]), (4, [1657]), (4, [1700]), (4, [1702]), (4, [1668]), (4, [1667]), (4, [1670]), (4, [1671]), (4, [1677]), (2, [1676]), (2, [1678]), (2, [1672]), (2, [1688]), (2, [1681]), (2, [1705]), (4, [1711]), (4, [1715]), (4, [1713]), (4, [1722]), (2, [1723]), (4, [1728]), (2, [1729]), (4, [1726]), (4, [1746]), (2, [1747]), (35, [1709]), (4, [1735]), (2, [1734]), (2, [1736]), (3, [1739]), (2, [1733]), (2, [1737]), (2, [1744]), (6, [1574, 1575]), (2, [1574, 1749]), (2, [1574, 1608]), (2, [1574, 1735]), (2, [1574, 1734]), (2, [1574, 1736]), (2, [1574, 1744]), (3, [1574, 1609]), (3, [1740]), (103, [1574, 1585]), (1, [1574, 1586]), (1, [1574, 1605]), (1, [1574, 1606]), (1, [1574, 1609]), (1, [1574, 1610]), (1, [1576, 1585]), (1, [1576, 1586]), (1, [1576, 1605]), (1, [1576, 1606]), (1, [1576, 1609]), (1, [1576, 1610]), (1, [1578, 1585]), (1, [1578, 1586]), (1, [1578, 1605]), (1, [1578, 1606]), (1, [1578, 1609]), (1, [1578, 1610]), (1, [1579, 1585]), (1, [1579, 1586]), (1, [1579, 1605]), (1, [1579, 1606]), (1, [1579, 1609]), (1, [1579, 1610]), (1, [1601, 1609]), (1, [1601, 1610]), (1, [1602, 1609]), (1, [1602, 1610]), (1, [1603, 1575]), (1, [1603, 1604]), (1, [1603, 1605]), (1, [1603, 1609]), (1, [1603, 1610]), (1, [1604, 1605]), (1, [1604, 1609]), (1, [1604, 1610]), (1, [1605, 1575]), (1, [1605, 1605]), (1, [1606, 1585]), (1, [1606, 1586]), (1, [1606, 1605]), (1, [1606, 1606]), (1, [1606, 1609]), (1, [1606, 1610]), (1, [1609, 1648]), (1, [1610, 1585]), (1, [1610, 1586]), (1, [1610, 1605]), (1, [1610, 1606]), (1, [1610, 1609]), (1, [1610, 1610]), (123, [1591, 1609]), (1, [1591, 1610]), (1, [1593, 1609]), (1, [1593, 1610]), (1, [1594, 1609]), (1, [1594, 1610]), (1, [1587, 1609]), (1, [1587, 1610]), (1, [1588, 1609]), (1, [1588, 1610]), (1, [1581, 1609]), (1, [1581, 1610]), (1, [1580, 1609]), (1, [1580, 1610]), (1, [1582, 1609]), (1, [1582, 1610]), (1, [1589, 1609]), (1, [1589, 1610]), (1, [1590, 1609]), (1, [1590, 1610]), (1, [1588, 1580]), (1, [1588, 1581]), (1, [1588, 1582]), (1, [1588, 1605]), (1, [1588, 1585]), (1, [1587, 1585]), (1, [1589, 1585]), (1, [1590, 1585]), (16, [1575, 1611]), (21, [1578, 1581, 1580]), (7, [1580, 1605, 1581]), (2, [1581, 1605, 1610]), (1, [1581, 1605, 1609]), (3, [1587, 1580, 1609]), (1, [1587, 1605, 1581]), (3, [1587, 1605, 1605]), (2, [1589, 1581, 1581]), (2, [1589, 1605, 1605]), (1, [1588, 1581, 1605]), (2, [1588, 1580, 1610]), (1, [1588, 1605, 1582]), (2, [1588, 1605, 1605]), (2, [1590, 1581, 1609]), (1, [1590, 1582, 1605]), (2, [1591, 1605, 1581]), (3, [1591, 1605, 1610]), (1, [1593, 1580, 1605]), (1, [1593, 1605, 1605]), (2, [1593, 1605, 1609]), (1, [1594, 1605, 1605]), (1, [1594, 1605, 1610]), (1, [1594, 1605, 1609]), (1, [1601, 1582, 1605]), (2, [1602, 1605, 1581]), (1, [1602, 1605, 1605]), (1, [1604, 1581, 1605]), (1, [1604, 1581, 1610]), (1, [1604, 1581, 1609]), (2, [1604, 1580, 1580]), (1, [1604, 1582, 1605]), (2, [1604, 1605, 1581]), (4, [1605, 1581, 1610]), (11, [1606, 1581, 1609]), (1, [1606, 1580, 1605]), (2, [1606, 1580, 1609]), (1, [1606, 1605, 1610]), (1, [1606, 1605, 1609]), (1, [1610, 1605, 1605]), (2, [1576, 1582, 1610]), (1, [1578, 1580, 1610]), (1, [1578, 1580, 1609]), (1, [1578, 1582, 1610]), (1, [1578, 1582, 1609]), (1, [1578, 1605, 1610]), (1, [1578, 1605, 1609]), (1, [1580, 1605, 1610]), (1, [1580, 1581, 1609]), (1, [1580, 1605, 1609]), (1, [1587, 1582, 1609]), (1, [1589, 1581, 1610]), (1, [1588, 1581, 1610]), (1, [1590, 1581, 1610]), (1, [1604, 1580, 1610]), (1, [1604, 1605, 1610]), (1, [1610, 1581, 1610]), (1, [1610, 1580, 1610]), (1, [1610, 1605, 1610]), (1, [1605, 1605, 1610]), (1, [1602, 1605, 1610]), (1, [1606, 1581, 1610]), (3, [1593, 1605, 1610]), (1, [1603, 1605, 1610]), (2, [1605, 1582, 1610]), (2, [1603, 1605, 1605]), (1, [1604, 1580, 1605]), (1, [1606, 1580, 1581]), (1, [1580, 1581, 1610]), (1, [1581, 1580, 1610]), (1, [1605, 1580, 1610]), (1, [1601, 1605, 1610]), (1, [1576, 1581, 1610]), (4, [1587, 1582, 1610]), (1, [1606, 1580, 1610]), (187, [1570]), (2, [1571]), (2, [1572]), (2, [1573]), (2, [1574]), (4, [1575]), (2, [1576]), (4, [1577]), (2, [1578]), (4, [1579]), (4, [1580]), (4, [1581]), (4, [1582]), (4, [1583]), (2, [1584]), (2, [1585]), (2, [1586]), (2, [1587]), (4, [1588]), (4, [1589]), (4, [1590]), (4, [1591]), (4, [1592]), (4, [1593]), (4, [1594]), (4, [1601]), (4, [1602]), (4, [1603]), (4, [1604]), (4, [1605]), (4, [1606]), (4, [1607]), (4, [1608]), (2, [1609]), (2, [1610]), (4, [1604, 1570]), (2, [1604, 1571]), (2, [1604, 1573]), (2, [1604, 1575])]);
