part of 'morse_translation_bloc.dart';

@immutable
abstract class MorseTranslationState {
 final bool isAutoRepeating;
 final MorseCodeLanguage languageSetting;

  MorseTranslationState({this.isAutoRepeating = false, required this.languageSetting});
}

class MorseTranslationInitial extends MorseTranslationState {


  MorseTranslationInitial({required super.languageSetting, required super.isAutoRepeating});

  @override
  List<Object> get props => [languageSetting, isAutoRepeating];
}

class MorseTranslationLoading extends MorseTranslationInitial {
  MorseTranslationLoading({required super.languageSetting, required super.isAutoRepeating});
}

class MorseTranslationSuccess extends MorseTranslationInitial {

  MorseTranslationSuccess({required super.languageSetting, required super.isAutoRepeating});
}

class MorseTranslationFailure extends MorseTranslationInitial {
  final String errorMessage;

  MorseTranslationFailure({required this.errorMessage, required super.languageSetting, required super.isAutoRepeating});
}

// Morse code torch transmitting states

class MorseTorchStartedTransmitting extends MorseTranslationInitial {
  final MorseCodeLanguage languageSetting;

  MorseTorchStartedTransmitting({required this.languageSetting, required super.isAutoRepeating}) : super(languageSetting: languageSetting);
}

class MorseTorchStoppedTransmitting extends MorseTranslationInitial {
  MorseTorchStoppedTransmitting({required super.languageSetting, required super.isAutoRepeating});
}

class MorseTorchTransmittingFailure extends MorseTranslationInitial {
  final String errorMessage;

  MorseTorchTransmittingFailure({required this.errorMessage, required super.languageSetting, required super.isAutoRepeating});
}