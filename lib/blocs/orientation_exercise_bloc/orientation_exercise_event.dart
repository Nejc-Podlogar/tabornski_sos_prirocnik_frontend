part of 'orientation_exercise_bloc.dart';

@immutable
abstract class OrientationExerciseEvent {}

class OrientationExerciseStart extends OrientationExerciseEvent {
  final List<String> names;
  final List<String> images;
  final List<bool> areCombinationsCorrect;
  final List<bool> correctAnswers;

  OrientationExerciseStart({required this.names, required this.images, required this.correctAnswers, required this.areCombinationsCorrect});
}

class OrientationExerciseValidate extends OrientationExerciseEvent {
  final int indexOfValueToCompare;
  final CardSwiperDirection swiperDirection;

  OrientationExerciseValidate(this.swiperDirection, {required this.indexOfValueToCompare});
}

class UndoPreviousAnswer extends OrientationExerciseEvent {

  UndoPreviousAnswer();
}

class OrientationExerciseNext extends OrientationExerciseEvent {}

