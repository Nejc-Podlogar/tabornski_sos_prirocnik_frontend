import 'package:bloc/bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:meta/meta.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/models.dart';
import 'package:tabornski_sos_prirocnik_frontend/repositories/morde_translation_repository.dart';

part 'morse_exercise_event.dart';
part 'morse_exercise_state.dart';

class MorseExerciseBloc extends Bloc<MorseExerciseEvent, MorseExerciseState> {
  MorseExerciseBloc() : super(MorseExerciseInitial()) {
    on<MorseExerciseStart>((event, emit) {
      _startExercise(event, emit);
    });
    on<MorseExerciseValidate>((event, emit) {
      _validateExercisePart(event, emit);
    });
    on<UndoPreviousAnswer>((event, emit) {
      _undoPreviousAnswer(event, emit);
    });
    on<MorseExerciseNext>((event, emit) {
      _nextExercise(event, emit);
    });
  }

  _startExercise(event, emit) {
    emit(MorseExerciseStartState(
      exerciseText: event.exerciseText,
      expectedAnswers: event.expectedAnswers,
      areTranslationsCorrect: event.areTranslationsCorrect
    ));
  }

  _nextExercise(event, emit) {
    emit(MorseExerciseNextE(
      exerciseText: state.exerciseText,
      expectedAnswers: state.expectedAnswers,
      userInput: state.userInput,
      correctAnswers: state.correctAnswers,
      areTranslationsCorrect: state.areTranslationsCorrect
    ));
  }


  _validateExercisePart(event, emit) {

    //emit(MorseExerciseValidating());

    try {

      // Take the value from the expected answers array with the index in the event, and the user input from the event. Compare the two of them together in the function validateTranslation.
      // then save the response in the correctAnswers array (in the place of the index from the array) of the state and emmit the MorseExerciseValidated state.
      MorseCodeValidation isCorrect = MorseCodeRepository().validateTranslation(
        event.userInput,
        state.expectedAnswers![event.indexOfValueToCompare],
        event.valueAmount,
        event.translationType,
        state.areTranslationsCorrect?[event.indexOfValueToCompare] ?? false,
        event.interactionType,
        event.swiperDirection
      );

      final List<MorseCodeValidation> updatedCorrectAnswers = List.from(state.correctAnswers!);

      updatedCorrectAnswers.add(isCorrect);

      emit(MorseExerciseValidated(
        exerciseText: state.exerciseText,
        expectedAnswers: state.expectedAnswers,
        userInput: state.userInput,
        correctAnswers: updatedCorrectAnswers,
        areTranslationsCorrect: state.areTranslationsCorrect
      ));

    } catch (e) {

      final List<MorseCodeValidation> updatedCorrectAnswers = List.from(state.correctAnswers!);

      updatedCorrectAnswers.add(MorseCodeValidation.failed);

      emit(MorseExerciseNotValidated(
        exerciseText: state.exerciseText,
        expectedAnswers: state.expectedAnswers,
        userInput: state.userInput,
        correctAnswers: updatedCorrectAnswers,
        areTranslationsCorrect: state.areTranslationsCorrect
      ));
    }

  }

  _undoPreviousAnswer(event, emit) {
    // Remove the last element from the correct answers array and return the updated values.
    final List<MorseCodeValidation> updatedCorrectAnswers = List.from(state.correctAnswers!);

    if (updatedCorrectAnswers.isNotEmpty) {
      updatedCorrectAnswers.removeLast();
    }

    emit(MorseExerciseUndoCheck(
        exerciseText: state.exerciseText,
        expectedAnswers: state.expectedAnswers,
        userInput: state.userInput,
        correctAnswers: updatedCorrectAnswers,
        areTranslationsCorrect: state.areTranslationsCorrect
    ));


  }

}
