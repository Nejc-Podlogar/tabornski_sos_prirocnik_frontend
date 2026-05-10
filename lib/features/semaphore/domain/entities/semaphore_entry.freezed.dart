// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semaphore_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SemaphoreEntry {
  String get character => throw _privateConstructorUsedError;
  String get flagImagePath => throw _privateConstructorUsedError;

  /// Create a copy of SemaphoreEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemaphoreEntryCopyWith<SemaphoreEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemaphoreEntryCopyWith<$Res> {
  factory $SemaphoreEntryCopyWith(
          SemaphoreEntry value, $Res Function(SemaphoreEntry) then) =
      _$SemaphoreEntryCopyWithImpl<$Res, SemaphoreEntry>;
  @useResult
  $Res call({String character, String flagImagePath});
}

/// @nodoc
class _$SemaphoreEntryCopyWithImpl<$Res, $Val extends SemaphoreEntry>
    implements $SemaphoreEntryCopyWith<$Res> {
  _$SemaphoreEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemaphoreEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? flagImagePath = null,
  }) {
    return _then(_value.copyWith(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      flagImagePath: null == flagImagePath
          ? _value.flagImagePath
          : flagImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemaphoreEntryImplCopyWith<$Res>
    implements $SemaphoreEntryCopyWith<$Res> {
  factory _$$SemaphoreEntryImplCopyWith(_$SemaphoreEntryImpl value,
          $Res Function(_$SemaphoreEntryImpl) then) =
      __$$SemaphoreEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String character, String flagImagePath});
}

/// @nodoc
class __$$SemaphoreEntryImplCopyWithImpl<$Res>
    extends _$SemaphoreEntryCopyWithImpl<$Res, _$SemaphoreEntryImpl>
    implements _$$SemaphoreEntryImplCopyWith<$Res> {
  __$$SemaphoreEntryImplCopyWithImpl(
      _$SemaphoreEntryImpl _value, $Res Function(_$SemaphoreEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemaphoreEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? flagImagePath = null,
  }) {
    return _then(_$SemaphoreEntryImpl(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
      flagImagePath: null == flagImagePath
          ? _value.flagImagePath
          : flagImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SemaphoreEntryImpl implements _SemaphoreEntry {
  const _$SemaphoreEntryImpl(
      {required this.character, required this.flagImagePath});

  @override
  final String character;
  @override
  final String flagImagePath;

  @override
  String toString() {
    return 'SemaphoreEntry(character: $character, flagImagePath: $flagImagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemaphoreEntryImpl &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.flagImagePath, flagImagePath) ||
                other.flagImagePath == flagImagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, character, flagImagePath);

  /// Create a copy of SemaphoreEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemaphoreEntryImplCopyWith<_$SemaphoreEntryImpl> get copyWith =>
      __$$SemaphoreEntryImplCopyWithImpl<_$SemaphoreEntryImpl>(
          this, _$identity);
}

abstract class _SemaphoreEntry implements SemaphoreEntry {
  const factory _SemaphoreEntry(
      {required final String character,
      required final String flagImagePath}) = _$SemaphoreEntryImpl;

  @override
  String get character;
  @override
  String get flagImagePath;

  /// Create a copy of SemaphoreEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemaphoreEntryImplCopyWith<_$SemaphoreEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
