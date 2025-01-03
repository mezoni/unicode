import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class SquareDecomposer extends Decomposer {
  const SquareDecomposer();

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

final _data = _unpack(const [(12880, [80, 84, 69]), (124, [72, 103]), (1, [101, 114, 103]), (1, [101, 86]), (1, [76, 84, 68]), (48, [20196, 21644]), (1, [12450, 12497, 12540, 12488]), (1, [12450, 12523, 12501, 12449]), (1, [12450, 12531, 12506, 12450]), (1, [12450, 12540, 12523]), (1, [12452, 12491, 12531, 12464]), (1, [12452, 12531, 12481]), (1, [12454, 12457, 12531]), (1, [12456, 12473, 12463, 12540, 12489]), (1, [12456, 12540, 12459, 12540]), (1, [12458, 12531, 12473]), (1, [12458, 12540, 12512]), (1, [12459, 12452, 12522]), (1, [12459, 12521, 12483, 12488]), (1, [12459, 12525, 12522, 12540]), (1, [12460, 12525, 12531]), (1, [12460, 12531, 12510]), (1, [12462, 12460]), (1, [12462, 12491, 12540]), (1, [12461, 12517, 12522, 12540]), (1, [12462, 12523, 12480, 12540]), (1, [12461, 12525]), (1, [12461, 12525, 12464, 12521, 12512]), (1, [12461, 12525, 12513, 12540, 12488, 12523]), (1, [12461, 12525, 12527, 12483, 12488]), (1, [12464, 12521, 12512]), (1, [12464, 12521, 12512, 12488, 12531]), (1, [12463, 12523, 12476, 12452, 12525]), (1, [12463, 12525, 12540, 12493]), (1, [12465, 12540, 12473]), (1, [12467, 12523, 12490]), (1, [12467, 12540, 12509]), (1, [12469, 12452, 12463, 12523]), (1, [12469, 12531, 12481, 12540, 12512]), (1, [12471, 12522, 12531, 12464]), (1, [12475, 12531, 12481]), (1, [12475, 12531, 12488]), (1, [12480, 12540, 12473]), (1, [12487, 12471]), (1, [12489, 12523]), (1, [12488, 12531]), (1, [12490, 12494]), (1, [12494, 12483, 12488]), (1, [12495, 12452, 12484]), (1, [12497, 12540, 12475, 12531, 12488]), (1, [12497, 12540, 12484]), (1, [12496, 12540, 12524, 12523]), (1, [12500, 12450, 12473, 12488, 12523]), (1, [12500, 12463, 12523]), (1, [12500, 12467]), (1, [12499, 12523]), (1, [12501, 12449, 12521, 12483, 12489]), (1, [12501, 12451, 12540, 12488]), (1, [12502, 12483, 12471, 12455, 12523]), (1, [12501, 12521, 12531]), (1, [12504, 12463, 12479, 12540, 12523]), (1, [12506, 12477]), (1, [12506, 12491, 12498]), (1, [12504, 12523, 12484]), (1, [12506, 12531, 12473]), (1, [12506, 12540, 12472]), (1, [12505, 12540, 12479]), (1, [12509, 12452, 12531, 12488]), (1, [12508, 12523, 12488]), (1, [12507, 12531]), (1, [12509, 12531, 12489]), (1, [12507, 12540, 12523]), (1, [12507, 12540, 12531]), (1, [12510, 12452, 12463, 12525]), (1, [12510, 12452, 12523]), (1, [12510, 12483, 12495]), (1, [12510, 12523, 12463]), (1, [12510, 12531, 12471, 12519, 12531]), (1, [12511, 12463, 12525, 12531]), (1, [12511, 12522]), (1, [12511, 12522, 12496, 12540, 12523]), (1, [12513, 12460]), (1, [12513, 12460, 12488, 12531]), (1, [12513, 12540, 12488, 12523]), (1, [12516, 12540, 12489]), (1, [12516, 12540, 12523]), (1, [12518, 12450, 12531]), (1, [12522, 12483, 12488, 12523]), (1, [12522, 12521]), (1, [12523, 12500, 12540]), (1, [12523, 12540, 12502, 12523]), (1, [12524, 12512]), (1, [12524, 12531, 12488, 12466, 12531]), (1, [12527, 12483, 12488]), (26, [104, 80, 97]), (1, [100, 97]), (1, [65, 85]), (1, [98, 97, 114]), (1, [111, 86]), (1, [112, 99]), (1, [100, 109]), (1, [100, 109, 178]), (1, [100, 109, 179]), (1, [73, 85]), (1, [24179, 25104]), (1, [26157, 21644]), (1, [22823, 27491]), (1, [26126, 27835]), (1, [26666, 24335, 20250, 31038]), (1, [112, 65]), (1, [110, 65]), (1, [956, 65]), (1, [109, 65]), (1, [107, 65]), (1, [75, 66]), (1, [77, 66]), (1, [71, 66]), (1, [99, 97, 108]), (1, [107, 99, 97, 108]), (1, [112, 70]), (1, [110, 70]), (1, [956, 70]), (1, [956, 103]), (1, [109, 103]), (1, [107, 103]), (1, [72, 122]), (1, [107, 72, 122]), (1, [77, 72, 122]), (1, [71, 72, 122]), (1, [84, 72, 122]), (1, [956, 8467]), (1, [109, 8467]), (1, [100, 8467]), (1, [107, 8467]), (1, [102, 109]), (1, [110, 109]), (1, [956, 109]), (1, [109, 109]), (1, [99, 109]), (1, [107, 109]), (1, [109, 109, 178]), (1, [99, 109, 178]), (1, [109, 178]), (1, [107, 109, 178]), (1, [109, 109, 179]), (1, [99, 109, 179]), (1, [109, 179]), (1, [107, 109, 179]), (1, [109, 8725, 115]), (1, [109, 8725, 115, 178]), (1, [80, 97]), (1, [107, 80, 97]), (1, [77, 80, 97]), (1, [71, 80, 97]), (1, [114, 97, 100]), (1, [114, 97, 100, 8725, 115]), (1, [114, 97, 100, 8725, 115, 178]), (1, [112, 115]), (1, [110, 115]), (1, [956, 115]), (1, [109, 115]), (1, [112, 86]), (1, [110, 86]), (1, [956, 86]), (1, [109, 86]), (1, [107, 86]), (1, [77, 86]), (1, [112, 87]), (1, [110, 87]), (1, [956, 87]), (1, [109, 87]), (1, [107, 87]), (1, [77, 87]), (1, [107, 937]), (1, [77, 937]), (1, [97, 46, 109, 46]), (1, [66, 113]), (1, [99, 99]), (1, [99, 100]), (1, [67, 8725, 107, 103]), (1, [67, 111, 46]), (1, [100, 66]), (1, [71, 121]), (1, [104, 97]), (1, [72, 80]), (1, [105, 110]), (1, [75, 75]), (1, [75, 77]), (1, [107, 116]), (1, [108, 109]), (1, [108, 110]), (1, [108, 111, 103]), (1, [108, 120]), (1, [109, 98]), (1, [109, 105, 108]), (1, [109, 111, 108]), (1, [80, 72]), (1, [112, 46, 109, 46]), (1, [80, 80, 77]), (1, [80, 82]), (1, [115, 114]), (1, [83, 118]), (1, [87, 98]), (1, [86, 8725, 109]), (1, [65, 8725, 109]), (32, [103, 97, 108]), (113969, [65]), (1, [66]), (1, [67]), (1, [68]), (1, [69]), (1, [70]), (1, [71]), (1, [72]), (1, [73]), (1, [74]), (1, [75]), (1, [76]), (1, [77]), (1, [78]), (1, [79]), (1, [80]), (1, [81]), (1, [82]), (1, [83]), (1, [84]), (1, [85]), (1, [86]), (1, [87]), (1, [88]), (1, [89]), (1, [90]), (1, [72, 86]), (1, [77, 86]), (1, [83, 68]), (1, [83, 83]), (1, [80, 80, 86]), (1, [87, 67]), (65, [68, 74]), (112, [12411, 12363]), (1, [12467, 12467]), (1, [12469]), (14, [25163]), (1, [23383]), (1, [21452]), (1, [12487]), (1, [20108]), (1, [22810]), (1, [35299]), (1, [22825]), (1, [20132]), (1, [26144]), (1, [28961]), (1, [26009]), (1, [21069]), (1, [24460]), (1, [20877]), (1, [26032]), (1, [21021]), (1, [32066]), (1, [29983]), (1, [36009]), (1, [22768]), (1, [21561]), (1, [28436]), (1, [25237]), (1, [25429]), (1, [19968]), (1, [19977]), (1, [36938]), (1, [24038]), (1, [20013]), (1, [21491]), (1, [25351]), (1, [36208]), (1, [25171]), (1, [31105]), (1, [31354]), (1, [21512]), (1, [28288]), (1, [26377]), (1, [26376]), (1, [30003]), (1, [21106]), (1, [21942]), (1, [37197])]);
