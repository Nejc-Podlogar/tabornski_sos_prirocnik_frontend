part of 'morse_exercise_bloc.dart';

@immutable
abstract class MorseExerciseState {
  List<String>? exerciseText;
  List<String>? expectedAnswers;
  List<String>? userInput;
  List<bool>? areTranslationsCorrect;
  List<MorseCodeValidation>? correctAnswers;
}

class MorseExerciseInitial extends MorseExerciseState {
}

class MorseExerciseStartState extends MorseExerciseState {

  MorseExerciseStartState({required exerciseText, required expectedAnswers, areTranslationsCorrect}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = <String>[];
    this.correctAnswers = <MorseCodeValidation>[];
    this.areTranslationsCorrect = areTranslationsCorrect;
  }

}

class MorseExerciseLoading extends MorseExerciseState {}

class MorseExerciseValidating extends MorseExerciseState {}

class MorseExerciseValidated extends MorseExerciseState {

  MorseExerciseValidated({required exerciseText, required expectedAnswers, required userInput, required correctAnswers, areTranslationsCorrect}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
    this.areTranslationsCorrect = areTranslationsCorrect;
  }

}

class MorseExerciseNotValidated extends MorseExerciseState {

  MorseExerciseNotValidated({required exerciseText, required expectedAnswers, required userInput, required correctAnswers, areTranslationsCorrect}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
    this.areTranslationsCorrect = areTranslationsCorrect;
  }

}

class MorseExerciseUndoCheck extends MorseExerciseState {

  MorseExerciseUndoCheck({required exerciseText, required expectedAnswers, required userInput, required correctAnswers, areTranslationsCorrect}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
    this.areTranslationsCorrect = areTranslationsCorrect;
  }

}

class MorseExerciseNextE extends MorseExerciseState {

    MorseExerciseNextE({required exerciseText, required expectedAnswers, required userInput, required correctAnswers, areTranslationsCorrect}) {
      this.exerciseText = exerciseText;
      this.expectedAnswers = expectedAnswers;
      this.userInput = userInput;
      this.correctAnswers = correctAnswers;
      this.areTranslationsCorrect = areTranslationsCorrect;
    }

}


