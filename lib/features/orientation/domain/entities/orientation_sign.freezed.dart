// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orientation_sign.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrientationSign {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageLoc => throw _privateConstructorUsedError;
  TopoGroupType get topoGroupType => throw _privateConstructorUsedError;

  /// Create a copy of OrientationSign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrientationSignCopyWith<OrientationSign> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrientationSignCopyWith<$Res> {
  factory $OrientationSignCopyWith(
          OrientationSign value, $Res Function(OrientationSign) then) =
      _$OrientationSignCopyWithImpl<$Res, OrientationSign>;
  @useResult
  $Res call(
      {int id, String name, String imageLoc, TopoGroupType topoGroupType});
}

/// @nodoc
class _$OrientationSignCopyWithImpl<$Res, $Val extends OrientationSign>
    implements $OrientationSignCopyWith<$Res> {
  _$OrientationSignCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrientationSign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageLoc = null,
    Object? topoGroupType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageLoc: null == imageLoc
          ? _value.imageLoc
          : imageLoc // ignore: cast_nullable_to_non_nullable
              as String,
      topoGroupType: null == topoGroupType
          ? _value.topoGroupType
          : topoGroupType // ignore: cast_nullable_to_non_nullable
              as TopoGroupType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrientationSignImplCopyWith<$Res>
    implements $OrientationSignCopyWith<$Res> {
  factory _$$OrientationSignImplCopyWith(_$OrientationSignImpl value,
          $Res Function(_$OrientationSignImpl) then) =
      __$$OrientationSignImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String name, String imageLoc, TopoGroupType topoGroupType});
}

/// @nodoc
class __$$OrientationSignImplCopyWithImpl<$Res>
    extends _$OrientationSignCopyWithImpl<$Res, _$OrientationSignImpl>
    implements _$$OrientationSignImplCopyWith<$Res> {
  __$$OrientationSignImplCopyWithImpl(
      _$OrientationSignImpl _value, $Res Function(_$OrientationSignImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrientationSign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageLoc = null,
    Object? topoGroupType = null,
  }) {
    return _then(_$OrientationSignImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageLoc: null == imageLoc
          ? _value.imageLoc
          : imageLoc // ignore: cast_nullable_to_non_nullable
              as String,
      topoGroupType: null == topoGroupType
          ? _value.topoGroupType
          : topoGroupType // ignore: cast_nullable_to_non_nullable
              as TopoGroupType,
    ));
  }
}

/// @nodoc

class _$OrientationSignImpl implements _OrientationSign {
  const _$OrientationSignImpl(
      {required this.id,
      required this.name,
      required this.imageLoc,
      required this.topoGroupType});

  @override
  final int id;
  @override
  final String name;
  @override
  final String imageLoc;
  @override
  final TopoGroupType topoGroupType;

  @override
  String toString() {
    return 'OrientationSign(id: $id, name: $name, imageLoc: $imageLoc, topoGroupType: $topoGroupType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrientationSignImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageLoc, imageLoc) ||
                other.imageLoc == imageLoc) &&
            (identical(other.topoGroupType, topoGroupType) ||
                other.topoGroupType == topoGroupType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, imageLoc, topoGroupType);

  /// Create a copy of OrientationSign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrientationSignImplCopyWith<_$OrientationSignImpl> get copyWith =>
      __$$OrientationSignImplCopyWithImpl<_$OrientationSignImpl>(
          this, _$identity);
}

abstract class _OrientationSign implements OrientationSign {
  const factory _OrientationSign(
      {required final int id,
      required final String name,
      required final String imageLoc,
      required final TopoGroupType topoGroupType}) = _$OrientationSignImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get imageLoc;
  @override
  TopoGroupType get topoGroupType;

  /// Create a copy of OrientationSign
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrientationSignImplCopyWith<_$OrientationSignImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
