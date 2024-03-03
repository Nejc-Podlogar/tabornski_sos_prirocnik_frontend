part of 'morse_translation_bloc.dart';

@immutable
abstract class MorseTranslationEvent {}

class TranslateInput extends MorseTranslationEvent {
  final String inputText;
  final MorseCodeLanguage morseCodeLanguageModel;

  TranslateInput(
      {required this.inputText, required this.morseCodeLanguageModel});
}

class ClearInput extends MorseTranslationEvent {
  ClearInput();
}

class ToggleAutoRepeat extends MorseTranslationEvent {
  final bool isAutoRepeating;

  ToggleAutoRepeat({required this.isAutoRepeating});
}

class UpdateTranslationType extends MorseTranslationEvent {
  final MorseLanguageSetting morseCodeLanguageType;

  UpdateTranslationType({required this.morseCodeLanguageType});
}

// Torch transmitting events

class ToggleTransmitting extends MorseTranslationEvent {
  final String morseCode;

  ToggleTransmitting({required this.morseCode});
}
