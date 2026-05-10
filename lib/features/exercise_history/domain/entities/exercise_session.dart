import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/feature_type.dart';

part 'exercise_session.freezed.dart';

@freezed
class ExerciseSession with _$ExerciseSession {
  @Assert(
    'correctCount <= totalQuestions',
    'correctCount cannot exceed totalQuestions',
  )
  const factory ExerciseSession({
    required int? id,
    required FeatureType featureType,
    required String exerciseContentType,
    required String interactionType,
    required int totalQuestions,
    required int correctCount,
    required DateTime sessionDate,
    required int durationSeconds,
  }) = _ExerciseSession;
}
