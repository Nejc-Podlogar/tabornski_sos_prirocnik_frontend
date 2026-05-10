// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semaphore_translation_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemaphoreTranslationState {
  String get inputText => throw _privateConstructorUsedError;
  List<SemaphoreEntry> get entries => throw _privateConstructorUsedError;
  TranslationDirection get direction => throw _privateConstructorUsedError;

  /// Create a copy of SemaphoreTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemaphoreTranslationStateCopyWith<SemaphoreTranslationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemaphoreTranslationStateCopyWith<$Res> {
  factory $SemaphoreTranslationStateCopyWith(SemaphoreTranslationState value,
          $Res Function(SemaphoreTranslationState) then) =
      _$SemaphoreTranslationStateCopyWithImpl<$Res, SemaphoreTranslationState>;
  @useResult
  $Res call(
      {String inputText,
      List<SemaphoreEntry> entries,
      TranslationDirection direction});
}

/// @nodoc
class _$SemaphoreTranslationStateCopyWithImpl<$Res,
        $Val extends SemaphoreTranslationState>
    implements $SemaphoreTranslationStateCopyWith<$Res> {
  _$SemaphoreTranslationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemaphoreTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputText = null,
    Object? entries = null,
    Object? direction = null,
  }) {
    return _then(_value.copyWith(
      inputText: null == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<SemaphoreEntry>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemaphoreTranslationStateImplCopyWith<$Res>
    implements $SemaphoreTranslationStateCopyWith<$Res> {
  factory _$$SemaphoreTranslationStateImplCopyWith(
          _$SemaphoreTranslationStateImpl value,
          $Res Function(_$SemaphoreTranslationStateImpl) then) =
      __$$SemaphoreTranslationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputText,
      List<SemaphoreEntry> entries,
      TranslationDirection direction});
}

/// @nodoc
class __$$SemaphoreTranslationStateImplCopyWithImpl<$Res>
    extends _$SemaphoreTranslationStateCopyWithImpl<$Res,
        _$SemaphoreTranslationStateImpl>
    implements _$$SemaphoreTranslationStateImplCopyWith<$Res> {
  __$$SemaphoreTranslationStateImplCopyWithImpl(
      _$SemaphoreTranslationStateImpl _value,
      $Res Function(_$SemaphoreTranslationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemaphoreTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputText = null,
    Object? entries = null,
    Object? direction = null,
  }) {
    return _then(_$SemaphoreTranslationStateImpl(
      inputText: null == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<SemaphoreEntry>,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
    ));
  }
}

/// @nodoc

class _$SemaphoreTranslationStateImpl implements _SemaphoreTranslationState {
  const _$SemaphoreTranslationStateImpl(
      {this.inputText = '',
      final List<SemaphoreEntry> entries = const <SemaphoreEntry>[],
      this.direction = TranslationDirection.textToMorse})
      : _entries = entries;

  @override
  @JsonKey()
  final String inputText;
  final List<SemaphoreEntry> _entries;
  @override
  @JsonKey()
  List<SemaphoreEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey()
  final TranslationDirection direction;

  @override
  String toString() {
    return 'SemaphoreTranslationState(inputText: $inputText, entries: $entries, direction: $direction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemaphoreTranslationStateImpl &&
            (identical(other.inputText, inputText) ||
                other.inputText == inputText) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputText,
      const DeepCollectionEquality().hash(_entries), direction);

  /// Create a copy of SemaphoreTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemaphoreTranslationStateImplCopyWith<_$SemaphoreTranslationStateImpl>
      get copyWith => __$$SemaphoreTranslationStateImplCopyWithImpl<
          _$SemaphoreTranslationStateImpl>(this, _$identity);
}

abstract class _SemaphoreTranslationState implements SemaphoreTranslationState {
  const factory _SemaphoreTranslationState(
      {final String inputText,
      final List<SemaphoreEntry> entries,
      final TranslationDirection direction}) = _$SemaphoreTranslationStateImpl;

  @override
  String get inputText;
  @override
  List<SemaphoreEntry> get entries;
  @override
  TranslationDirection get direction;

  /// Create a copy of SemaphoreTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemaphoreTranslationStateImplCopyWith<_$SemaphoreTranslationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
