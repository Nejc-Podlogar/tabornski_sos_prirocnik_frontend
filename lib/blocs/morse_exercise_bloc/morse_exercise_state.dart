part of 'morse_exercise_bloc.dart';

@immutable
abstract class MorseExerciseState {
  List<String>? exerciseText;
  List<String>? expectedAnswers;
  List<String>? userInput;
  List<MorseCodeValidation>? correctAnswers;
}

class MorseExerciseInitial extends MorseExerciseState {
}

class MorseExerciseStartState extends MorseExerciseState {

  MorseExerciseStartState({required exerciseText, required expectedAnswers}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = <String>[];
    this.correctAnswers = <MorseCodeValidation>[];
  }

}

class MorseExerciseLoading extends MorseExerciseState {}

class MorseExerciseValidating extends MorseExerciseState {}

class MorseExerciseValidated extends MorseExerciseState {

  MorseExerciseValidated({required exerciseText, required expectedAnswers, required userInput, required correctAnswers}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
  }

}

class MorseExerciseNotValidated extends MorseExerciseState {

  MorseExerciseNotValidated({required exerciseText, required expectedAnswers, required userInput, required correctAnswers}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
  }

}

class MorseExerciseUndoCheck extends MorseExerciseState {

  MorseExerciseUndoCheck({required exerciseText, required expectedAnswers, required userInput, required correctAnswers}) {
    this.exerciseText = exerciseText;
    this.expectedAnswers = expectedAnswers;
    this.userInput = userInput;
    this.correctAnswers = correctAnswers;
  }

}

class MorseExerciseNextE extends MorseExerciseState {

    MorseExerciseNextE({required exerciseText, required expectedAnswers, required userInput, required correctAnswers}) {
      this.exerciseText = exerciseText;
      this.expectedAnswers = expectedAnswers;
      this.userInput = userInput;
      this.correctAnswers = correctAnswers;
    }

}


