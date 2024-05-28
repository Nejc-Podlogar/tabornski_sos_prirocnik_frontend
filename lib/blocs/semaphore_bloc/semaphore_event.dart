part of 'semaphore_bloc.dart';

@immutable
abstract class SemaphoreEvent {}

class TranslateInputSemaphore extends SemaphoreEvent {
  final dynamic inputText;
  final SemaphoreLanguage semaphoreLanguageModel;

  TranslateInputSemaphore(
      {required this.inputText, required this.semaphoreLanguageModel});
}

class ClearInputSemaphore extends SemaphoreEvent {
  ClearInputSemaphore();
}

class UpdateTranslationTypeSemaphore extends SemaphoreEvent {
  final SemaphoreLanguageSetting semaphoreLanguageType;

  UpdateTranslationTypeSemaphore({required this.semaphoreLanguageType});
}

class UpdateSemaphoreImage extends SemaphoreEvent {
  final String? image;

  UpdateSemaphoreImage({required this.image});
}
  