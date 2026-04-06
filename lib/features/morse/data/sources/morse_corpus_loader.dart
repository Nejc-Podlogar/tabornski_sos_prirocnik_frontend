import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/morse_exercise.dart';
import '../../domain/value_objects/exercise_content_type.dart';
import '../../domain/value_objects/interaction_type.dart';
import '../../domain/value_objects/translation_direction.dart';

class MorseCorpusLoader {
  const MorseCorpusLoader();

  Future<List<MorseExercise>> load() async {
    try {
      final raw =
          await rootBundle.loadString('assets/data/morse_corpus.json');
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final result = <MorseExercise>[];

      for (final contentKey in ['words', 'sentences']) {
        final contentType = contentKey == 'words'
            ? ExerciseContentType.words
            : ExerciseContentType.sentences;

        final entries = (json[contentKey] as List<dynamic>?) ?? [];
        for (final entry in entries) {
          final map = entry as Map<String, dynamic>;
          final exerciseValues =
              (map['exerciseValues'] as List<dynamic>).cast<String>();
          final translatedValues =
              (map['translatedValues'] as List<dynamic>).cast<String>();
          final direction = _parseDirection(map['translateType'] as String);
          final interactionType =
              _parseInteractionType(map['interactionType'] as String);

          result.add(MorseExercise(
            exerciseValues: exerciseValues,
            translatedValues: translatedValues,
            areCorrect: List.filled(exerciseValues.length, null),
            currentIndex: 0,
            contentType: contentType,
            direction: direction,
            interactionType: interactionType,
          ));
        }
      }

      return result;
    } catch (_) {
      return [];
    }
  }

  TranslationDirection _parseDirection(String value) {
    return value == 'morseToText'
        ? TranslationDirection.morseToText
        : TranslationDirection.textToMorse;
  }

  InteractionType _parseInteractionType(String value) {
    switch (value) {
      case 'keyboard':
        return InteractionType.keyboard;
      case 'tokens':
        return InteractionType.tokens;
      default:
        return InteractionType.cards;
    }
  }
}
