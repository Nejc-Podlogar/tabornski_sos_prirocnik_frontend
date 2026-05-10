// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExerciseSession {
  int? get id => throw _privateConstructorUsedError;
  FeatureType get featureType => throw _privateConstructorUsedError;
  String get exerciseContentType => throw _privateConstructorUsedError;
  String get interactionType => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get correctCount => throw _privateConstructorUsedError;
  DateTime get sessionDate => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseSessionCopyWith<ExerciseSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseSessionCopyWith<$Res> {
  factory $ExerciseSessionCopyWith(
          ExerciseSession value, $Res Function(ExerciseSession) then) =
      _$ExerciseSessionCopyWithImpl<$Res, ExerciseSession>;
  @useResult
  $Res call(
      {int? id,
      FeatureType featureType,
      String exerciseContentType,
      String interactionType,
      int totalQuestions,
      int correctCount,
      DateTime sessionDate,
      int durationSeconds});
}

/// @nodoc
class _$ExerciseSessionCopyWithImpl<$Res, $Val extends ExerciseSession>
    implements $ExerciseSessionCopyWith<$Res> {
  _$ExerciseSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? featureType = null,
    Object? exerciseContentType = null,
    Object? interactionType = null,
    Object? totalQuestions = null,
    Object? correctCount = null,
    Object? sessionDate = null,
    Object? durationSeconds = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      featureType: null == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as FeatureType,
      exerciseContentType: null == exerciseContentType
          ? _value.exerciseContentType
          : exerciseContentType // ignore: cast_nullable_to_non_nullable
              as String,
      interactionType: null == interactionType
          ? _value.interactionType
          : interactionType // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDate: null == sessionDate
          ? _value.sessionDate
          : sessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseSessionImplCopyWith<$Res>
    implements $ExerciseSessionCopyWith<$Res> {
  factory _$$ExerciseSessionImplCopyWith(_$ExerciseSessionImpl value,
          $Res Function(_$ExerciseSessionImpl) then) =
      __$$ExerciseSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      FeatureType featureType,
      String exerciseContentType,
      String interactionType,
      int totalQuestions,
      int correctCount,
      DateTime sessionDate,
      int durationSeconds});
}

/// @nodoc
class __$$ExerciseSessionImplCopyWithImpl<$Res>
    extends _$ExerciseSessionCopyWithImpl<$Res, _$ExerciseSessionImpl>
    implements _$$ExerciseSessionImplCopyWith<$Res> {
  __$$ExerciseSessionImplCopyWithImpl(
      _$ExerciseSessionImpl _value, $Res Function(_$ExerciseSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? featureType = null,
    Object? exerciseContentType = null,
    Object? interactionType = null,
    Object? totalQuestions = null,
    Object? correctCount = null,
    Object? sessionDate = null,
    Object? durationSeconds = null,
  }) {
    return _then(_$ExerciseSessionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      featureType: null == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as FeatureType,
      exerciseContentType: null == exerciseContentType
          ? _value.exerciseContentType
          : exerciseContentType // ignore: cast_nullable_to_non_nullable
              as String,
      interactionType: null == interactionType
          ? _value.interactionType
          : interactionType // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctCount: null == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDate: null == sessionDate
          ? _value.sessionDate
          : sessionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ExerciseSessionImpl implements _ExerciseSession {
  const _$ExerciseSessionImpl(
      {required this.id,
      required this.featureType,
      required this.exerciseContentType,
      required this.interactionType,
      required this.totalQuestions,
      required this.correctCount,
      required this.sessionDate,
      required this.durationSeconds})
      : assert(correctCount <= totalQuestions,
            'correctCount cannot exceed totalQuestions');

  @override
  final int? id;
  @override
  final FeatureType featureType;
  @override
  final String exerciseContentType;
  @override
  final String interactionType;
  @override
  final int totalQuestions;
  @override
  final int correctCount;
  @override
  final DateTime sessionDate;
  @override
  final int durationSeconds;

  @override
  String toString() {
    return 'ExerciseSession(id: $id, featureType: $featureType, exerciseContentType: $exerciseContentType, interactionType: $interactionType, totalQuestions: $totalQuestions, correctCount: $correctCount, sessionDate: $sessionDate, durationSeconds: $durationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.featureType, featureType) ||
                other.featureType == featureType) &&
            (identical(other.exerciseContentType, exerciseContentType) ||
                other.exerciseContentType == exerciseContentType) &&
            (identical(other.interactionType, interactionType) ||
                other.interactionType == interactionType) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctCount, correctCount) ||
                other.correctCount == correctCount) &&
            (identical(other.sessionDate, sessionDate) ||
                other.sessionDate == sessionDate) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      featureType,
      exerciseContentType,
      interactionType,
      totalQuestions,
      correctCount,
      sessionDate,
      durationSeconds);

  /// Create a copy of ExerciseSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseSessionImplCopyWith<_$ExerciseSessionImpl> get copyWith =>
      __$$ExerciseSessionImplCopyWithImpl<_$ExerciseSessionImpl>(
          this, _$identity);
}

abstract class _ExerciseSession implements ExerciseSession {
  const factory _ExerciseSession(
      {required final int? id,
      required final FeatureType featureType,
      required final String exerciseContentType,
      required final String interactionType,
      required final int totalQuestions,
      required final int correctCount,
      required final DateTime sessionDate,
      required final int durationSeconds}) = _$ExerciseSessionImpl;

  @override
  int? get id;
  @override
  FeatureType get featureType;
  @override
  String get exerciseContentType;
  @override
  String get interactionType;
  @override
  int get totalQuestions;
  @override
  int get correctCount;
  @override
  DateTime get sessionDate;
  @override
  int get durationSeconds;

  /// Create a copy of ExerciseSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseSessionImplCopyWith<_$ExerciseSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
