import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/models.dart';
import 'package:tabornski_sos_prirocnik_frontend/repositories/morde_translation_repository.dart';

part 'morse_translation_event.dart';
part 'morse_translation_state.dart';

class MorseTranslationBloc
    extends Bloc<MorseTranslationEvent, MorseTranslationState> {
  MorseTranslationBloc()
      : super(MorseTranslationInitial(
            languageSetting: MorseCodeLanguage(
                languageSetting: MorseLanguageSetting.none))) {
    on<UpdateTranslationType>((event, emit) => _mapUpdateTranslationTypeToState(event, emit));
    on<TranslateInput>((event, emit) => _mapTranslateInputToState(event, emit));
    on<ClearInput>((event, emit) => _mapClearInputToState(event, emit));
  }

  _mapUpdateTranslationTypeToState(UpdateTranslationType event, emit) {
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;
      emit(MorseTranslationInitial(
          languageSetting: initialState.languageSetting
              .copyWith(languageSetting: event.morseCodeLanguageType)));
    }
  }

  _mapTranslateInputToState(TranslateInput event, emit) {
    MorseCodeRepository morseCodeRepository = MorseCodeRepository();
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;

      emit(MorseTranslationLoading(
          languageSetting: initialState.languageSetting
              .copyWith(inputText: event.inputText)));

      if (initialState.languageSetting.languageSetting ==
          MorseLanguageSetting.textToMorse) {
        try {
          emit(MorseTranslationSuccess(
              languageSetting: initialState.languageSetting.copyWith(
                  inputText: event.inputText,
                  translatedText: morseCodeRepository
                      .translateToMorseCode(event.inputText))));
        } catch (e) {
          emit(MorseTranslationFailure(
              errorMessage: "Problem with translating the inputted text to morse code. Please validate that you only use allowed characters.",
              languageSetting: initialState.languageSetting.copyWith(
                inputText: event.inputText,
                languageSetting: initialState.languageSetting.languageSetting,
                translatedText: null,
              )));
        }
      } else if (initialState.languageSetting.languageSetting ==
          MorseLanguageSetting.morseToText) {
        try {
          emit(MorseTranslationSuccess(
              languageSetting: initialState.languageSetting.copyWith(
                  inputText: event.inputText,
                  translatedText:
                  morseCodeRepository.translateToText(event.inputText))));
        } catch (e) {
          emit(MorseTranslationFailure(
              errorMessage: "Problem with translating the inputted morse code to text. Please validate that you only use allowed characters ( . - / ).",
              languageSetting: initialState.languageSetting.copyWith(
                inputText: event.inputText,
                languageSetting: initialState.languageSetting.languageSetting,
                translatedText: null,
              )));
        }
      }
    } else {
      emit(MorseTranslationFailure(
          errorMessage: "Problem with translating the inputted text. Please try again.",
          languageSetting: MorseCodeLanguage(
              languageSetting: MorseLanguageSetting.none)));
    }
  }

  _mapClearInputToState(ClearInput event, emit) {
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;
      emit(MorseTranslationInitial(
          languageSetting: initialState.languageSetting.copyWith(
              inputText: null, translatedText: null)));
    }
  }
}
