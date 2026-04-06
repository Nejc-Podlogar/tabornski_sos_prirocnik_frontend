import '../repositories/i_morse_translation_repository.dart';
import '../value_objects/translation_direction.dart';

class TranslateMorseUseCase {
  const TranslateMorseUseCase(this._repository);

  final IMorseTranslationRepository _repository;

  String call(String input, TranslationDirection direction) =>
      _repository.translate(input, direction);
}
