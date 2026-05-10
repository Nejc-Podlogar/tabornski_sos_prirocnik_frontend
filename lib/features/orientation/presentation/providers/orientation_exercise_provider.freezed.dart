// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orientation_exercise_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrientationExerciseState {
  List<OrientationSign> get signs => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  List<ExerciseValidation?> get sessionResults =>
      throw _privateConstructorUsedError;
  Set<TopoGroupType> get selectedGroups => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;

  /// Create a copy of OrientationExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrientationExerciseStateCopyWith<OrientationExerciseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrientationExerciseStateCopyWith<$Res> {
  factory $OrientationExerciseStateCopyWith(OrientationExerciseState value,
          $Res Function(OrientationExerciseState) then) =
      _$OrientationExerciseStateCopyWithImpl<$Res, OrientationExerciseState>;
  @useResult
  $Res call(
      {List<OrientationSign> signs,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      Set<TopoGroupType> selectedGroups,
      bool isComplete});
}

/// @nodoc
class _$OrientationExerciseStateCopyWithImpl<$Res,
        $Val extends OrientationExerciseState>
    implements $OrientationExerciseStateCopyWith<$Res> {
  _$OrientationExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrientationExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signs = null,
    Object? currentIndex = null,
    Object? sessionResults = null,
    Object? selectedGroups = null,
    Object? isComplete = null,
  }) {
    return _then(_value.copyWith(
      signs: null == signs
          ? _value.signs
          : signs // ignore: cast_nullable_to_non_nullable
              as List<OrientationSign>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sessionResults: null == sessionResults
          ? _value.sessionResults
          : sessionResults // ignore: cast_nullable_to_non_nullable
              as List<ExerciseValidation?>,
      selectedGroups: null == selectedGroups
          ? _value.selectedGroups
          : selectedGroups // ignore: cast_nullable_to_non_nullable
              as Set<TopoGroupType>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrientationExerciseStateImplCopyWith<$Res>
    implements $OrientationExerciseStateCopyWith<$Res> {
  factory _$$OrientationExerciseStateImplCopyWith(
          _$OrientationExerciseStateImpl value,
          $Res Function(_$OrientationExerciseStateImpl) then) =
      __$$OrientationExerciseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<OrientationSign> signs,
      int currentIndex,
      List<ExerciseValidation?> sessionResults,
      Set<TopoGroupType> selectedGroups,
      bool isComplete});
}

/// @nodoc
class __$$OrientationExerciseStateImplCopyWithImpl<$Res>
    extends _$OrientationExerciseStateCopyWithImpl<$Res,
        _$OrientationExerciseStateImpl>
    implements _$$OrientationExerciseStateImplCopyWith<$Res> {
  __$$OrientationExerciseStateImplCopyWithImpl(
      _$OrientationExerciseStateImpl _value,
      $Res Function(_$OrientationExerciseStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrientationExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signs = null,
    Object? currentIndex = null,
    Object? sessionResults = null,
    Object? selectedGroups = null,
    Object? isComplete = null,
  }) {
    return _then(_$OrientationExerciseStateImpl(
      signs: null == signs
          ? _value._signs
          : signs // ignore: cast_nullable_to_non_nullable
              as List<OrientationSign>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sessionResults: null == sessionResults
          ? _value._sessionResults
          : sessionResults // ignore: cast_nullable_to_non_nullable
              as List<ExerciseValidation?>,
      selectedGroups: null == selectedGroups
          ? _value._selectedGroups
          : selectedGroups // ignore: cast_nullable_to_non_nullable
              as Set<TopoGroupType>,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OrientationExerciseStateImpl implements _OrientationExerciseState {
  const _$OrientationExerciseStateImpl(
      {required final List<OrientationSign> signs,
      this.currentIndex = 0,
      required final List<ExerciseValidation?> sessionResults,
      required final Set<TopoGroupType> selectedGroups,
      this.isComplete = false})
      : _signs = signs,
        _sessionResults = sessionResults,
        _selectedGroups = selectedGroups;

  final List<OrientationSign> _signs;
  @override
  List<OrientationSign> get signs {
    if (_signs is EqualUnmodifiableListView) return _signs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signs);
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

  final Set<TopoGroupType> _selectedGroups;
  @override
  Set<TopoGroupType> get selectedGroups {
    if (_selectedGroups is EqualUnmodifiableSetView) return _selectedGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedGroups);
  }

  @override
  @JsonKey()
  final bool isComplete;

  @override
  String toString() {
    return 'OrientationExerciseState(signs: $signs, currentIndex: $currentIndex, sessionResults: $sessionResults, selectedGroups: $selectedGroups, isComplete: $isComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrientationExerciseStateImpl &&
            const DeepCollectionEquality().equals(other._signs, _signs) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality()
                .equals(other._sessionResults, _sessionResults) &&
            const DeepCollectionEquality()
                .equals(other._selectedGroups, _selectedGroups) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_signs),
      currentIndex,
      const DeepCollectionEquality().hash(_sessionResults),
      const DeepCollectionEquality().hash(_selectedGroups),
      isComplete);

  /// Create a copy of OrientationExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrientationExerciseStateImplCopyWith<_$OrientationExerciseStateImpl>
      get copyWith => __$$OrientationExerciseStateImplCopyWithImpl<
          _$OrientationExerciseStateImpl>(this, _$identity);
}

abstract class _OrientationExerciseState implements OrientationExerciseState {
  const factory _OrientationExerciseState(
      {required final List<OrientationSign> signs,
      final int currentIndex,
      required final List<ExerciseValidation?> sessionResults,
      required final Set<TopoGroupType> selectedGroups,
      final bool isComplete}) = _$OrientationExerciseStateImpl;

  @override
  List<OrientationSign> get signs;
  @override
  int get currentIndex;
  @override
  List<ExerciseValidation?> get sessionResults;
  @override
  Set<TopoGroupType> get selectedGroups;
  @override
  bool get isComplete;

  /// Create a copy of OrientationExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrientationExerciseStateImplCopyWith<_$OrientationExerciseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
