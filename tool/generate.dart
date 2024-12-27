import 'dart:io';

import 'package:simple_sparse_list/ranges_helper.dart';

import 'camelize.dart';

void main(List<String> args) {
  _generate();
  _generateBlocks();
}

const _template = r'''
import 'package:simple_sparse_list/simple_sparse_list.dart';

{{constants}}

enum UnicodeCategory {
  {{unicode_category_data}}
}

/// List used to map a character to a category identifier.
final SparseList<int> generalCategories = _generalCategories;

/// Converts a [character] to lowercase.
int charToLowerCase(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  final delta = _lowerCaseList[character];
  return delta == null ? character : character + delta;
}

/// Converts a [character] to titlecase.
int charToTitleCase(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  final delta = _titleCaseList[character];
  return delta == null ? character : character + delta;
}

/// Converts a [character] to uppercase.
int charToUpperCase(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  final delta = _upperCaseList[character];
  return delta == null ? character : character + delta;
}

/// Returns the general Unicode category as [UnicodeCategory]
UnicodeCategory getUnicodeCategory(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  final index = generalCategories[character];
  final result = UnicodeCategory.values[index];
  return result;
}

{{matchers}}

/// Converts a [string] to lowercase.
String toLowerCase(String string) => _toLetterCase(string, _lowerCaseList);

/// Converts a [string] to titlecase.
String toTitleCase(String string) => _toLetterCase(string, _titleCaseList);

/// Converts a [string] to uppercase.
String toUpperCase(String string) => _toLetterCase(string, _upperCaseList);

int toRune(String string) => string.isEmpty
    ? throw ArgumentError('An empty string contains no elements')
    : string.runes.first;

List<int> toRunes(String string) => string.runes.toList();

int _getCategory(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  return generalCategories[character];
}

String _toLetterCase(String string, SparseList<int?> letterCaseList) {
  final runes = toRunes(string);
  final length = runes.length;
  for (var i = 0; i < length; i++) {
    final rune = runes[i];
    final delta = letterCaseList[rune];
    if (delta != null) {
      runes[i] = rune + delta;
    }
  }

  return String.fromCharCodes(runes);
}

SparseList<int> _unpack(List<List<int>> data) {
  var ranges = <(int, int, int)>[];
  for (var i = 0; i < data.length; i++) {
    final category = data[i];
    var prev = 0;
    for (var j = 0; j < category.length; j += 2) {
      final start = category[j] + prev;
      prev = start;
      final end = category[j + 1] + prev;
      prev = end;
      ranges.add((start, end, i));
    }
  }

  ranges = ranges.toList();
  ranges.sort((a, b) {
    if (a.$1 != b.$1) {
      return a.$1.compareTo(b.$1);
    }

    return a.$2.compareTo(b.$2);
  });

  final list = SparseList(ranges, 0);
  return list;
}

final _lowerCaseList = SparseList([{{lower_case_list}}], null);

final _titleCaseList = SparseList([{{title_case_list}}], null);

final _upperCaseList = SparseList([{{upper_case_list}}], null);

final SparseList<int> _generalCategories = _unpack({{data}});
''';

void _generate() {
  const categoryNames = {
    'Cn': 'NOT_ASSIGNED',
    'Cc': 'CONTROL',
    'Cf': 'FORMAT',
    'Co': 'PRIVATE_USE',
    'Cs': 'SURROGATE',
    'Ll': 'LOWER_CASE_LETTER',
    'Lm': 'MODIFIER_LETTER',
    'Lo': 'OTHER_LETTER',
    'Lt': 'TITLE_CASE_LETTER',
    'Lu': 'UPPER_CASE_LETTER',
    'Mc': 'SPACING_MARK',
    'Me': 'ENCLOSING_MARK',
    'Mn': 'NONSPACING_MARK',
    'Nd': 'DECIMAL_NUMBER',
    'Nl': 'LETTER_NUMBER',
    'No': 'OTHER_NUMBER',
    'Pc': 'CONNECTOR_PUNCTUATION',
    'Pd': 'DASH_PUNCTUATION',
    'Pe': 'CLOSE_PUNCTUATION',
    'Pf': 'FINAL_PUNCTUATION',
    'Pi': 'INITIAL_PUNCTUATION',
    'Po': 'OTHER_PUNCTUATION',
    'Ps': 'OPEN_PUNCTUATION',
    'Sc': 'CURRENCY_SYMBOL',
    'Sk': 'MODIFIER_SYMBOL',
    'Sm': 'MATH_SYMBOL',
    'So': 'OTHER_SYMBOL',
    'Zl': 'LINE_SEPARATOR',
    'Zp': 'PARAGRAPH_SEPARATOR',
    'Zs': 'SPACE_SEPARATOR'
  };

  final file = File('../UCD/UnicodeData.txt');
  final lines = file.readAsLinesSync();
  var categories = <String, List<(int, int)>>{};
  var lowerCaseLetters = <int, List<(int, int)>>{};
  var upperCaseLetters = <int, List<(int, int)>>{};
  var titleCaseLetters = <int, List<(int, int)>>{};
  final decompositions = <String, Map<int, List<int>>>{};
  for (final line in lines) {
    if (line.startsWith('#') || line.isEmpty) {
      continue;
    }

    final fields = line.split(';');
    final code = int.parse(fields[0], radix: 16);
    final category = fields[2];
    (categories[category] ??= []).add((code, code));
    if (fields[12].isNotEmpty) {
      final delta = int.parse(fields[12], radix: 16) - code;
      (upperCaseLetters[delta] ??= []).add((code, code));
    }

    if (fields[13].isNotEmpty) {
      final delta = int.parse(fields[13], radix: 16) - code;
      (lowerCaseLetters[delta] ??= []).add((code, code));
    }

    if (fields[14].isNotEmpty) {
      final delta = int.parse(fields[14], radix: 16) - code;
      (titleCaseLetters[delta] ??= []).add((code, code));
    }

    if (fields[5].isNotEmpty) {
      final decomposition = fields[5];
      final index = decomposition.indexOf('>');
      var form = '';
      if (index != -1) {
        form = decomposition.substring(1, index);
      }

      final sequenceText =
          index == -1 ? decomposition : decomposition.substring(index + 1);
      final codes = sequenceText
          .trim()
          .split(' ')
          .map((e) => int.parse(e, radix: 16))
          .toList();
      (decompositions[form] ??= {})[code] = codes;
    }
  }

  categories = _normalize(categories);
  lowerCaseLetters = _normalize(lowerCaseLetters);
  upperCaseLetters = _normalize(upperCaseLetters);
  titleCaseLetters = _normalize(titleCaseLetters);
  final categoryIndexes = <String, int>{};
  var index = 0;
  for (final key in categoryNames.keys) {
    categoryIndexes[key] = index++;
  }

  var template = _template;
  final packedList = <String>[];
  for (final name in categoryNames.keys) {
    final ranges = categories[name] ?? [];
    final packed = _pack(ranges).join(', ');
    packedList.add('[$packed]');
  }

  template = template.replaceAll('{{data}}', '[${packedList.join(', ')}]');

  final constantList = <String>[];
  final matcherList = <String>[];
  for (var entry in categoryNames.entries) {
    final categoryId = entry.key;
    final categoryName = entry.value;
    final name = camelize(categoryName);
    final lowerCaseName = camelize(categoryName, true);
    final categoryIndex = categoryIndexes[categoryId];
    final codespace = categoryName.toLowerCase().replaceAll('_', ' ');
    constantList.add('''
/// An identifier of Unicode category '$categoryId'.
const $lowerCaseName = $categoryIndex;''');
    matcherList.add('''
/// Checks if a [character] is in the Unicode codespace '$codespace' ($categoryId).
bool is$name(int character) => _getCategory(character) == $lowerCaseName;''');
  }

  template = template.replaceAll('{{constants}}', constantList.join('\n\n'));
  template = template.replaceAll('{{matchers}}', matcherList.join('\n\n'));

  template = template.replaceAll('{{unicode_category_data}}',
      categoryNames.values.map((e) => camelize(e, true)).join(',\n  '));

  final letterCaseVariants = {
    'lower_case': lowerCaseLetters,
    'title_case': titleCaseLetters,
    'upper_case': upperCaseLetters,
  };
  for (var entry in letterCaseVariants.entries) {
    final letterCaseName = entry.key;
    final mapping = entry.value;
    final deltas = <(int, int), int>{};
    for (var entry in mapping.entries) {
      final delta = entry.key;
      final ranges = entry.value;
      for (var range in ranges) {
        deltas[range] = delta;
      }
    }

    final keyName = '{{${letterCaseName}_list}}';
    final code = deltas.entries
        .map((e) => '(${e.key.$1}, ${e.key.$2}, ${e.value})')
        .join(', ');
    template = template.replaceAll(keyName, code);
  }

  File('lib/unicode.dart').writeAsStringSync(template);

  for (final entry in decompositions.entries) {
    final decompositionData = <(int, List<int>)>[];
    final decompositionType = entry.key;
    final mapping = entry.value;
    for (final element in mapping.entries) {
      final codePoint = element.key;
      final codePoints = element.value;
      decompositionData.add((codePoint, codePoints));
    }

    final typeName =
        decompositionType.isEmpty ? 'canonical' : decompositionType;
    final snakeCaseName = _toSnakeCase(typeName);
    final camelizedName = camelize(snakeCaseName);
    final packedData = _packDecompositionData(decompositionData);
    final packedDataCode =
        packedData.map((e) => '(${e.$1}, [${e.$2.join(', ')}])').join(', ');
    var template = '''
import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class {{camelizedName}}Decomposer extends Decomposer {
  const {{camelizedName}}Decomposer();

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
    final code = element.\$1 + prev;
    list.add((code, code, element.\$2));
    prev = code;
  }

  return SparseList(list, null, length: 0x110000);
}

final _data = _unpack(const [{{packed_data}}]);
''';

    template = template.replaceAll('{{camelizedName}}', camelizedName);
    template = template.replaceAll('{{packed_data}}', packedDataCode);
    final filename = 'lib//decomposers/$snakeCaseName.dart';
    File(filename).writeAsStringSync(template);
  }
}

Map<K, List<(int, int)>> _normalize<K>(Map<K, List<(int, int)>> data) {
  final result = <K, List<(int, int)>>{};
  for (final entry in data.entries) {
    final key = entry.key;
    final value = entry.value;
    final ranges = normalizeRanges(value);
    result[key] = ranges;
  }

  return result;
}

List<int> _pack(List<(int, int)> ranges) {
  final result = <int>[];
  var prev = 0;
  for (final range in ranges) {
    final start = range.$1;
    final end = range.$2;
    var value = start - prev;
    result.add(value);
    prev = start;
    value = end - prev;
    result.add(value);
    prev = end;
  }

  return result;
}

List<(int, List<int>)> _packDecompositionData(List<(int, List<int>)> data) {
  final result = <(int, List<int>)>[];
  var last = 0;
  for (var i = 0; i < data.length; i++) {
    final element = data[i];
    final code = element.$1;
    final codes = element.$2;
    result.add((code - last, codes));
    last = code;
  }

  return result;
}

String _toSnakeCase(String s) {
  final buffer = StringBuffer();
  final runes = s.runes;
  for (final rune in runes) {
    final s1 = String.fromCharCode(rune);
    if (s1 == s1.toUpperCase()) {
      buffer.write('_');
      buffer.write(s1.toLowerCase());
    } else {
      buffer.write(s1);
    }
  }

  return buffer.toString();
}

void _generateBlocks() {
  final file = File('../UCD/Blocks.txt');
  final lines = file.readAsLinesSync();
  final rangeMap = <String, (int, int)>{};
  final aliasMap = <String, String>{};
  for (final line in lines) {
    if (line.startsWith('#') || line.isEmpty) {
      continue;
    }

    final fields = line.split(';');
    final fieldRange = fields[0];
    final fieldName = fields[1];
    final name = fieldName.trim();
    final blockRanges = fieldRange.split('..');
    final range = (
      int.parse(blockRanges[0], radix: 16),
      int.parse(blockRanges[1], radix: 16),
    );
    rangeMap[name] = range;
    var alias = name;
    alias = alias.replaceAll('-', ' ');
    alias = alias.replaceAll('_', ' ');
    final aliasParts = alias.split(' ');
    var firstAliasPart = aliasParts[0];
    if (firstAliasPart == firstAliasPart.toUpperCase()) {
      firstAliasPart = firstAliasPart.toLowerCase();
    } else {
      firstAliasPart =
          firstAliasPart[0].toLowerCase() + firstAliasPart.substring(1);
    }

    aliasParts[0] = firstAliasPart;
    aliasMap[name] = aliasParts.join();
  }

  final enumValues = rangeMap.keys.map((e) => aliasMap[e]).toList();
  enumValues.add('noBlock');
  enumValues.sort();
  final data = rangeMap.entries.map((e) {
    return '(${e.value.$1}, ${e.value.$2}, UnicodeBlock.${aliasMap[e.key]})';
  });

  final template = '''
import 'package:simple_sparse_list/simple_sparse_list.dart';

UnicodeBlock getUnicodeBlock(int character) {
  if (character < 0 || character > 1114111) {
    throw RangeError.range(character, 0, 1114111, 'character');
  }

  final result = _data[character];
  return result;
}

enum UnicodeBlock {${enumValues.join(', ')}}

final _data = SparseList([${data.join(', ')}], UnicodeBlock.noBlock);
''';

  File('lib/blocks.dart').writeAsStringSync(template);
}
