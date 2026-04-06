// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'morse_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MorseEntry {
  String get character => throw _privateConstructorUsedError;
  String get morseSequence => throw _privateConstructorUsedError;

  /// Create a copy of MorseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MorseEntryCopyWith<MorseEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MorseEntryCopyWith<$Res> {
  factory $MorseEntryCopyWith(
          MorseEntry value, $Res Function(MorseEntry) then) =
      _$MorseEntryCopyWithImpl<$Res, MorseEntry>;
  @useResult
  $Res call({String character, String morseSequence});
}

/// @nodoc
class _$MorseEntryCopyWithImpl<$Res, $Val extends MorseEntry>
    implements $MorseEntryCopyWith<$Res> {
  _$MorseEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MorseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? morseSequence = null,
  }) {
    return _then(_value.copyWith(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      morseSequence: null == morseSequence
          ? _value.morseSequence
          : morseSequence // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MorseEntryImplCopyWith<$Res>
    implements $MorseEntryCopyWith<$Res> {
  factory _$$MorseEntryImplCopyWith(
          _$MorseEntryImpl value, $Res Function(_$MorseEntryImpl) then) =
      __$$MorseEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String character, String morseSequence});
}

/// @nodoc
class __$$MorseEntryImplCopyWithImpl<$Res>
    extends _$MorseEntryCopyWithImpl<$Res, _$MorseEntryImpl>
    implements _$$MorseEntryImplCopyWith<$Res> {
  __$$MorseEntryImplCopyWithImpl(
      _$MorseEntryImpl _value, $Res Function(_$MorseEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MorseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? morseSequence = null,
  }) {
    return _then(_$MorseEntryImpl(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      morseSequence: null == morseSequence
          ? _value.morseSequence
          : morseSequence // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MorseEntryImpl implements _MorseEntry {
  const _$MorseEntryImpl(
      {required this.character, required this.morseSequence});

  @override
  final String character;
  @override
  final String morseSequence;

  @override
  String toString() {
    return 'MorseEntry(character: $character, morseSequence: $morseSequence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MorseEntryImpl &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.morseSequence, morseSequence) ||
                other.morseSequence == morseSequence));
  }

  @override
  int get hashCode => Object.hash(runtimeType, character, morseSequence);

  /// Create a copy of MorseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MorseEntryImplCopyWith<_$MorseEntryImpl> get copyWith =>
      __$$MorseEntryImplCopyWithImpl<_$MorseEntryImpl>(this, _$identity);
}

abstract class _MorseEntry implements MorseEntry {
  const factory _MorseEntry(
      {required final String character,
      required final String morseSequence}) = _$MorseEntryImpl;

  @override
  String get character;
  @override
  String get morseSequence;

  /// Create a copy of MorseEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MorseEntryImplCopyWith<_$MorseEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
