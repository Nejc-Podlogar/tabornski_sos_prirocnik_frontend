import '../../domain/value_objects/exercise_enums.dart';

abstract final class CorpusParser {
  static TranslationDirection parseDirection(String value) {
    switch (value) {
      case 'textToMorse':
        return TranslationDirection.textToMorse;
      case 'morseToText':
        return TranslationDirection.morseToText;
      default:
        throw ArgumentError('Unknown translateType: $value');
    }
  }

  static InteractionType parseInteractionType(String value) {
    switch (value) {
      case 'cards':
        return InteractionType.cards;
      case 'keyboard':
        return InteractionType.keyboard;
      case 'tokens':
        return InteractionType.tokens;
      default:
        throw ArgumentError('Unknown interactionType: $value');
    }
  }
}
