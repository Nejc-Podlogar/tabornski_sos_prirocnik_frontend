part of 'morse_exercise_bloc.dart';

@immutable
abstract class MorseExerciseEvent {}

class MorseExerciseStart extends MorseExerciseEvent {
  final List<String> exerciseText;
  final List<String> expectedAnswers;

  MorseExerciseStart({required this.exerciseText, required this.expectedAnswers});

}

class MorseExerciseValidate extends MorseExerciseEvent {
  final int indexOfValueToCompare;
  final String userInput;
  final MorseLanguageSetting translationType;
  final MorseCodeLearningAmount valueAmount;

  MorseExerciseValidate({required this.indexOfValueToCompare, required this.userInput, required this.translationType, required this.valueAmount});
}

class UndoPreviousAnswer extends MorseExerciseEvent {

  UndoPreviousAnswer();
}

class MorseExerciseNext extends MorseExerciseEvent {}
