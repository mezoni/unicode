import 'dart:collection';

import 'package:simple_sparse_list/simple_sparse_list.dart';

import '../decomposer.dart';

class CanonicalDecomposer extends Decomposer {
  const CanonicalDecomposer();

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

final _data = _unpack(const [(192, [65, 768]), (1, [65, 769]), (1, [65, 770]), (1, [65, 771]), (1, [65, 776]), (1, [65, 778]), (2, [67, 807]), (1, [69, 768]), (1, [69, 769]), (1, [69, 770]), (1, [69, 776]), (1, [73, 768]), (1, [73, 769]), (1, [73, 770]), (1, [73, 776]), (2, [78, 771]), (1, [79, 768]), (1, [79, 769]), (1, [79, 770]), (1, [79, 771]), (1, [79, 776]), (3, [85, 768]), (1, [85, 769]), (1, [85, 770]), (1, [85, 776]), (1, [89, 769]), (3, [97, 768]), (1, [97, 769]), (1, [97, 770]), (1, [97, 771]), (1, [97, 776]), (1, [97, 778]), (2, [99, 807]), (1, [101, 768]), (1, [101, 769]), (1, [101, 770]), (1, [101, 776]), (1, [105, 768]), (1, [105, 769]), (1, [105, 770]), (1, [105, 776]), (2, [110, 771]), (1, [111, 768]), (1, [111, 769]), (1, [111, 770]), (1, [111, 771]), (1, [111, 776]), (3, [117, 768]), (1, [117, 769]), (1, [117, 770]), (1, [117, 776]), (1, [121, 769]), (2, [121, 776]), (1, [65, 772]), (1, [97, 772]), (1, [65, 774]), (1, [97, 774]), (1, [65, 808]), (1, [97, 808]), (1, [67, 769]), (1, [99, 769]), (1, [67, 770]), (1, [99, 770]), (1, [67, 775]), (1, [99, 775]), (1, [67, 780]), (1, [99, 780]), (1, [68, 780]), (1, [100, 780]), (3, [69, 772]), (1, [101, 772]), (1, [69, 774]), (1, [101, 774]), (1, [69, 775]), (1, [101, 775]), (1, [69, 808]), (1, [101, 808]), (1, [69, 780]), (1, [101, 780]), (1, [71, 770]), (1, [103, 770]), (1, [71, 774]), (1, [103, 774]), (1, [71, 775]), (1, [103, 775]), (1, [71, 807]), (1, [103, 807]), (1, [72, 770]), (1, [104, 770]), (3, [73, 771]), (1, [105, 771]), (1, [73, 772]), (1, [105, 772]), (1, [73, 774]), (1, [105, 774]), (1, [73, 808]), (1, [105, 808]), (1, [73, 775]), (4, [74, 770]), (1, [106, 770]), (1, [75, 807]), (1, [107, 807]), (2, [76, 769]), (1, [108, 769]), (1, [76, 807]), (1, [108, 807]), (1, [76, 780]), (1, [108, 780]), (5, [78, 769]), (1, [110, 769]), (1, [78, 807]), (1, [110, 807]), (1, [78, 780]), (1, [110, 780]), (4, [79, 772]), (1, [111, 772]), (1, [79, 774]), (1, [111, 774]), (1, [79, 779]), (1, [111, 779]), (3, [82, 769]), (1, [114, 769]), (1, [82, 807]), (1, [114, 807]), (1, [82, 780]), (1, [114, 780]), (1, [83, 769]), (1, [115, 769]), (1, [83, 770]), (1, [115, 770]), (1, [83, 807]), (1, [115, 807]), (1, [83, 780]), (1, [115, 780]), (1, [84, 807]), (1, [116, 807]), (1, [84, 780]), (1, [116, 780]), (3, [85, 771]), (1, [117, 771]), (1, [85, 772]), (1, [117, 772]), (1, [85, 774]), (1, [117, 774]), (1, [85, 778]), (1, [117, 778]), (1, [85, 779]), (1, [117, 779]), (1, [85, 808]), (1, [117, 808]), (1, [87, 770]), (1, [119, 770]), (1, [89, 770]), (1, [121, 770]), (1, [89, 776]), (1, [90, 769]), (1, [122, 769]), (1, [90, 775]), (1, [122, 775]), (1, [90, 780]), (1, [122, 780]), (34, [79, 795]), (1, [111, 795]), (14, [85, 795]), (1, [117, 795]), (29, [65, 780]), (1, [97, 780]), (1, [73, 780]), (1, [105, 780]), (1, [79, 780]), (1, [111, 780]), (1, [85, 780]), (1, [117, 780]), (1, [220, 772]), (1, [252, 772]), (1, [220, 769]), (1, [252, 769]), (1, [220, 780]), (1, [252, 780]), (1, [220, 768]), (1, [252, 768]), (2, [196, 772]), (1, [228, 772]), (1, [550, 772]), (1, [551, 772]), (1, [198, 772]), (1, [230, 772]), (3, [71, 780]), (1, [103, 780]), (1, [75, 780]), (1, [107, 780]), (1, [79, 808]), (1, [111, 808]), (1, [490, 772]), (1, [491, 772]), (1, [439, 780]), (1, [658, 780]), (1, [106, 780]), (4, [71, 769]), (1, [103, 769]), (3, [78, 768]), (1, [110, 768]), (1, [197, 769]), (1, [229, 769]), (1, [198, 769]), (1, [230, 769]), (1, [216, 769]), (1, [248, 769]), (1, [65, 783]), (1, [97, 783]), (1, [65, 785]), (1, [97, 785]), (1, [69, 783]), (1, [101, 783]), (1, [69, 785]), (1, [101, 785]), (1, [73, 783]), (1, [105, 783]), (1, [73, 785]), (1, [105, 785]), (1, [79, 783]), (1, [111, 783]), (1, [79, 785]), (1, [111, 785]), (1, [82, 783]), (1, [114, 783]), (1, [82, 785]), (1, [114, 785]), (1, [85, 783]), (1, [117, 783]), (1, [85, 785]), (1, [117, 785]), (1, [83, 806]), (1, [115, 806]), (1, [84, 806]), (1, [116, 806]), (3, [72, 780]), (1, [104, 780]), (7, [65, 775]), (1, [97, 775]), (1, [69, 807]), (1, [101, 807]), (1, [214, 772]), (1, [246, 772]), (1, [213, 772]), (1, [245, 772]), (1, [79, 775]), (1, [111, 775]), (1, [558, 772]), (1, [559, 772]), (1, [89, 772]), (1, [121, 772]), (269, [768]), (1, [769]), (2, [787]), (1, [776, 769]), (48, [697]), (10, [59]), (7, [168, 769]), (1, [913, 769]), (1, [183]), (1, [917, 769]), (1, [919, 769]), (1, [921, 769]), (2, [927, 769]), (2, [933, 769]), (1, [937, 769]), (1, [970, 769]), (26, [921, 776]), (1, [933, 776]), (1, [945, 769]), (1, [949, 769]), (1, [951, 769]), (1, [953, 769]), (1, [971, 769]), (26, [953, 776]), (1, [965, 776]), (1, [959, 769]), (1, [965, 769]), (1, [969, 769]), (5, [978, 769]), (1, [978, 776]), (44, [1045, 768]), (1, [1045, 776]), (2, [1043, 769]), (4, [1030, 776]), (5, [1050, 769]), (1, [1048, 768]), (1, [1059, 774]), (11, [1048, 774]), (32, [1080, 774]), (23, [1077, 768]), (1, [1077, 776]), (2, [1075, 769]), (4, [1110, 776]), (5, [1082, 769]), (1, [1080, 768]), (1, [1091, 774]), (24, [1140, 783]), (1, [1141, 783]), (74, [1046, 774]), (1, [1078, 774]), (14, [1040, 774]), (1, [1072, 774]), (1, [1040, 776]), (1, [1072, 776]), (3, [1045, 774]), (1, [1077, 774]), (3, [1240, 776]), (1, [1241, 776]), (1, [1046, 776]), (1, [1078, 776]), (1, [1047, 776]), (1, [1079, 776]), (3, [1048, 772]), (1, [1080, 772]), (1, [1048, 776]), (1, [1080, 776]), (1, [1054, 776]), (1, [1086, 776]), (3, [1256, 776]), (1, [1257, 776]), (1, [1069, 776]), (1, [1101, 776]), (1, [1059, 772]), (1, [1091, 772]), (1, [1059, 776]), (1, [1091, 776]), (1, [1059, 779]), (1, [1091, 779]), (1, [1063, 776]), (1, [1095, 776]), (3, [1067, 776]), (1, [1099, 776]), (297, [1575, 1619]), (1, [1575, 1620]), (1, [1608, 1620]), (1, [1575, 1621]), (1, [1610, 1620]), (154, [1749, 1620]), (2, [1729, 1620]), (17, [1746, 1620]), (598, [2344, 2364]), (8, [2352, 2364]), (3, [2355, 2364]), (36, [2325, 2364]), (1, [2326, 2364]), (1, [2327, 2364]), (1, [2332, 2364]), (1, [2337, 2364]), (1, [2338, 2364]), (1, [2347, 2364]), (1, [2351, 2364]), (108, [2503, 2494]), (1, [2503, 2519]), (16, [2465, 2492]), (1, [2466, 2492]), (2, [2479, 2492]), (84, [2610, 2620]), (3, [2616, 2620]), (35, [2582, 2620]), (1, [2583, 2620]), (1, [2588, 2620]), (3, [2603, 2620]), (234, [2887, 2902]), (3, [2887, 2878]), (1, [2887, 2903]), (16, [2849, 2876]), (1, [2850, 2876]), (55, [2962, 3031]), (54, [3014, 3006]), (1, [3015, 3006]), (1, [3014, 3031]), (124, [3142, 3158]), (120, [3263, 3285]), (7, [3270, 3285]), (1, [3270, 3286]), (2, [3270, 3266]), (1, [3274, 3285]), (127, [3398, 3390]), (1, [3399, 3390]), (1, [3398, 3415]), (142, [3545, 3530]), (2, [3545, 3535]), (1, [3548, 3530]), (1, [3545, 3551]), (357, [3906, 4023]), (10, [3916, 4023]), (5, [3921, 4023]), (5, [3926, 4023]), (5, [3931, 4023]), (13, [3904, 4021]), (10, [3953, 3954]), (2, [3953, 3956]), (1, [4018, 3968]), (2, [4019, 3968]), (9, [3953, 3968]), (18, [3986, 4023]), (10, [3996, 4023]), (5, [4001, 4023]), (5, [4006, 4023]), (5, [4011, 4023]), (13, [3984, 4021]), (109, [4133, 4142]), (2784, [6917, 6965]), (2, [6919, 6965]), (2, [6921, 6965]), (2, [6923, 6965]), (2, [6925, 6965]), (4, [6929, 6965]), (41, [6970, 6965]), (2, [6972, 6965]), (3, [6974, 6965]), (1, [6975, 6965]), (2, [6978, 6965]), (701, [65, 805]), (1, [97, 805]), (1, [66, 775]), (1, [98, 775]), (1, [66, 803]), (1, [98, 803]), (1, [66, 817]), (1, [98, 817]), (1, [199, 769]), (1, [231, 769]), (1, [68, 775]), (1, [100, 775]), (1, [68, 803]), (1, [100, 803]), (1, [68, 817]), (1, [100, 817]), (1, [68, 807]), (1, [100, 807]), (1, [68, 813]), (1, [100, 813]), (1, [274, 768]), (1, [275, 768]), (1, [274, 769]), (1, [275, 769]), (1, [69, 813]), (1, [101, 813]), (1, [69, 816]), (1, [101, 816]), (1, [552, 774]), (1, [553, 774]), (1, [70, 775]), (1, [102, 775]), (1, [71, 772]), (1, [103, 772]), (1, [72, 775]), (1, [104, 775]), (1, [72, 803]), (1, [104, 803]), (1, [72, 776]), (1, [104, 776]), (1, [72, 807]), (1, [104, 807]), (1, [72, 814]), (1, [104, 814]), (1, [73, 816]), (1, [105, 816]), (1, [207, 769]), (1, [239, 769]), (1, [75, 769]), (1, [107, 769]), (1, [75, 803]), (1, [107, 803]), (1, [75, 817]), (1, [107, 817]), (1, [76, 803]), (1, [108, 803]), (1, [7734, 772]), (1, [7735, 772]), (1, [76, 817]), (1, [108, 817]), (1, [76, 813]), (1, [108, 813]), (1, [77, 769]), (1, [109, 769]), (1, [77, 775]), (1, [109, 775]), (1, [77, 803]), (1, [109, 803]), (1, [78, 775]), (1, [110, 775]), (1, [78, 803]), (1, [110, 803]), (1, [78, 817]), (1, [110, 817]), (1, [78, 813]), (1, [110, 813]), (1, [213, 769]), (1, [245, 769]), (1, [213, 776]), (1, [245, 776]), (1, [332, 768]), (1, [333, 768]), (1, [332, 769]), (1, [333, 769]), (1, [80, 769]), (1, [112, 769]), (1, [80, 775]), (1, [112, 775]), (1, [82, 775]), (1, [114, 775]), (1, [82, 803]), (1, [114, 803]), (1, [7770, 772]), (1, [7771, 772]), (1, [82, 817]), (1, [114, 817]), (1, [83, 775]), (1, [115, 775]), (1, [83, 803]), (1, [115, 803]), (1, [346, 775]), (1, [347, 775]), (1, [352, 775]), (1, [353, 775]), (1, [7778, 775]), (1, [7779, 775]), (1, [84, 775]), (1, [116, 775]), (1, [84, 803]), (1, [116, 803]), (1, [84, 817]), (1, [116, 817]), (1, [84, 813]), (1, [116, 813]), (1, [85, 804]), (1, [117, 804]), (1, [85, 816]), (1, [117, 816]), (1, [85, 813]), (1, [117, 813]), (1, [360, 769]), (1, [361, 769]), (1, [362, 776]), (1, [363, 776]), (1, [86, 771]), (1, [118, 771]), (1, [86, 803]), (1, [118, 803]), (1, [87, 768]), (1, [119, 768]), (1, [87, 769]), (1, [119, 769]), (1, [87, 776]), (1, [119, 776]), (1, [87, 775]), (1, [119, 775]), (1, [87, 803]), (1, [119, 803]), (1, [88, 775]), (1, [120, 775]), (1, [88, 776]), (1, [120, 776]), (1, [89, 775]), (1, [121, 775]), (1, [90, 770]), (1, [122, 770]), (1, [90, 803]), (1, [122, 803]), (1, [90, 817]), (1, [122, 817]), (1, [104, 817]), (1, [116, 776]), (1, [119, 778]), (1, [121, 778]), (2, [383, 775]), (5, [65, 803]), (1, [97, 803]), (1, [65, 777]), (1, [97, 777]), (1, [194, 769]), (1, [226, 769]), (1, [194, 768]), (1, [226, 768]), (1, [194, 777]), (1, [226, 777]), (1, [194, 771]), (1, [226, 771]), (1, [7840, 770]), (1, [7841, 770]), (1, [258, 769]), (1, [259, 769]), (1, [258, 768]), (1, [259, 768]), (1, [258, 777]), (1, [259, 777]), (1, [258, 771]), (1, [259, 771]), (1, [7840, 774]), (1, [7841, 774]), (1, [69, 803]), (1, [101, 803]), (1, [69, 777]), (1, [101, 777]), (1, [69, 771]), (1, [101, 771]), (1, [202, 769]), (1, [234, 769]), (1, [202, 768]), (1, [234, 768]), (1, [202, 777]), (1, [234, 777]), (1, [202, 771]), (1, [234, 771]), (1, [7864, 770]), (1, [7865, 770]), (1, [73, 777]), (1, [105, 777]), (1, [73, 803]), (1, [105, 803]), (1, [79, 803]), (1, [111, 803]), (1, [79, 777]), (1, [111, 777]), (1, [212, 769]), (1, [244, 769]), (1, [212, 768]), (1, [244, 768]), (1, [212, 777]), (1, [244, 777]), (1, [212, 771]), (1, [244, 771]), (1, [7884, 770]), (1, [7885, 770]), (1, [416, 769]), (1, [417, 769]), (1, [416, 768]), (1, [417, 768]), (1, [416, 777]), (1, [417, 777]), (1, [416, 771]), (1, [417, 771]), (1, [416, 803]), (1, [417, 803]), (1, [85, 803]), (1, [117, 803]), (1, [85, 777]), (1, [117, 777]), (1, [431, 769]), (1, [432, 769]), (1, [431, 768]), (1, [432, 768]), (1, [431, 777]), (1, [432, 777]), (1, [431, 771]), (1, [432, 771]), (1, [431, 803]), (1, [432, 803]), (1, [89, 768]), (1, [121, 768]), (1, [89, 803]), (1, [121, 803]), (1, [89, 777]), (1, [121, 777]), (1, [89, 771]), (1, [121, 771]), (7, [945, 787]), (1, [945, 788]), (1, [7936, 768]), (1, [7937, 768]), (1, [7936, 769]), (1, [7937, 769]), (1, [7936, 834]), (1, [7937, 834]), (1, [913, 787]), (1, [913, 788]), (1, [7944, 768]), (1, [7945, 768]), (1, [7944, 769]), (1, [7945, 769]), (1, [7944, 834]), (1, [7945, 834]), (1, [949, 787]), (1, [949, 788]), (1, [7952, 768]), (1, [7953, 768]), (1, [7952, 769]), (1, [7953, 769]), (3, [917, 787]), (1, [917, 788]), (1, [7960, 768]), (1, [7961, 768]), (1, [7960, 769]), (1, [7961, 769]), (3, [951, 787]), (1, [951, 788]), (1, [7968, 768]), (1, [7969, 768]), (1, [7968, 769]), (1, [7969, 769]), (1, [7968, 834]), (1, [7969, 834]), (1, [919, 787]), (1, [919, 788]), (1, [7976, 768]), (1, [7977, 768]), (1, [7976, 769]), (1, [7977, 769]), (1, [7976, 834]), (1, [7977, 834]), (1, [953, 787]), (1, [953, 788]), (1, [7984, 768]), (1, [7985, 768]), (1, [7984, 769]), (1, [7985, 769]), (1, [7984, 834]), (1, [7985, 834]), (1, [921, 787]), (1, [921, 788]), (1, [7992, 768]), (1, [7993, 768]), (1, [7992, 769]), (1, [7993, 769]), (1, [7992, 834]), (1, [7993, 834]), (1, [959, 787]), (1, [959, 788]), (1, [8000, 768]), (1, [8001, 768]), (1, [8000, 769]), (1, [8001, 769]), (3, [927, 787]), (1, [927, 788]), (1, [8008, 768]), (1, [8009, 768]), (1, [8008, 769]), (1, [8009, 769]), (3, [965, 787]), (1, [965, 788]), (1, [8016, 768]), (1, [8017, 768]), (1, [8016, 769]), (1, [8017, 769]), (1, [8016, 834]), (1, [8017, 834]), (2, [933, 788]), (2, [8025, 768]), (2, [8025, 769]), (2, [8025, 834]), (1, [969, 787]), (1, [969, 788]), (1, [8032, 768]), (1, [8033, 768]), (1, [8032, 769]), (1, [8033, 769]), (1, [8032, 834]), (1, [8033, 834]), (1, [937, 787]), (1, [937, 788]), (1, [8040, 768]), (1, [8041, 768]), (1, [8040, 769]), (1, [8041, 769]), (1, [8040, 834]), (1, [8041, 834]), (1, [945, 768]), (1, [940]), (1, [949, 768]), (1, [941]), (1, [951, 768]), (1, [942]), (1, [953, 768]), (1, [943]), (1, [959, 768]), (1, [972]), (1, [965, 768]), (1, [973]), (1, [969, 768]), (1, [974]), (3, [7936, 837]), (1, [7937, 837]), (1, [7938, 837]), (1, [7939, 837]), (1, [7940, 837]), (1, [7941, 837]), (1, [7942, 837]), (1, [7943, 837]), (1, [7944, 837]), (1, [7945, 837]), (1, [7946, 837]), (1, [7947, 837]), (1, [7948, 837]), (1, [7949, 837]), (1, [7950, 837]), (1, [7951, 837]), (1, [7968, 837]), (1, [7969, 837]), (1, [7970, 837]), (1, [7971, 837]), (1, [7972, 837]), (1, [7973, 837]), (1, [7974, 837]), (1, [7975, 837]), (1, [7976, 837]), (1, [7977, 837]), (1, [7978, 837]), (1, [7979, 837]), (1, [7980, 837]), (1, [7981, 837]), (1, [7982, 837]), (1, [7983, 837]), (1, [8032, 837]), (1, [8033, 837]), (1, [8034, 837]), (1, [8035, 837]), (1, [8036, 837]), (1, [8037, 837]), (1, [8038, 837]), (1, [8039, 837]), (1, [8040, 837]), (1, [8041, 837]), (1, [8042, 837]), (1, [8043, 837]), (1, [8044, 837]), (1, [8045, 837]), (1, [8046, 837]), (1, [8047, 837]), (1, [945, 774]), (1, [945, 772]), (1, [8048, 837]), (1, [945, 837]), (1, [940, 837]), (2, [945, 834]), (1, [8118, 837]), (1, [913, 774]), (1, [913, 772]), (1, [913, 768]), (1, [902]), (1, [913, 837]), (2, [953]), (3, [168, 834]), (1, [8052, 837]), (1, [951, 837]), (1, [942, 837]), (2, [951, 834]), (1, [8134, 837]), (1, [917, 768]), (1, [904]), (1, [919, 768]), (1, [905]), (1, [919, 837]), (1, [8127, 768]), (1, [8127, 769]), (1, [8127, 834]), (1, [953, 774]), (1, [953, 772]), (1, [970, 768]), (1, [912]), (3, [953, 834]), (1, [970, 834]), (1, [921, 774]), (1, [921, 772]), (1, [921, 768]), (1, [906]), (2, [8190, 768]), (1, [8190, 769]), (1, [8190, 834]), (1, [965, 774]), (1, [965, 772]), (1, [971, 768]), (1, [944]), (1, [961, 787]), (1, [961, 788]), (1, [965, 834]), (1, [971, 834]), (1, [933, 774]), (1, [933, 772]), (1, [933, 768]), (1, [910]), (1, [929, 788]), (1, [168, 768]), (1, [901]), (1, [96]), (3, [8060, 837]), (1, [969, 837]), (1, [974, 837]), (2, [969, 834]), (1, [8182, 837]), (1, [927, 768]), (1, [908]), (1, [937, 768]), (1, [911]), (1, [937, 837]), (1, [180]), (3, [8194]), (1, [8195]), (293, [937]), (4, [75]), (1, [197]), (111, [8592, 824]), (1, [8594, 824]), (19, [8596, 824]), (31, [8656, 824]), (1, [8660, 824]), (1, [8658, 824]), (53, [8707, 824]), (5, [8712, 824]), (3, [8715, 824]), (24, [8739, 824]), (2, [8741, 824]), (27, [8764, 824]), (3, [8771, 824]), (3, [8773, 824]), (2, [8776, 824]), (23, [61, 824]), (2, [8801, 824]), (11, [8781, 824]), (1, [60, 824]), (1, [62, 824]), (1, [8804, 824]), (1, [8805, 824]), (3, [8818, 824]), (1, [8819, 824]), (3, [8822, 824]), (1, [8823, 824]), (7, [8826, 824]), (1, [8827, 824]), (3, [8834, 824]), (1, [8835, 824]), (3, [8838, 824]), (1, [8839, 824]), (35, [8866, 824]), (1, [8872, 824]), (1, [8873, 824]), (1, [8875, 824]), (49, [8828, 824]), (1, [8829, 824]), (1, [8849, 824]), (1, [8850, 824]), (7, [8882, 824]), (1, [8883, 824]), (1, [8884, 824]), (1, [8885, 824]), (60, [12296]), (1, [12297]), (1970, [10973, 824]), (1392, [12363, 12441]), (2, [12365, 12441]), (2, [12367, 12441]), (2, [12369, 12441]), (2, [12371, 12441]), (2, [12373, 12441]), (2, [12375, 12441]), (2, [12377, 12441]), (2, [12379, 12441]), (2, [12381, 12441]), (2, [12383, 12441]), (2, [12385, 12441]), (3, [12388, 12441]), (2, [12390, 12441]), (2, [12392, 12441]), (7, [12399, 12441]), (1, [12399, 12442]), (2, [12402, 12441]), (1, [12402, 12442]), (2, [12405, 12441]), (1, [12405, 12442]), (2, [12408, 12441]), (1, [12408, 12442]), (2, [12411, 12441]), (1, [12411, 12442]), (23, [12358, 12441]), (10, [12445, 12441]), (14, [12459, 12441]), (2, [12461, 12441]), (2, [12463, 12441]), (2, [12465, 12441]), (2, [12467, 12441]), (2, [12469, 12441]), (2, [12471, 12441]), (2, [12473, 12441]), (2, [12475, 12441]), (2, [12477, 12441]), (2, [12479, 12441]), (2, [12481, 12441]), (3, [12484, 12441]), (2, [12486, 12441]), (2, [12488, 12441]), (7, [12495, 12441]), (1, [12495, 12442]), (2, [12498, 12441]), (1, [12498, 12442]), (2, [12501, 12441]), (1, [12501, 12442]), (2, [12504, 12441]), (1, [12504, 12442]), (2, [12507, 12441]), (1, [12507, 12442]), (23, [12454, 12441]), (3, [12527, 12441]), (1, [12528, 12441]), (1, [12529, 12441]), (1, [12530, 12441]), (4, [12541, 12441]), (51202, [35912]), (1, [26356]), (1, [36554]), (1, [36040]), (1, [28369]), (1, [20018]), (1, [21477]), (1, [40860]), (1, [40860]), (1, [22865]), (1, [37329]), (1, [21895]), (1, [22856]), (1, [25078]), (1, [30313]), (1, [32645]), (1, [34367]), (1, [34746]), (1, [35064]), (1, [37007]), (1, [27138]), (1, [27931]), (1, [28889]), (1, [29662]), (1, [33853]), (1, [37226]), (1, [39409]), (1, [20098]), (1, [21365]), (1, [27396]), (1, [29211]), (1, [34349]), (1, [40478]), (1, [23888]), (1, [28651]), (1, [34253]), (1, [35172]), (1, [25289]), (1, [33240]), (1, [34847]), (1, [24266]), (1, [26391]), (1, [28010]), (1, [29436]), (1, [37070]), (1, [20358]), (1, [20919]), (1, [21214]), (1, [25796]), (1, [27347]), (1, [29200]), (1, [30439]), (1, [32769]), (1, [34310]), (1, [34396]), (1, [36335]), (1, [38706]), (1, [39791]), (1, [40442]), (1, [30860]), (1, [31103]), (1, [32160]), (1, [33737]), (1, [37636]), (1, [40575]), (1, [35542]), (1, [22751]), (1, [24324]), (1, [31840]), (1, [32894]), (1, [29282]), (1, [30922]), (1, [36034]), (1, [38647]), (1, [22744]), (1, [23650]), (1, [27155]), (1, [28122]), (1, [28431]), (1, [32047]), (1, [32311]), (1, [38475]), (1, [21202]), (1, [32907]), (1, [20956]), (1, [20940]), (1, [31260]), (1, [32190]), (1, [33777]), (1, [38517]), (1, [35712]), (1, [25295]), (1, [27138]), (1, [35582]), (1, [20025]), (1, [23527]), (1, [24594]), (1, [29575]), (1, [30064]), (1, [21271]), (1, [30971]), (1, [20415]), (1, [24489]), (1, [19981]), (1, [27852]), (1, [25976]), (1, [32034]), (1, [21443]), (1, [22622]), (1, [30465]), (1, [33865]), (1, [35498]), (1, [27578]), (1, [36784]), (1, [27784]), (1, [25342]), (1, [33509]), (1, [25504]), (1, [30053]), (1, [20142]), (1, [20841]), (1, [20937]), (1, [26753]), (1, [31975]), (1, [33391]), (1, [35538]), (1, [37327]), (1, [21237]), (1, [21570]), (1, [22899]), (1, [24300]), (1, [26053]), (1, [28670]), (1, [31018]), (1, [38317]), (1, [39530]), (1, [40599]), (1, [40654]), (1, [21147]), (1, [26310]), (1, [27511]), (1, [36706]), (1, [24180]), (1, [24976]), (1, [25088]), (1, [25754]), (1, [28451]), (1, [29001]), (1, [29833]), (1, [31178]), (1, [32244]), (1, [32879]), (1, [36646]), (1, [34030]), (1, [36899]), (1, [37706]), (1, [21015]), (1, [21155]), (1, [21693]), (1, [28872]), (1, [35010]), (1, [35498]), (1, [24265]), (1, [24565]), (1, [25467]), (1, [27566]), (1, [31806]), (1, [29557]), (1, [20196]), (1, [22265]), (1, [23527]), (1, [23994]), (1, [24604]), (1, [29618]), (1, [29801]), (1, [32666]), (1, [32838]), (1, [37428]), (1, [38646]), (1, [38728]), (1, [38936]), (1, [20363]), (1, [31150]), (1, [37300]), (1, [38584]), (1, [24801]), (1, [20102]), (1, [20698]), (1, [23534]), (1, [23615]), (1, [26009]), (1, [27138]), (1, [29134]), (1, [30274]), (1, [34044]), (1, [36988]), (1, [40845]), (1, [26248]), (1, [38446]), (1, [21129]), (1, [26491]), (1, [26611]), (1, [27969]), (1, [28316]), (1, [29705]), (1, [30041]), (1, [30827]), (1, [32016]), (1, [39006]), (1, [20845]), (1, [25134]), (1, [38520]), (1, [20523]), (1, [23833]), (1, [28138]), (1, [36650]), (1, [24459]), (1, [24900]), (1, [26647]), (1, [29575]), (1, [38534]), (1, [21033]), (1, [21519]), (1, [23653]), (1, [26131]), (1, [26446]), (1, [26792]), (1, [27877]), (1, [29702]), (1, [30178]), (1, [32633]), (1, [35023]), (1, [35041]), (1, [37324]), (1, [38626]), (1, [21311]), (1, [28346]), (1, [21533]), (1, [29136]), (1, [29848]), (1, [34298]), (1, [38563]), (1, [40023]), (1, [40607]), (1, [26519]), (1, [28107]), (1, [33256]), (1, [31435]), (1, [31520]), (1, [31890]), (1, [29376]), (1, [28825]), (1, [35672]), (1, [20160]), (1, [33590]), (1, [21050]), (1, [20999]), (1, [24230]), (1, [25299]), (1, [31958]), (1, [23429]), (1, [27934]), (1, [26292]), (1, [36667]), (1, [34892]), (1, [38477]), (1, [35211]), (1, [24275]), (1, [20800]), (1, [21952]), (3, [22618]), (2, [26228]), (3, [20958]), (1, [29482]), (1, [30410]), (1, [31036]), (1, [31070]), (1, [31077]), (1, [31119]), (1, [38742]), (1, [31934]), (1, [32701]), (2, [34322]), (2, [35576]), (3, [36920]), (1, [37117]), (4, [39151]), (1, [39164]), (1, [39208]), (1, [40372]), (1, [37086]), (1, [38583]), (1, [20398]), (1, [20711]), (1, [20813]), (1, [21193]), (1, [21220]), (1, [21329]), (1, [21917]), (1, [22022]), (1, [22120]), (1, [22592]), (1, [22696]), (1, [23652]), (1, [23662]), (1, [24724]), (1, [24936]), (1, [24974]), (1, [25074]), (1, [25935]), (1, [26082]), (1, [26257]), (1, [26757]), (1, [28023]), (1, [28186]), (1, [28450]), (1, [29038]), (1, [29227]), (1, [29730]), (1, [30865]), (1, [31038]), (1, [31049]), (1, [31048]), (1, [31056]), (1, [31062]), (1, [31069]), (1, [31117]), (1, [31118]), (1, [31296]), (1, [31361]), (1, [31680]), (1, [32244]), (1, [32265]), (1, [32321]), (1, [32626]), (1, [32773]), (1, [33261]), (1, [33401]), (1, [33401]), (1, [33879]), (1, [35088]), (1, [35222]), (1, [35585]), (1, [35641]), (1, [36051]), (1, [36104]), (1, [36790]), (1, [36920]), (1, [38627]), (1, [38911]), (1, [38971]), (1, [24693]), (1, [148206]), (1, [33304]), (3, [20006]), (1, [20917]), (1, [20840]), (1, [20352]), (1, [20805]), (1, [20864]), (1, [21191]), (1, [21242]), (1, [21917]), (1, [21845]), (1, [21913]), (1, [21986]), (1, [22618]), (1, [22707]), (1, [22852]), (1, [22868]), (1, [23138]), (1, [23336]), (1, [24274]), (1, [24281]), (1, [24425]), (1, [24493]), (1, [24792]), (1, [24910]), (1, [24840]), (1, [24974]), (1, [24928]), (1, [25074]), (1, [25140]), (1, [25540]), (1, [25628]), (1, [25682]), (1, [25942]), (1, [26228]), (1, [26391]), (1, [26395]), (1, [26454]), (1, [27513]), (1, [27578]), (1, [27969]), (1, [28379]), (1, [28363]), (1, [28450]), (1, [28702]), (1, [29038]), (1, [30631]), (1, [29237]), (1, [29359]), (1, [29482]), (1, [29809]), (1, [29958]), (1, [30011]), (1, [30237]), (1, [30239]), (1, [30410]), (1, [30427]), (1, [30452]), (1, [30538]), (1, [30528]), (1, [30924]), (1, [31409]), (1, [31680]), (1, [31867]), (1, [32091]), (1, [32244]), (1, [32574]), (1, [32773]), (1, [33618]), (1, [33775]), (1, [34681]), (1, [35137]), (1, [35206]), (1, [35222]), (1, [35519]), (1, [35576]), (1, [35531]), (1, [35585]), (1, [35582]), (1, [35565]), (1, [35641]), (1, [35722]), (1, [36104]), (1, [36664]), (1, [36978]), (1, [37273]), (1, [37494]), (1, [38524]), (1, [38627]), (1, [38742]), (1, [38875]), (1, [38911]), (1, [38923]), (1, [38971]), (1, [39698]), (1, [40860]), (1, [141386]), (1, [141380]), (1, [144341]), (1, [15261]), (1, [16408]), (1, [16441]), (1, [152137]), (1, [154832]), (1, [163539]), (1, [40771]), (1, [40846]), (68, [1497, 1460]), (2, [1522, 1463]), (11, [1513, 1473]), (1, [1513, 1474]), (1, [64329, 1473]), (1, [64329, 1474]), (1, [1488, 1463]), (1, [1488, 1464]), (1, [1488, 1468]), (1, [1489, 1468]), (1, [1490, 1468]), (1, [1491, 1468]), (1, [1492, 1468]), (1, [1493, 1468]), (1, [1494, 1468]), (2, [1496, 1468]), (1, [1497, 1468]), (1, [1498, 1468]), (1, [1499, 1468]), (1, [1500, 1468]), (2, [1502, 1468]), (2, [1504, 1468]), (1, [1505, 1468]), (2, [1507, 1468]), (1, [1508, 1468]), (2, [1510, 1468]), (1, [1511, 1468]), (1, [1512, 1468]), (1, [1513, 1468]), (1, [1514, 1468]), (1, [1493, 1465]), (1, [1489, 1471]), (1, [1499, 1471]), (1, [1508, 1471]), (2683, [67026, 775]), (27, [67034, 775]), (2742, [69785, 69818]), (2, [69787, 69818]), (15, [69797, 69818]), (131, [69937, 69927]), (1, [69938, 69927]), (540, [70471, 70462]), (1, [70471, 70487]), (55, [70530, 70601]), (2, [70532, 70587]), (9, [70539, 70594]), (3, [70544, 70601]), (52, [70594, 70594]), (2, [70594, 70584]), (1, [70594, 70601]), (243, [70841, 70842]), (1, [70841, 70832]), (2, [70841, 70845]), (252, [71096, 71087]), (1, [71097, 71087]), (893, [71989, 71984]), (18409, [90398, 90398]), (1, [90398, 90409]), (1, [90398, 90399]), (1, [90409, 90399]), (1, [90398, 90400]), (1, [90401, 90399]), (1, [90402, 90399]), (1, [90401, 90400]), (3136, [93543, 93543]), (1, [93539, 93543]), (1, [93545, 93543]), (25588, [119127, 119141]), (1, [119128, 119141]), (1, [119135, 119150]), (1, [119135, 119151]), (1, [119135, 119152]), (1, [119135, 119153]), (1, [119135, 119154]), (87, [119225, 119141]), (1, [119226, 119141]), (1, [119227, 119150]), (1, [119228, 119150]), (1, [119227, 119151]), (1, [119228, 119151]), (75328, [20029]), (1, [20024]), (1, [20033]), (1, [131362]), (1, [20320]), (1, [20398]), (1, [20411]), (1, [20482]), (1, [20602]), (1, [20633]), (1, [20711]), (1, [20687]), (1, [13470]), (1, [132666]), (1, [20813]), (1, [20820]), (1, [20836]), (1, [20855]), (1, [132380]), (1, [13497]), (1, [20839]), (1, [20877]), (1, [132427]), (1, [20887]), (1, [20900]), (1, [20172]), (1, [20908]), (1, [20917]), (1, [168415]), (1, [20981]), (1, [20995]), (1, [13535]), (1, [21051]), (1, [21062]), (1, [21106]), (1, [21111]), (1, [13589]), (1, [21191]), (1, [21193]), (1, [21220]), (1, [21242]), (1, [21253]), (1, [21254]), (1, [21271]), (1, [21321]), (1, [21329]), (1, [21338]), (1, [21363]), (1, [21373]), (1, [21375]), (1, [21375]), (1, [21375]), (1, [133676]), (1, [28784]), (1, [21450]), (1, [21471]), (1, [133987]), (1, [21483]), (1, [21489]), (1, [21510]), (1, [21662]), (1, [21560]), (1, [21576]), (1, [21608]), (1, [21666]), (1, [21750]), (1, [21776]), (1, [21843]), (1, [21859]), (1, [21892]), (1, [21892]), (1, [21913]), (1, [21931]), (1, [21939]), (1, [21954]), (1, [22294]), (1, [22022]), (1, [22295]), (1, [22097]), (1, [22132]), (1, [20999]), (1, [22766]), (1, [22478]), (1, [22516]), (1, [22541]), (1, [22411]), (1, [22578]), (1, [22577]), (1, [22700]), (1, [136420]), (1, [22770]), (1, [22775]), (1, [22790]), (1, [22810]), (1, [22818]), (1, [22882]), (1, [136872]), (1, [136938]), (1, [23020]), (1, [23067]), (1, [23079]), (1, [23000]), (1, [23142]), (1, [14062]), (1, [14076]), (1, [23304]), (1, [23358]), (1, [23358]), (1, [137672]), (1, [23491]), (1, [23512]), (1, [23527]), (1, [23539]), (1, [138008]), (1, [23551]), (1, [23558]), (1, [24403]), (1, [23586]), (1, [14209]), (1, [23648]), (1, [23662]), (1, [23744]), (1, [23693]), (1, [138724]), (1, [23875]), (1, [138726]), (1, [23918]), (1, [23915]), (1, [23932]), (1, [24033]), (1, [24034]), (1, [14383]), (1, [24061]), (1, [24104]), (1, [24125]), (1, [24169]), (1, [14434]), (1, [139651]), (1, [14460]), (1, [24240]), (1, [24243]), (1, [24246]), (1, [24266]), (1, [172946]), (1, [24318]), (1, [140081]), (1, [140081]), (1, [33281]), (1, [24354]), (1, [24354]), (1, [14535]), (1, [144056]), (1, [156122]), (1, [24418]), (1, [24427]), (1, [14563]), (1, [24474]), (1, [24525]), (1, [24535]), (1, [24569]), (1, [24705]), (1, [14650]), (1, [14620]), (1, [24724]), (1, [141012]), (1, [24775]), (1, [24904]), (1, [24908]), (1, [24910]), (1, [24908]), (1, [24954]), (1, [24974]), (1, [25010]), (1, [24996]), (1, [25007]), (1, [25054]), (1, [25074]), (1, [25078]), (1, [25104]), (1, [25115]), (1, [25181]), (1, [25265]), (1, [25300]), (1, [25424]), (1, [142092]), (1, [25405]), (1, [25340]), (1, [25448]), (1, [25475]), (1, [25572]), (1, [142321]), (1, [25634]), (1, [25541]), (1, [25513]), (1, [14894]), (1, [25705]), (1, [25726]), (1, [25757]), (1, [25719]), (1, [14956]), (1, [25935]), (1, [25964]), (1, [143370]), (1, [26083]), (1, [26360]), (1, [26185]), (1, [15129]), (1, [26257]), (1, [15112]), (1, [15076]), (1, [20882]), (1, [20885]), (1, [26368]), (1, [26268]), (1, [32941]), (1, [17369]), (1, [26391]), (1, [26395]), (1, [26401]), (1, [26462]), (1, [26451]), (1, [144323]), (1, [15177]), (1, [26618]), (1, [26501]), (1, [26706]), (1, [26757]), (1, [144493]), (1, [26766]), (1, [26655]), (1, [26900]), (1, [15261]), (1, [26946]), (1, [27043]), (1, [27114]), (1, [27304]), (1, [145059]), (1, [27355]), (1, [15384]), (1, [27425]), (1, [145575]), (1, [27476]), (1, [15438]), (1, [27506]), (1, [27551]), (1, [27578]), (1, [27579]), (1, [146061]), (1, [138507]), (1, [146170]), (1, [27726]), (1, [146620]), (1, [27839]), (1, [27853]), (1, [27751]), (1, [27926]), (1, [27966]), (1, [28023]), (1, [27969]), (1, [28009]), (1, [28024]), (1, [28037]), (1, [146718]), (1, [27956]), (1, [28207]), (1, [28270]), (1, [15667]), (1, [28363]), (1, [28359]), (1, [147153]), (1, [28153]), (1, [28526]), (1, [147294]), (1, [147342]), (1, [28614]), (1, [28729]), (1, [28702]), (1, [28699]), (1, [15766]), (1, [28746]), (1, [28797]), (1, [28791]), (1, [28845]), (1, [132389]), (1, [28997]), (1, [148067]), (1, [29084]), (1, [148395]), (1, [29224]), (1, [29237]), (1, [29264]), (1, [149000]), (1, [29312]), (1, [29333]), (1, [149301]), (1, [149524]), (1, [29562]), (1, [29579]), (1, [16044]), (1, [29605]), (1, [16056]), (1, [16056]), (1, [29767]), (1, [29788]), (1, [29809]), (1, [29829]), (1, [29898]), (1, [16155]), (1, [29988]), (1, [150582]), (1, [30014]), (1, [150674]), (1, [30064]), (1, [139679]), (1, [30224]), (1, [151457]), (1, [151480]), (1, [151620]), (1, [16380]), (1, [16392]), (1, [30452]), (1, [151795]), (1, [151794]), (1, [151833]), (1, [151859]), (1, [30494]), (1, [30495]), (1, [30495]), (1, [30538]), (1, [16441]), (1, [30603]), (1, [16454]), (1, [16534]), (1, [152605]), (1, [30798]), (1, [30860]), (1, [30924]), (1, [16611]), (1, [153126]), (1, [31062]), (1, [153242]), (1, [153285]), (1, [31119]), (1, [31211]), (1, [16687]), (1, [31296]), (1, [31306]), (1, [31311]), (1, [153980]), (1, [154279]), (1, [154279]), (1, [31470]), (1, [16898]), (1, [154539]), (1, [31686]), (1, [31689]), (1, [16935]), (1, [154752]), (1, [31954]), (1, [17056]), (1, [31976]), (1, [31971]), (1, [32000]), (1, [155526]), (1, [32099]), (1, [17153]), (1, [32199]), (1, [32258]), (1, [32325]), (1, [17204]), (1, [156200]), (1, [156231]), (1, [17241]), (1, [156377]), (1, [32634]), (1, [156478]), (1, [32661]), (1, [32762]), (1, [32773]), (1, [156890]), (1, [156963]), (1, [32864]), (1, [157096]), (1, [32880]), (1, [144223]), (1, [17365]), (1, [32946]), (1, [33027]), (1, [17419]), (1, [33086]), (1, [23221]), (1, [157607]), (1, [157621]), (1, [144275]), (1, [144284]), (1, [33281]), (1, [33284]), (1, [36766]), (1, [17515]), (1, [33425]), (1, [33419]), (1, [33437]), (1, [21171]), (1, [33457]), (1, [33459]), (1, [33469]), (1, [33510]), (1, [158524]), (1, [33509]), (1, [33565]), (1, [33635]), (1, [33709]), (1, [33571]), (1, [33725]), (1, [33767]), (1, [33879]), (1, [33619]), (1, [33738]), (1, [33740]), (1, [33756]), (1, [158774]), (1, [159083]), (1, [158933]), (1, [17707]), (1, [34033]), (1, [34035]), (1, [34070]), (1, [160714]), (1, [34148]), (1, [159532]), (1, [17757]), (1, [17761]), (1, [159665]), (1, [159954]), (1, [17771]), (1, [34384]), (1, [34396]), (1, [34407]), (1, [34409]), (1, [34473]), (1, [34440]), (1, [34574]), (1, [34530]), (1, [34681]), (1, [34600]), (1, [34667]), (1, [34694]), (1, [17879]), (1, [34785]), (1, [34817]), (1, [17913]), (1, [34912]), (1, [34915]), (1, [161383]), (1, [35031]), (1, [35038]), (1, [17973]), (1, [35066]), (1, [13499]), (1, [161966]), (1, [162150]), (1, [18110]), (1, [18119]), (1, [35488]), (1, [35565]), (1, [35722]), (1, [35925]), (1, [162984]), (1, [36011]), (1, [36033]), (1, [36123]), (1, [36215]), (1, [163631]), (1, [133124]), (1, [36299]), (1, [36284]), (1, [36336]), (1, [133342]), (1, [36564]), (1, [36664]), (1, [165330]), (1, [165357]), (1, [37012]), (1, [37105]), (1, [37137]), (1, [165678]), (1, [37147]), (1, [37432]), (1, [37591]), (1, [37592]), (1, [37500]), (1, [37881]), (1, [37909]), (1, [166906]), (1, [38283]), (1, [18837]), (1, [38327]), (1, [167287]), (1, [18918]), (1, [38595]), (1, [23986]), (1, [38691]), (1, [168261]), (1, [168474]), (1, [19054]), (1, [19062]), (1, [38880]), (1, [168970]), (1, [19122]), (1, [169110]), (1, [38923]), (1, [38923]), (1, [38953]), (1, [169398]), (1, [39138]), (1, [19251]), (1, [39209]), (1, [39335]), (1, [39362]), (1, [39422]), (1, [19406]), (1, [170800]), (1, [39698]), (1, [40000]), (1, [40189]), (1, [19662]), (1, [19693]), (1, [40295]), (1, [172238]), (1, [19704]), (1, [172293]), (1, [172558]), (1, [172689]), (1, [40635]), (1, [19798]), (1, [40697]), (1, [40702]), (1, [40709]), (1, [40719]), (1, [40726]), (1, [40763]), (1, [173568])]);
