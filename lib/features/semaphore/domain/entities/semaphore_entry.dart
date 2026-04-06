import 'package:freezed_annotation/freezed_annotation.dart';

part 'semaphore_entry.freezed.dart';

@freezed
class SemaphoreEntry with _$SemaphoreEntry {
  const factory SemaphoreEntry({
    required String character,
    required String flagImagePath,
  }) = _SemaphoreEntry;
}
