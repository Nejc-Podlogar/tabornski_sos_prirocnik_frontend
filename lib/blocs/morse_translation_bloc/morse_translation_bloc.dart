import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/models.dart';
import 'package:tabornski_sos_prirocnik_frontend/repositories/morde_translation_repository.dart';
import 'package:torch_controller/torch_controller.dart';

part 'morse_translation_event.dart';
part 'morse_translation_state.dart';

class MorseTranslationBloc
    extends Bloc<MorseTranslationEvent, MorseTranslationState> {
  MorseTranslationBloc()
      : super(MorseTranslationInitial(
            languageSetting: MorseCodeLanguage(
                languageSetting: MorseLanguageSetting.none),
            isAutoRepeating: false)) {
    on<UpdateTranslationType>(
        (event, emit) => _mapUpdateTranslationTypeToState(event, emit));
    on<TranslateInput>((event, emit) => _mapTranslateInputToState(event, emit));
    on<ClearInput>((event, emit) => _mapClearInputToState(event, emit));
    on<ToggleTransmitting>(
        (event, emit) => _mapToggleTransmittingToState(event, emit),
        transformer: restartable());
    on<ToggleAutoRepeat>(
        (event, emit) => _mapToggleAutoRepeatToState(event, emit));
  }

  bool _isTransmitting = false;
  bool get isTransmitting => _isTransmitting;

  _mapToggleAutoRepeatToState(ToggleAutoRepeat event, emit) {
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;
      emit(MorseTranslationInitial(
          languageSetting: initialState.languageSetting,
          isAutoRepeating: event.isAutoRepeating));
    }
  }

  _mapUpdateTranslationTypeToState(UpdateTranslationType event, emit) {
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;
      emit(MorseTranslationInitial(
          languageSetting: initialState.languageSetting
              .copyWith(languageSetting: event.morseCodeLanguageType),
          isAutoRepeating: state.isAutoRepeating)
          );
    }
  }

  _mapTranslateInputToState(TranslateInput event, emit) {
    MorseCodeRepository morseCodeRepository = MorseCodeRepository();
    if (state is MorseTranslationInitial) {
      MorseTranslationInitial initialState = state as MorseTranslationInitial;

      emit(MorseTranslationLoading(
          languageSetting:
              initialState.languageSetting.copyWith(inputText: event.inputText),
          isAutoRepeating: state.isAutoRepeating));

      if (initialState.languageSetting.languageSetting ==
          MorseLanguageSetting.textToMorse) {
        try {
          emit(MorseTranslationSuccess(
              languageSetting: initialState.languageSetting.copyWith(
                  inputText: event.inputText,
                  translatedText: morseCodeRepository
                      .translateToMorseCode(event.inputText)),
              isAutoRepeating: state.isAutoRepeating));
        } catch (e) {
          emit(MorseTranslationFailure(
              errorMessage:
                  "Problem with translating the inputted text to morse code. Please validate that you only use allowed characters.",
              languageSetting: initialState.languageSetting.copyWith(
                inputText: event.inputText,
                languageSetting: initialState.languageSetting.languageSetting,
                translatedText: null,
              ),
              isAutoRepeating: state.isAutoRepeating));
        }
      } else if (initialState.languageSetting.languageSetting ==
          MorseLanguageSetting.morseToText) {
        try {
          emit(MorseTranslationSuccess(
              languageSetting: initialState.languageSetting.copyWith(
                  inputText: event.inputText,
                  translatedText:
                      morseCodeRepository.translateToText(event.inputText)),
              isAutoRepeating: state.isAutoRepeating));
        } catch (e) {
          emit(MorseTranslationFailure(
              errorMessage:
                  "Problem with translating the inputted morse code to text. Please validate that you only use allowed characters ( . - / ).",
              languageSetting: initialState.languageSetting.copyWith(
                inputText: event.inputText,
                languageSetting: initialState.languageSetting.languageSetting,
                translatedText: null,
              ),
              isAutoRepeating: state.isAutoRepeating));
        }
      }
    } else {
      emit(MorseTranslationFailure(
          errorMessage:
              "Problem with translating the inputted text. Please try again.",
          languageSetting:
              MorseCodeLanguage(languageSetting: MorseLanguageSetting.none),
          isAutoRepeating: (state as MorseTranslationInitial).isAutoRepeating));
    }
  }

  _mapClearInputToState(ClearInput event, emit) {
    emit(MorseTranslationInitial(
        languageSetting: MorseCodeLanguage(
            languageSetting: state.languageSetting.languageSetting,
            inputText: null,
            translatedText: null),
        isAutoRepeating: state.isAutoRepeating));
  }

  _mapToggleTransmittingToState(ToggleTransmitting event, emit) async {
    try {
      final TorchController torchController = TorchController();
      torchController.initialize(intensity: 0.0);

      if (state is MorseTranslationInitial) {
        MorseTranslationInitial initialState = state as MorseTranslationInitial;

        if (initialState.languageSetting.translatedText == null ||
            initialState.languageSetting.languageSetting !=
                MorseLanguageSetting.textToMorse ||
            await torchController.hasTorch == false) {
          emit(MorseTorchTransmittingFailure(
              errorMessage:
                  "Problem with starting the torch transmitting. Please validate that you have translated the text to morse code and that you have the correct language setting.",
              languageSetting: initialState.languageSetting.copyWith(
                translatedText: event.morseCode,
              ),
              isAutoRepeating: state.isAutoRepeating));
          return;
        }

        if (_isTransmitting) {
          if (await torchController.isTorchActive == true) {
            await torchController.toggle();
          }

          _isTransmitting = false;
          emit(MorseTorchStoppedTransmitting(
              languageSetting: initialState.languageSetting.copyWith(
                translatedText: event.morseCode,
              ),
              isAutoRepeating: state.isAutoRepeating));
        } else {
          _isTransmitting = true;
          emit(MorseTorchStartedTransmitting(
              languageSetting: initialState.languageSetting.copyWith(
                translatedText: event.morseCode,
              ),
              isAutoRepeating: state.isAutoRepeating));

          if (await torchController.isTorchActive == true) {
            await torchController.toggle();
          }

          final String morseCode = initialState.languageSetting.translatedText!;
          do {
            for (int i = 0; i < morseCode.length; i++) {
              if (morseCode[i] == ".") {
                torchController.toggle(intensity: 1.0);
                await Future.delayed(const Duration(milliseconds: 100));
                torchController.toggle(intensity: 0.0);
              } else if (morseCode[i] == "-") {
                torchController.toggle(intensity: 1.0);
                await Future.delayed(const Duration(milliseconds: 300));
                torchController.toggle(intensity: 0.0);
              } else if (morseCode[i] == "/") {
                await Future.delayed(const Duration(milliseconds: 700));
              }

              await Future.delayed(const Duration(milliseconds: 100));

              if (!_isTransmitting) {
                // If not, break out of the loop
                break;
              }
            }
          } while (state.isAutoRepeating && _isTransmitting);

          if (await torchController.isTorchActive == true) {
            await torchController.toggle();
          }

          emit(MorseTorchStoppedTransmitting(
              languageSetting: initialState.languageSetting.copyWith(
                translatedText: event.morseCode,
              ),
              isAutoRepeating: state.isAutoRepeating));
        }
      }
    } catch (e) {
      final MorseTranslationInitial initialState =
          state as MorseTranslationInitial;
      emit(MorseTorchTransmittingFailure(
          errorMessage:
              "Problem with starting the torch transmitting. Please try again.",
          languageSetting: initialState.languageSetting.copyWith(
            translatedText: event.morseCode,
          ),
          isAutoRepeating: state.isAutoRepeating));
    }
  }
}
