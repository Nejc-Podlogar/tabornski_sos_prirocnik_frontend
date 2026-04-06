import 'package:freezed_annotation/freezed_annotation.dart';

part 'morse_entry.freezed.dart';

@freezed
class MorseEntry with _$MorseEntry {
  const factory MorseEntry({
    required String character,
    required String morseSequence,
  }) = _MorseEntry;
}
