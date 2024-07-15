import 'package:bloc/bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:meta/meta.dart';

import '../../repositories/orientation_repository.dart';

part 'orientation_exercise_event.dart';
part 'orientation_exercise_state.dart';

class OrientationExerciseBloc extends Bloc<OrientationExerciseEvent, OrientationExerciseState> {
  OrientationExerciseBloc() : super(OrientationExerciseInitial()) {
    on<OrientationExerciseStart>((event, emit) => _startExercise(event, emit));
    on<OrientationExerciseNext>((event, emit) => _nextExercise(event, emit));
    on<UndoPreviousAnswer>((event, emit) => _undoPreviousAnswer(event, emit));
    on<OrientationExerciseValidate>((event, emit) => _validateExercisePart(event, emit));
  }

  _startExercise(event, emit) {
    emit(OrientationExerciseStartState(
      names: event.names,
      images: event.images,
      correctAnswers: event.correctAnswers,
      areCombinationsCorrect: event.areCombinationsCorrect
    ));
  }

  _validateExercisePart(event, emit) {

    try {

      bool isCorrect = OrientationRepository().validateCombination(
        event.swiperDirection,
        state.areCombinationsCorrect![event.indexOfValueToCompare]
      );

      final List<bool> updatedCorrectAnswers = List.from(state.correctAnswers!);

      updatedCorrectAnswers.add(isCorrect);

      emit(OrientationExerciseValidated(
        names: state.names,
        images: state.images,
        correctAnswers: updatedCorrectAnswers,
        areCombinationsCorrect: state.areCombinationsCorrect
      ));



    } catch (e) {
      emit(OrientationExerciseNotValidated(names: state.names, images: state.images, correctAnswers: state.correctAnswers, areCombinationsCorrect: state.areCombinationsCorrect));
    }


  }

  _nextExercise(event, emit) {
    emit(OrientationExerciseNextE(
      names: state.names,
      images: state.images,
      correctAnswers: state.correctAnswers,
      areCombinationsCorrect: state.areCombinationsCorrect
    ));
  }

  _undoPreviousAnswer(event, emit) {
    final List<bool> updatedCorrectAnswers = List.from(state.correctAnswers!);

    if(updatedCorrectAnswers.isNotEmpty) {
      updatedCorrectAnswers.removeLast();
    }

    emit(OrientationExerciseUndoCheck(
      names: state.names,
      images: state.images,
      correctAnswers: updatedCorrectAnswers,
      areCombinationsCorrect: state.areCombinationsCorrect
    ));

  }

}
