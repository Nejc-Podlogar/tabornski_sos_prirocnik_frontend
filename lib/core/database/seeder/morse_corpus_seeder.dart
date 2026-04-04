import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../../features/morse/domain/value_objects/exercise_content_type.dart';
import '../../../features/morse/domain/value_objects/interaction_type.dart';
import '../../../features/morse/domain/value_objects/translation_direction.dart';
import '../app_database.dart';
import 'i_seeder.dart';

class MorseCorpusSeeder implements ISeeder {
  @override
  Future<void> seed(AppDatabase db) async {
    final raw = await rootBundle.loadString('assets/data/morse_corpus.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;

    final companions = <MorseExercisesTableCompanion>[];

    for (final contentKey in ['words', 'sentences']) {
      final contentType = contentKey == 'words'
          ? ExerciseContentType.words
          : ExerciseContentType.sentences;

      final entries = (json[contentKey] as List<dynamic>?) ?? [];
      for (final entry in entries) {
        final map = entry as Map<String, dynamic>;
        companions.add(
          MorseExercisesTableCompanion.insert(
            exerciseContentType: contentType,
            translateType: _parseTranslationDirection(
                map['translateType'] as String),
            exerciseValues: jsonEncode(map['exerciseValues']),
            translatedValues: jsonEncode(map['translatedValues']),
            count: (map['exerciseValues'] as List<dynamic>).length,
            interactionType: _parseInteractionType(
                map['interactionType'] as String),
          ),
        );
      }
    }

    await db.batch((batch) {
      batch.insertAll(db.morseExercisesTable, companions);
    });
  }

  TranslationDirection _parseTranslationDirection(String value) {
    switch (value) {
      case 'textToMorse':
        return TranslationDirection.textToMorse;
      case 'morseToText':
        return TranslationDirection.morseToText;
      default:
        throw ArgumentError('Unknown translateType: $value');
    }
  }

  InteractionType _parseInteractionType(String value) {
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
