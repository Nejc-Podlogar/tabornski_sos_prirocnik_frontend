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
      String correctTranslation = '';

      if (direction == TranslationDirection.textToMorse) {
        exerciseValue = char;
        if (isCorrectPair) {
          translatedValue = correctMorse;
        } else {
          final wrongChars = allChars.where((c) => c != char).toList()
            ..shuffle(_random);
          translatedValue = MorseDictionary.charToMorse[wrongChars.first]!;
          correctTranslation = correctMorse;
        }
      } else {
        exerciseValue = correctMorse;
        if (isCorrectPair) {
          translatedValue = char;
        } else {
          final wrongChars = allChars.where((c) => c != char).toList()
            ..shuffle(_random);
          translatedValue = wrongChars.first;
          correctTranslation = char;
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
        correctTranslation: correctTranslation,
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
              t.interactionType.equalsValue(interactionType)))
        .get();

    final allExercises = rows
        .map(MorseExerciseMapper.fromRow)
        .toList()
      ..shuffle(_random);

    final selected = allExercises.take(count).toList();

    final allValues =
        allExercises.map((e) => e.exerciseValues[0]).toList();

    return selected.map((exercise) {
      final isCorrectPair = _random.nextDouble() > 0.4;

      if (isCorrectPair) {
        return exercise.copyWith(isCorrectPair: true);
      }

      final wrongValues = allValues
          .where((v) => v != exercise.exerciseValues[0])
          .toList()
        ..shuffle(_random);

      if (wrongValues.isEmpty) {
        return exercise.copyWith(isCorrectPair: true);
      }

      final wrongExercise = allExercises.firstWhere(
        (e) => e.exerciseValues[0] == wrongValues.first,
        orElse: () => exercise,
      );
      return exercise.copyWith(
        translatedValues: wrongExercise.translatedValues,
        isCorrectPair: false,
        correctTranslation: exercise.translatedValues[0],
      );
    }).toList();
  }
}
