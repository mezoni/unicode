import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

/// The simplest non-recursive decomposition algorithm.
///
/// For example, it can be used to decompose characters with a specified font
/// variant.
String decompose(String source, List<Decomposer> decomposers) {
  final list = <int>[];
  final runes = source.runes;
  for (final rune in runes) {
    var done = false;
    for (var i = 0; i < decomposers.length; i++) {
      final decomposer = decomposers[i];
      final characters = decomposer.decompose(rune);
      if (characters != null) {
        done = true;
        list.addAll(characters);
        break;
      }
    }

    if (!done) {
      list.add(rune);
    }
  }

  return String.fromCharCodes(list);
}

abstract class Decomposer {
  const Decomposer();

  List<int>? decompose(int character);

  List<(int, List<int>)> getMappingList();
}

class LetterCasingDecomposer extends Decomposer {
  final SparseList<int?> _data;

  LetterCasingDecomposer(List<(int, int, int)> ranges)
      : _data = SparseList(ranges, null, length: 0x110000);

  @override
  List<int>? decompose(int character) {
    if (character < 0 || character > 1114111) {
      throw RangeError.range(character, 0, 1114111, 'character');
    }

    final delta = _data[character];
    final result = delta == null ? null : [character + delta];
    return result;
  }

  @override
  List<(int, List<int>)> getMappingList() {
    final result = <(int, List<int>)>[];
    return UnmodifiableListView(result);
  }
}

class LetterMappingDecomposer extends Decomposer {
  final SparseList<int?> _data;

  LetterMappingDecomposer(List<(int, int)> ranges)
      : _data = SparseList(ranges.map((e) => (e.$1, e.$1, e.$2)).toList(), null,
            length: 0x110000);

  @override
  List<int>? decompose(int character) {
    if (character < 0 || character > 1114111) {
      throw RangeError.range(character, 0, 1114111, 'character');
    }

    final value = _data[character];
    final result = value == null ? null : [value];
    return result;
  }

  @override
  List<(int, List<int>)> getMappingList() {
    throw UnsupportedError('getMappingList()');
  }
}
