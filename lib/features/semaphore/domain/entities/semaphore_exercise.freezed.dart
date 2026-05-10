// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semaphore_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemaphoreExercise {
  List<String> get exerciseValues => throw _privateConstructorUsedError;
  List<String> get translatedValues => throw _privateConstructorUsedError;
  List<bool?> get areCorrect => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  TranslationDirection get direction => throw _privateConstructorUsedError;
  InteractionType get interactionType => throw _privateConstructorUsedError;

  /// Create a copy of SemaphoreExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemaphoreExerciseCopyWith<SemaphoreExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemaphoreExerciseCopyWith<$Res> {
  factory $SemaphoreExerciseCopyWith(
          SemaphoreExercise value, $Res Function(SemaphoreExercise) then) =
      _$SemaphoreExerciseCopyWithImpl<$Res, SemaphoreExercise>;
  @useResult
  $Res call(
      {List<String> exerciseValues,
      List<String> translatedValues,
      List<bool?> areCorrect,
      int currentIndex,
      TranslationDirection direction,
      InteractionType interactionType});
}

/// @nodoc
class _$SemaphoreExerciseCopyWithImpl<$Res, $Val extends SemaphoreExercise>
    implements $SemaphoreExerciseCopyWith<$Res> {
  _$SemaphoreExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemaphoreExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseValues = null,
    Object? translatedValues = null,
    Object? areCorrect = null,
    Object? currentIndex = null,
    Object? direction = null,
    Object? interactionType = null,
  }) {
    return _then(_value.copyWith(
      exerciseValues: null == exerciseValues
          ? _value.exerciseValues
          : exerciseValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translatedValues: null == translatedValues
          ? _value.translatedValues
          : translatedValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      areCorrect: null == areCorrect
          ? _value.areCorrect
          : areCorrect // ignore: cast_nullable_to_non_nullable
              as List<bool?>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
      interactionType: null == interactionType
          ? _value.interactionType
          : interactionType // ignore: cast_nullable_to_non_nullable
              as InteractionType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemaphoreExerciseImplCopyWith<$Res>
    implements $SemaphoreExerciseCopyWith<$Res> {
  factory _$$SemaphoreExerciseImplCopyWith(_$SemaphoreExerciseImpl value,
          $Res Function(_$SemaphoreExerciseImpl) then) =
      __$$SemaphoreExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> exerciseValues,
      List<String> translatedValues,
      List<bool?> areCorrect,
      int currentIndex,
      TranslationDirection direction,
      InteractionType interactionType});
}

/// @nodoc
class __$$SemaphoreExerciseImplCopyWithImpl<$Res>
    extends _$SemaphoreExerciseCopyWithImpl<$Res, _$SemaphoreExerciseImpl>
    implements _$$SemaphoreExerciseImplCopyWith<$Res> {
  __$$SemaphoreExerciseImplCopyWithImpl(_$SemaphoreExerciseImpl _value,
      $Res Function(_$SemaphoreExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemaphoreExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseValues = null,
    Object? translatedValues = null,
    Object? areCorrect = null,
    Object? currentIndex = null,
    Object? direction = null,
    Object? interactionType = null,
  }) {
    return _then(_$SemaphoreExerciseImpl(
      exerciseValues: null == exerciseValues
          ? _value._exerciseValues
          : exerciseValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translatedValues: null == translatedValues
          ? _value._translatedValues
          : translatedValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      areCorrect: null == areCorrect
          ? _value._areCorrect
          : areCorrect // ignore: cast_nullable_to_non_nullable
              as List<bool?>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
      interactionType: null == interactionType
          ? _value.interactionType
          : interactionType // ignore: cast_nullable_to_non_nullable
              as InteractionType,
    ));
  }
}

/// @nodoc

class _$SemaphoreExerciseImpl implements _SemaphoreExercise {
  const _$SemaphoreExerciseImpl(
      {required final List<String> exerciseValues,
      required final List<String> translatedValues,
      required final List<bool?> areCorrect,
      required this.currentIndex,
      required this.direction,
      required this.interactionType})
      : _exerciseValues = exerciseValues,
        _translatedValues = translatedValues,
        _areCorrect = areCorrect;

  final List<String> _exerciseValues;
  @override
  List<String> get exerciseValues {
    if (_exerciseValues is EqualUnmodifiableListView) return _exerciseValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseValues);
  }

  final List<String> _translatedValues;
  @override
  List<String> get translatedValues {
    if (_translatedValues is EqualUnmodifiableListView)
      return _translatedValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translatedValues);
  }

  final List<bool?> _areCorrect;
  @override
  List<bool?> get areCorrect {
    if (_areCorrect is EqualUnmodifiableListView) return _areCorrect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areCorrect);
  }

  @override
  final int currentIndex;
  @override
  final TranslationDirection direction;
  @override
  final InteractionType interactionType;

  @override
  String toString() {
    return 'SemaphoreExercise(exerciseValues: $exerciseValues, translatedValues: $translatedValues, areCorrect: $areCorrect, currentIndex: $currentIndex, direction: $direction, interactionType: $interactionType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemaphoreExerciseImpl &&
            const DeepCollectionEquality()
                .equals(other._exerciseValues, _exerciseValues) &&
            const DeepCollectionEquality()
                .equals(other._translatedValues, _translatedValues) &&
            const DeepCollectionEquality()
                .equals(other._areCorrect, _areCorrect) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.interactionType, interactionType) ||
                other.interactionType == interactionType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_exerciseValues),
      const DeepCollectionEquality().hash(_translatedValues),
      const DeepCollectionEquality().hash(_areCorrect),
      currentIndex,
      direction,
      interactionType);

  /// Create a copy of SemaphoreExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemaphoreExerciseImplCopyWith<_$SemaphoreExerciseImpl> get copyWith =>
      __$$SemaphoreExerciseImplCopyWithImpl<_$SemaphoreExerciseImpl>(
          this, _$identity);
}

abstract class _SemaphoreExercise implements SemaphoreExercise {
  const factory _SemaphoreExercise(
          {required final List<String> exerciseValues,
          required final List<String> translatedValues,
          required final List<bool?> areCorrect,
          required final int currentIndex,
          required final TranslationDirection direction,
          required final InteractionType interactionType}) =
      _$SemaphoreExerciseImpl;

  @override
  List<String> get exerciseValues;
  @override
  List<String> get translatedValues;
  @override
  List<bool?> get areCorrect;
  @override
  int get currentIndex;
  @override
  TranslationDirection get direction;
  @override
  InteractionType get interactionType;

  /// Create a copy of SemaphoreExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemaphoreExerciseImplCopyWith<_$SemaphoreExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
