import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../../domain/value_objects/exercise_enums.dart';
import '../app_database.dart';
import 'corpus_parser.dart';
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
            translateType: CorpusParser.parseDirection(
                map['translateType'] as String),
            exerciseValues: jsonEncode(map['exerciseValues']),
            translatedValues: jsonEncode(map['translatedValues']),
            count: (map['exerciseValues'] as List<dynamic>).length,
            interactionType: CorpusParser.parseInteractionType(
                map['interactionType'] as String),
          ),
        );
      }
    }

    await db.batch((batch) {
      batch.insertAll(db.morseExercisesTable, companions);
    });
  }

}
