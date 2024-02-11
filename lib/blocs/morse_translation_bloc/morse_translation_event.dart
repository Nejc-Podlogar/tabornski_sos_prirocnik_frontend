part of 'morse_translation_bloc.dart';

@immutable
abstract class MorseTranslationEvent {}


class TranslateInput extends MorseTranslationEvent {
  final String inputText;
  final MorseCodeLanguage morseCodeLanguageModel;

  TranslateInput({required this.inputText, required this.morseCodeLanguageModel});
}

class ClearInput extends MorseTranslationEvent {

  ClearInput();
}

class UpdateTranslationType extends MorseTranslationEvent {
  final MorseLanguageSetting morseCodeLanguageType;

  UpdateTranslationType({required this.morseCodeLanguageType});
}