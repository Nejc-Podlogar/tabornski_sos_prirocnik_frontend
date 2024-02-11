part of 'morse_translation_bloc.dart';

@immutable
abstract class MorseTranslationState {
}

class MorseTranslationInitial extends MorseTranslationState {
  final MorseCodeLanguage languageSetting;

  MorseTranslationInitial({required this.languageSetting});

  @override
  List<Object> get props => [languageSetting];
}

class MorseTranslationLoading extends MorseTranslationInitial {
  MorseTranslationLoading({required super.languageSetting});
}

class MorseTranslationSuccess extends MorseTranslationInitial {

  MorseTranslationSuccess({required super.languageSetting});
}

class MorseTranslationFailure extends MorseTranslationInitial {
  final String errorMessage;

  MorseTranslationFailure({required this.errorMessage, required super.languageSetting});
}