import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/value_objects/exercise_enums.dart';
import 'morse_translation_repository_provider.dart';

part 'morse_translation_provider.freezed.dart';

@freezed
class MorseTranslationState with _$MorseTranslationState {
  const factory MorseTranslationState({
    @Default('') String inputText,
    @Default('') String outputText,
    @Default(TranslationDirection.textToMorse) TranslationDirection direction,
    @Default(false) bool isTransmitting,
    @Default(false) bool isLooping,
  }) = _MorseTranslationState;
}

final morseTranslationProvider =
    NotifierProvider<MorseTranslationNotifier, MorseTranslationState>(
  MorseTranslationNotifier.new,
);

class MorseTranslationNotifier extends Notifier<MorseTranslationState> {
  @override
  MorseTranslationState build() => const MorseTranslationState();

  void setInput(String text) {
    final repo = ref.read(morseTranslationRepositoryProvider);
    final output = text.isEmpty ? '' : repo.translate(text, state.direction);
    state = state.copyWith(inputText: text, outputText: output);
  }

  void swapDirection() {
    final newDirection = state.direction == TranslationDirection.textToMorse
        ? TranslationDirection.morseToText
        : TranslationDirection.textToMorse;
    final newInput = state.outputText;
    final repo = ref.read(morseTranslationRepositoryProvider);
    final newOutput = newInput.isEmpty ? '' : repo.translate(newInput, newDirection);
    state = state.copyWith(
      direction: newDirection,
      inputText: newInput,
      outputText: newOutput,
    );
  }

  void setTransmitting(bool value) =>
      state = state.copyWith(isTransmitting: value);

  void setLooping(bool value) =>
      state = state.copyWith(isLooping: value);

  void clear() => state = MorseTranslationState(direction: state.direction);
}
