import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/semaphore.dart';
import 'package:tabornski_sos_prirocnik_frontend/repositories/semaphore_translation_respository.dart';

part 'semaphore_event.dart';
part 'semaphore_state.dart';

class SemaphoreBloc extends Bloc<SemaphoreEvent, SemaphoreState> {
  SemaphoreBloc()
      : super(SemaphoreInitial(
            languageSetting: SemaphoreLanguage(
                semaphoreSetting: SemaphoreLanguageSetting.none))) {
    on<UpdateTranslationTypeSemaphore>(
        (event, emit) => _mapUpdateTranslationTypeToState(event, emit));
    on<TranslateInputSemaphore>(
        (event, emit) => _mapTranslateInputToState(event, emit));
    on<ClearInputSemaphore>(
        (event, emit) => _mapClearInputToState(event, emit));
    on<UpdateSemaphoreImage>(
        (event, emit) => _mapUpdateSemaphoreImageToState(event, emit));
  }

  _mapUpdateTranslationTypeToState(UpdateTranslationTypeSemaphore event, emit) {
    if (state is SemaphoreInitial) {
      SemaphoreInitial initialState = state as SemaphoreInitial;
      emit(SemaphoreInitial(
          languageSetting: initialState.languageSetting
              .copyWith(semaphoreSetting: event.semaphoreLanguageType)));
    }
  }

  void _mapTranslateInputToState(
      TranslateInputSemaphore event, Emitter<SemaphoreState> emit) {
    SemaphoreRepository semaphoreRepository = SemaphoreRepository();
    if (state is SemaphoreInitial) {
      SemaphoreInitial initialState = state as SemaphoreInitial;

      emit(SemaphoreLoading(
          languageSetting: initialState.languageSetting.copyWith(
        text: event.inputText is String ? event.inputText : '',
        flags: event.inputText is List<String> ? event.inputText : [],
      )));

      if (initialState.languageSetting.semaphoreSetting ==
          SemaphoreLanguageSetting.textToFlags) {
        // Translate the input text to semaphore flags
        List<String> translatedFlags =
            semaphoreRepository.translateTextToSemaphore(event.inputText);
        emit(SemaphoreSuccess(
            languageSetting: initialState.languageSetting.copyWith(
          text: event.inputText,
          flags: translatedFlags,
        )));
      } else if (initialState.languageSetting.semaphoreSetting ==
          SemaphoreLanguageSetting.flagsToText) {
        // Translate the semaphore flags to text
        String translatedText = semaphoreRepository.translateSemaphoreToText(event.semaphoreLanguageModel.flags ?? []);
        emit(SemaphoreSuccess(
            languageSetting: initialState.languageSetting.copyWith(
          text: translatedText,
          flags: event.semaphoreLanguageModel.flags,
        )));
      }
    }
  }

  void _mapClearInputToState(ClearInputSemaphore event, Emitter<SemaphoreState> emit) {
    if (state is SemaphoreInitial) {
      SemaphoreInitial initialState = state as SemaphoreInitial;
      emit(SemaphoreInitial(
          languageSetting: initialState.languageSetting.copyWith(
        text: '',
        flags: [],
      )));
    }
  }

  void _mapUpdateSemaphoreImageToState(UpdateSemaphoreImage event, Emitter<SemaphoreState> emit) {

    SemaphoreInitial initialState = state as SemaphoreInitial;
    List<String> updatedFlags = List.from(initialState.languageSetting.flags ?? []);
    if(event.image != null) {
      updatedFlags.add(event.image.toString());
    }


    emit(SemaphoreInitial(
        languageSetting: initialState.languageSetting.copyWith(
          flags: updatedFlags,
        )));

  }

}
