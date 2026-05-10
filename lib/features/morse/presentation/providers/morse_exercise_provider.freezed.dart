// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'morse_exercise_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MorseExerciseState {
  List<MorseExercise> get exercises => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<ExerciseValidation?> get sessionResults =>
      throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Create a copy of MorseExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MorseExerciseStateCopyWith<MorseExerciseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MorseExerciseStateCopyWith<$Res> {
  factory $MorseExerciseStateCopyWith(
          MorseExerciseState value, $Res Function(MorseExerciseState) then) =
      _$MorseExerciseStateCopyWithImpl<$Res, MorseExerciseState>;
  @useResult
  $Res call(
      {List<MorseExercise> exercises,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      bool isComplete});
}

/// @nodoc
class _$MorseExerciseStateCopyWithImpl<$Res, $Val extends MorseExerciseState>
    implements $MorseExerciseStateCopyWith<$Res> {
  _$MorseExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MorseExerciseState
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
              as List<MorseExercise>,
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
abstract class _$$MorseExerciseStateImplCopyWith<$Res>
    implements $MorseExerciseStateCopyWith<$Res> {
  factory _$$MorseExerciseStateImplCopyWith(_$MorseExerciseStateImpl value,
          $Res Function(_$MorseExerciseStateImpl) then) =
      __$$MorseExerciseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MorseExercise> exercises,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      bool isComplete});
}

/// @nodoc
class __$$MorseExerciseStateImplCopyWithImpl<$Res>
    extends _$MorseExerciseStateCopyWithImpl<$Res, _$MorseExerciseStateImpl>
    implements _$$MorseExerciseStateImplCopyWith<$Res> {
  __$$MorseExerciseStateImplCopyWithImpl(_$MorseExerciseStateImpl _value,
      $Res Function(_$MorseExerciseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorseExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercises = null,
    Object? currentIndex = null,
    Object? sessionResults = null,
    Object? isComplete = null,
  }) {
    return _then(_$MorseExerciseStateImpl(
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<MorseExercise>,
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

class _$MorseExerciseStateImpl implements _MorseExerciseState {
  const _$MorseExerciseStateImpl(
      {required final List<MorseExercise> exercises,
      this.currentIndex = 0,
      required final List<ExerciseValidation?> sessionResults,
      this.isComplete = false})
      : _exercises = exercises,
        _sessionResults = sessionResults;

  final List<MorseExercise> _exercises;
  @override
  List<MorseExercise> get exercises {
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
    return 'MorseExerciseState(exercises: $exercises, currentIndex: $currentIndex, sessionResults: $sessionResults, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MorseExerciseStateImpl &&
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

  /// Create a copy of MorseExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MorseExerciseStateImplCopyWith<_$MorseExerciseStateImpl> get copyWith =>
      __$$MorseExerciseStateImplCopyWithImpl<_$MorseExerciseStateImpl>(
          this, _$identity);
}

abstract class _MorseExerciseState implements MorseExerciseState {
  const factory _MorseExerciseState(
      {required final List<MorseExercise> exercises,
      final int currentIndex,
      required final List<ExerciseValidation?> sessionResults,
      final bool isComplete}) = _$MorseExerciseStateImpl;

  @override
  List<MorseExercise> get exercises;
  @override
  int get currentIndex;
  @override
  List<ExerciseValidation?> get sessionResults;
  @override
  bool get isComplete;

  /// Create a copy of MorseExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MorseExerciseStateImplCopyWith<_$MorseExerciseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
