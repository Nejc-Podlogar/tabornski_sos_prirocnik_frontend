// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semaphore_exercise_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemaphoreExerciseState {
  List<SemaphoreExercise> get exercises => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<ExerciseValidation?> get sessionResults =>
      throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Create a copy of SemaphoreExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemaphoreExerciseStateCopyWith<SemaphoreExerciseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemaphoreExerciseStateCopyWith<$Res> {
  factory $SemaphoreExerciseStateCopyWith(SemaphoreExerciseState value,
          $Res Function(SemaphoreExerciseState) then) =
      _$SemaphoreExerciseStateCopyWithImpl<$Res, SemaphoreExerciseState>;
  @useResult
  $Res call(
      {List<SemaphoreExercise> exercises,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      bool isComplete});
}

/// @nodoc
class _$SemaphoreExerciseStateCopyWithImpl<$Res,
        $Val extends SemaphoreExerciseState>
    implements $SemaphoreExerciseStateCopyWith<$Res> {
  _$SemaphoreExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemaphoreExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercises = null,
    Object? currentIndex = null,
    Object? sessionResults = null,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<SemaphoreExercise>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sessionResults: null == sessionResults
          ? _value.sessionResults
          : sessionResults // ignore: cast_nullable_to_non_nullable
              as List<ExerciseValidation?>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemaphoreExerciseStateImplCopyWith<$Res>
    implements $SemaphoreExerciseStateCopyWith<$Res> {
  factory _$$SemaphoreExerciseStateImplCopyWith(
          _$SemaphoreExerciseStateImpl value,
          $Res Function(_$SemaphoreExerciseStateImpl) then) =
      __$$SemaphoreExerciseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SemaphoreExercise> exercises,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      bool isComplete});
}

/// @nodoc
class __$$SemaphoreExerciseStateImplCopyWithImpl<$Res>
    extends _$SemaphoreExerciseStateCopyWithImpl<$Res,
        _$SemaphoreExerciseStateImpl>
    implements _$$SemaphoreExerciseStateImplCopyWith<$Res> {
  __$$SemaphoreExerciseStateImplCopyWithImpl(
      _$SemaphoreExerciseStateImpl _value,
      $Res Function(_$SemaphoreExerciseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemaphoreExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercises = null,
    Object? currentIndex = null,
    Object? sessionResults = null,
    Object? isComplete = null,
  }) {
    return _then(_$SemaphoreExerciseStateImpl(
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<SemaphoreExercise>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sessionResults: null == sessionResults
          ? _value._sessionResults
          : sessionResults // ignore: cast_nullable_to_non_nullable
              as List<ExerciseValidation?>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SemaphoreExerciseStateImpl implements _SemaphoreExerciseState {
  const _$SemaphoreExerciseStateImpl(
      {required final List<SemaphoreExercise> exercises,
      this.currentIndex = 0,
      required final List<ExerciseValidation?> sessionResults,
      this.isComplete = false})
      : _exercises = exercises,
        _sessionResults = sessionResults;

  final List<SemaphoreExercise> _exercises;
  @override
  List<SemaphoreExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  @JsonKey()
  final int currentIndex;
  final List<ExerciseValidation?> _sessionResults;
  @override
  List<ExerciseValidation?> get sessionResults {
    if (_sessionResults is EqualUnmodifiableListView) return _sessionResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionResults);
  }

  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'SemaphoreExerciseState(exercises: $exercises, currentIndex: $currentIndex, sessionResults: $sessionResults, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemaphoreExerciseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality()
                .equals(other._sessionResults, _sessionResults) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_exercises),
      currentIndex,
      const DeepCollectionEquality().hash(_sessionResults),
      isComplete);

  /// Create a copy of SemaphoreExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemaphoreExerciseStateImplCopyWith<_$SemaphoreExerciseStateImpl>
      get copyWith => __$$SemaphoreExerciseStateImplCopyWithImpl<
          _$SemaphoreExerciseStateImpl>(this, _$identity);
}

abstract class _SemaphoreExerciseState implements SemaphoreExerciseState {
  const factory _SemaphoreExerciseState(
      {required final List<SemaphoreExercise> exercises,
      final int currentIndex,
      required final List<ExerciseValidation?> sessionResults,
      final bool isComplete}) = _$SemaphoreExerciseStateImpl;

  @override
  List<SemaphoreExercise> get exercises;
  @override
  int get currentIndex;
  @override
  List<ExerciseValidation?> get sessionResults;
  @override
  bool get isComplete;

  /// Create a copy of SemaphoreExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemaphoreExerciseStateImplCopyWith<_$SemaphoreExerciseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
