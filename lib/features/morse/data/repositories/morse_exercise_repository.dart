import 'dart:math';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../domain/entities/morse_exercise.dart';
import '../../domain/repositories/i_morse_exercise_repository.dart';
import '../mappers/morse_exercise_mapper.dart';
import '../sources/morse_dictionary.dart';

class MorseExerciseRepository implements IMorseExerciseRepository {
  const MorseExerciseRepository(this._db);

  final AppDatabase _db;

  static final _random = Random();

  @override
  Future<List<MorseExercise>> getLetterExercises(
    int count,
    TranslationDirection direction,
    InteractionType interactionType,
  ) async {
    final allChars = MorseDictionary.charToMorse.keys
        .where((k) => RegExp(r'^[A-Z]$').hasMatch(k))
        .toList();

    allChars.shuffle(_random);
    final selected = allChars.take(count).toList();

    return selected.map((char) {
      final isCorrectPair = _random.nextDouble() < 0.6;
      final correctMorse = MorseDictionary.charToMorse[char]!;

      String exerciseValue;
      String translatedValue;

      if (direction == TranslationDirection.textToMorse) {
        exerciseValue = char;
        if (isCorrectPair) {
          translatedValue = correctMorse;
        } else {
          final wrongChars = allChars.where((c) => c != char).toList()
            ..shuffle(_random);
          translatedValue = MorseDictionary.charToMorse[wrongChars.first]!;
        }
      } else {
        exerciseValue = correctMorse;
        if (isCorrectPair) {
          translatedValue = char;
        } else {
          final wrongChars = allChars.where((c) => c != char).toList()
            ..shuffle(_random);
          translatedValue = wrongChars.first;
        }
      }

      return MorseExercise(
        exerciseValues: [exerciseValue],
        translatedValues: [translatedValue],
        areCorrect: [null],
        currentIndex: 0,
        contentType: ExerciseContentType.letters,
        direction: direction,
        interactionType: interactionType,
        isCorrectPair: isCorrectPair,
      );
    }).toList();
  }

  @override
  Future<List<MorseExercise>> getCorpusExercises(
    int count,
    ExerciseContentType contentType,
    TranslationDirection direction,
    InteractionType interactionType,
  ) async {
    final rows = await (_db.select(_db.morseExercisesTable)
          ..where((t) =>
              t.exerciseContentType.equalsValue(contentType) &
              t.translateType.equalsValue(direction) &
              t.interactionType.equalsValue(interactionType))
          ..limit(count))
        .get();

    return rows.map(MorseExerciseMapper.fromRow).toList();
  }
}
