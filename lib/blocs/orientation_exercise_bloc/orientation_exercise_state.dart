part of 'orientation_exercise_bloc.dart';

@immutable
abstract class OrientationExerciseState {
  List<String>? names;
  List<String>? images;
  List<bool>? areCombinationsCorrect;
  List<bool>? correctAnswers;
}

class OrientationExerciseInitial extends OrientationExerciseState {
}

class OrientationExerciseStartState extends OrientationExerciseState {

  OrientationExerciseStartState({required names, required images, required correctAnswers, required areCombinationsCorrect}) {
    this.names = names;
    this.images = images;
    this.correctAnswers = correctAnswers;
    this.areCombinationsCorrect = areCombinationsCorrect;
  }
}

class OrientationExerciseLoading extends OrientationExerciseState {
}

class OrientationExerciseValidated extends OrientationExerciseState {

  OrientationExerciseValidated({required names, required images, required correctAnswers, required areCombinationsCorrect}) {
    this.names = names;
    this.images = images;
    this.correctAnswers = correctAnswers;
    this.areCombinationsCorrect = areCombinationsCorrect;
  }

}

class OrientationExerciseNotValidated extends OrientationExerciseState {

  OrientationExerciseNotValidated({required names, required images, required correctAnswers, required areCombinationsCorrect}) {
    this.names = names;
    this.images = images;
    this.correctAnswers = correctAnswers;
    this.areCombinationsCorrect = areCombinationsCorrect;
  }

}

class OrientationExerciseUndoCheck extends OrientationExerciseState {

  OrientationExerciseUndoCheck({required names, required images, required correctAnswers, required areCombinationsCorrect}) {
    this.names = names;
    this.images = images;
    this.correctAnswers = correctAnswers;
    this.areCombinationsCorrect = areCombinationsCorrect;
  }

}

class OrientationExerciseNextE extends OrientationExerciseState {

  OrientationExerciseNextE({required names, required images, required correctAnswers, required areCombinationsCorrect}) {
    this.names = names;
    this.images = images;
    this.correctAnswers = correctAnswers;
    this.areCombinationsCorrect = areCombinationsCorrect;
  }

}

