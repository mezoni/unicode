## 1.1.8

- Removed dependency on `dart:io` in emoji code. Added dependency on package `archive` instead.

## 1.1.7

- Fixed bug in generating general categories.

## 1.1.6

- Breaking change: The `sequence` field of class `Emoji` has been renamed to `codePoints`.
- Added new feature: Possibility to search for emoji by name and optionally by status.
- Added several files with examples of using emoji.

## 1.1.5

- Fixed bug in decoding Emoji name and presentation
- Added new feature: Possibility to obtain Emoji version.

## 1.1.4

- Added new feature: Possibility to obtain mapping information from the decomposer.

## 1.1.3

- Minor changes in `Emoji.toString()`.

## 1.1.2

- Added new feature: Support of Unicode Emojis.
- Added new feature: Processing data with character sequences.

## 1.1.1

- Added new feature: Unicode category enumeration `UnicodeCategory`.

## 1.1.0

- Added new feature: simple character decomposition.
- Added new feature: Unicode blocks.

## 1.0.0

- Breaking changes: The names of some public fields and functions have been changed. Also, some public library members have been removed or replaced with more effective ones. This was done because this package had not been maintained for quite a long time (more than 3 years). The current implementation is lighter and retains the previous functionality.
- The dependency on the `list` package has been removed. A lighter implementation from the `sparse_list` package is used instead.

## 0.3.1

- This package is no longer supported because it was flagged by Google Dart developers as being published by an unknown person. Publisher Unknown. As a normal person, I believe that hardly anyone would want to use software from unknown publishers.

## 0.3.0

- The source code has been migrated to null safety.

## 0.2.4

- Removed `dart:io` dependency

## 0.2.3

- Generation fo Unicode 13.0.0

## 0.2.2

- Added example
- Added constants with lowercase names

## 0.2.1

- Fixed bug in generator with parsing the ranges in `UnicodeData.txt`

## 0.2.0

- Adaptation to Dart 2.0
- Generation fo Unicode 12.0.0
