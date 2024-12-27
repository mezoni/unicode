import 'dart:convert';
import 'dart:io';

import 'package:simple_sparse_list/ranges_helper.dart';

import 'camelize.dart';

Future<void> main(List<String> args) async {
  await _generate();
}

const _template = r'''
import 'package:simple_sparse_list/simple_sparse_list.dart';

{{constants}}

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

Future<void> _generate() async {
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

  final source = await _getDatabaseSource();
  final lines = const LineSplitter().convert(source);
  var categories = <String, List<(int, int)>>{};
  var lowerCaseLetters = <int, List<(int, int)>>{};
  var upperCaseLetters = <int, List<(int, int)>>{};
  var titleCaseLetters = <int, List<(int, int)>>{};
  for (final line in lines) {
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
    final codeSpace = categoryName.toLowerCase().replaceAll('_', ' ');
    //constantList.add('const $categoryName = $id;');
    constantList.add('const $lowerCaseName = $categoryIndex;');
    matcherList.add('''
/// Checks if a [character] is in the Unicode codespace '$codeSpace' ($categoryId).
bool is$name(int character) => _getCategory(character) == $lowerCaseName;''');
  }

  template = template.replaceAll('{{constants}}', constantList.join('\n\n'));
  template = template.replaceAll('{{matchers}}', matcherList.join('\n\n'));

  final letterCaseMaps = {
    'lower_case': lowerCaseLetters,
    'title_case': titleCaseLetters,
    'upper_case': upperCaseLetters,
  };
  for (var entry in letterCaseMaps.entries) {
    final name = entry.key;
    final letterCases = entry.value;
    final deltas = <(int, int), int>{};
    for (var entry in letterCases.entries) {
      final delta = entry.key;
      final ranges = entry.value;
      for (var range in ranges) {
        deltas[range] = delta;
      }
    }

    final keyName = '{{${name}_list}}';
    final code = deltas.entries
        .map((e) => '(${e.key.$1}, ${e.key.$2}, ${e.value})')
        .join(', ');
    template = template.replaceAll(keyName, code);
  }

  File('lib/unicode.dart').writeAsStringSync(template);
}

Future<String> _getDatabaseSource() async {
  final file = File('tool/UnicodeData.txt');
  return file.readAsString();
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
