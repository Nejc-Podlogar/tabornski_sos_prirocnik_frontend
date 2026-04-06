// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'morse_translation_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MorseTranslationState {
  String get inputText => throw _privateConstructorUsedError;
  String get outputText => throw _privateConstructorUsedError;
  TranslationDirection get direction => throw _privateConstructorUsedError;
  bool get isTransmitting => throw _privateConstructorUsedError;
  bool get isLooping => throw _privateConstructorUsedError;

  /// Create a copy of MorseTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MorseTranslationStateCopyWith<MorseTranslationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MorseTranslationStateCopyWith<$Res> {
  factory $MorseTranslationStateCopyWith(MorseTranslationState value,
          $Res Function(MorseTranslationState) then) =
      _$MorseTranslationStateCopyWithImpl<$Res, MorseTranslationState>;
  @useResult
  $Res call(
      {String inputText,
      String outputText,
      TranslationDirection direction,
      bool isTransmitting,
      bool isLooping});
}

/// @nodoc
class _$MorseTranslationStateCopyWithImpl<$Res,
        $Val extends MorseTranslationState>
    implements $MorseTranslationStateCopyWith<$Res> {
  _$MorseTranslationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MorseTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputText = null,
    Object? outputText = null,
    Object? direction = null,
    Object? isTransmitting = null,
    Object? isLooping = null,
  }) {
    return _then(_value.copyWith(
      inputText: null == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String,
      outputText: null == outputText
          ? _value.outputText
          : outputText // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
      isTransmitting: null == isTransmitting
          ? _value.isTransmitting
          : isTransmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MorseTranslationStateImplCopyWith<$Res>
    implements $MorseTranslationStateCopyWith<$Res> {
  factory _$$MorseTranslationStateImplCopyWith(
          _$MorseTranslationStateImpl value,
          $Res Function(_$MorseTranslationStateImpl) then) =
      __$$MorseTranslationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputText,
      String outputText,
      TranslationDirection direction,
      bool isTransmitting,
      bool isLooping});
}

/// @nodoc
class __$$MorseTranslationStateImplCopyWithImpl<$Res>
    extends _$MorseTranslationStateCopyWithImpl<$Res,
        _$MorseTranslationStateImpl>
    implements _$$MorseTranslationStateImplCopyWith<$Res> {
  __$$MorseTranslationStateImplCopyWithImpl(_$MorseTranslationStateImpl _value,
      $Res Function(_$MorseTranslationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorseTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputText = null,
    Object? outputText = null,
    Object? direction = null,
    Object? isTransmitting = null,
    Object? isLooping = null,
  }) {
    return _then(_$MorseTranslationStateImpl(
      inputText: null == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String,
      outputText: null == outputText
          ? _value.outputText
          : outputText // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TranslationDirection,
      isTransmitting: null == isTransmitting
          ? _value.isTransmitting
          : isTransmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isLooping: null == isLooping
          ? _value.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MorseTranslationStateImpl implements _MorseTranslationState {
  const _$MorseTranslationStateImpl(
      {this.inputText = '',
      this.outputText = '',
      this.direction = TranslationDirection.textToMorse,
      this.isTransmitting = false,
      this.isLooping = false});

  @override
  @JsonKey()
  final String inputText;
  @override
  @JsonKey()
  final String outputText;
  @override
  @JsonKey()
  final TranslationDirection direction;
  @override
  @JsonKey()
  final bool isTransmitting;
  @override
  @JsonKey()
  final bool isLooping;

  @override
  String toString() {
    return 'MorseTranslationState(inputText: $inputText, outputText: $outputText, direction: $direction, isTransmitting: $isTransmitting, isLooping: $isLooping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MorseTranslationStateImpl &&
            (identical(other.inputText, inputText) ||
                other.inputText == inputText) &&
            (identical(other.outputText, outputText) ||
                other.outputText == outputText) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.isTransmitting, isTransmitting) ||
                other.isTransmitting == isTransmitting) &&
            (identical(other.isLooping, isLooping) ||
                other.isLooping == isLooping));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, inputText, outputText, direction, isTransmitting, isLooping);

  /// Create a copy of MorseTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MorseTranslationStateImplCopyWith<_$MorseTranslationStateImpl>
      get copyWith => __$$MorseTranslationStateImplCopyWithImpl<
          _$MorseTranslationStateImpl>(this, _$identity);
}

abstract class _MorseTranslationState implements MorseTranslationState {
  const factory _MorseTranslationState(
      {final String inputText,
      final String outputText,
      final TranslationDirection direction,
      final bool isTransmitting,
      final bool isLooping}) = _$MorseTranslationStateImpl;

  @override
  String get inputText;
  @override
  String get outputText;
  @override
  TranslationDirection get direction;
  @override
  bool get isTransmitting;
  @override
  bool get isLooping;

  /// Create a copy of MorseTranslationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MorseTranslationStateImplCopyWith<_$MorseTranslationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
