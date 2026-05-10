import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../domain/entities/semaphore_entry.dart';
import 'semaphore_translation_repository_provider.dart';

part 'semaphore_translation_provider.freezed.dart';

@freezed
class SemaphoreTranslationState with _$SemaphoreTranslationState {
  const factory SemaphoreTranslationState({
    @Default('') String inputText,
    @Default(<SemaphoreEntry>[]) List<SemaphoreEntry> entries,
    @Default(TranslationDirection.textToMorse) TranslationDirection direction,
  }) = _SemaphoreTranslationState;
}

final semaphoreTranslationProvider =
    NotifierProvider<SemaphoreTranslationNotifier, SemaphoreTranslationState>(
  SemaphoreTranslationNotifier.new,
);

class SemaphoreTranslationNotifier
    extends Notifier<SemaphoreTranslationState> {
  @override
  SemaphoreTranslationState build() => const SemaphoreTranslationState();

  void setInput(String text) {
    final repo = ref.read(semaphoreTranslationRepositoryProvider);
    final entries =
        text.isEmpty ? <SemaphoreEntry>[] : repo.getEntriesForText(text);
    state = state.copyWith(inputText: text, entries: entries);
  }

  void swapDirection() {
    final newDirection =
        state.direction == TranslationDirection.textToMorse
            ? TranslationDirection.morseToText
            : TranslationDirection.textToMorse;
    state = state.copyWith(direction: newDirection);
  }

  void clear() => state = const SemaphoreTranslationState();
}
