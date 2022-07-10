// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'opinion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Opinion _$OpinionFromJson(Map<String, dynamic> json) {
  return _Opinion.fromJson(json);
}

/// @nodoc
class _$OpinionTearOff {
  const _$OpinionTearOff();

  _Opinion call(
      {required String id,
      required String opinion,
      required DateTime createTime}) {
    return _Opinion(
      id: id,
      opinion: opinion,
      createTime: createTime,
    );
  }

  Opinion fromJson(Map<String, Object?> json) {
    return Opinion.fromJson(json);
  }
}

/// @nodoc
const $Opinion = _$OpinionTearOff();

/// @nodoc
mixin _$Opinion {
  String get id => throw _privateConstructorUsedError;
  String get opinion => throw _privateConstructorUsedError;
  DateTime get createTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OpinionCopyWith<Opinion> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpinionCopyWith<$Res> {
  factory $OpinionCopyWith(Opinion value, $Res Function(Opinion) then) =
      _$OpinionCopyWithImpl<$Res>;
  $Res call({String id, String opinion, DateTime createTime});
}

/// @nodoc
class _$OpinionCopyWithImpl<$Res> implements $OpinionCopyWith<$Res> {
  _$OpinionCopyWithImpl(this._value, this._then);

  final Opinion _value;
  // ignore: unused_field
  final $Res Function(Opinion) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? opinion = freezed,
    Object? createTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      opinion: opinion == freezed
          ? _value.opinion
          : opinion // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: createTime == freezed
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$OpinionCopyWith<$Res> implements $OpinionCopyWith<$Res> {
  factory _$OpinionCopyWith(_Opinion value, $Res Function(_Opinion) then) =
      __$OpinionCopyWithImpl<$Res>;
  @override
  $Res call({String id, String opinion, DateTime createTime});
}

/// @nodoc
class __$OpinionCopyWithImpl<$Res> extends _$OpinionCopyWithImpl<$Res>
    implements _$OpinionCopyWith<$Res> {
  __$OpinionCopyWithImpl(_Opinion _value, $Res Function(_Opinion) _then)
      : super(_value, (v) => _then(v as _Opinion));

  @override
  _Opinion get _value => super._value as _Opinion;

  @override
  $Res call({
    Object? id = freezed,
    Object? opinion = freezed,
    Object? createTime = freezed,
  }) {
    return _then(_Opinion(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      opinion: opinion == freezed
          ? _value.opinion
          : opinion // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: createTime == freezed
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Opinion implements _Opinion {
  _$_Opinion(
      {required this.id, required this.opinion, required this.createTime});

  factory _$_Opinion.fromJson(Map<String, dynamic> json) =>
      _$$_OpinionFromJson(json);

  @override
  final String id;
  @override
  final String opinion;
  @override
  final DateTime createTime;

  @override
  String toString() {
    return 'Opinion(id: $id, opinion: $opinion, createTime: $createTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Opinion &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.opinion, opinion) &&
            const DeepCollectionEquality()
                .equals(other.createTime, createTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(opinion),
      const DeepCollectionEquality().hash(createTime));

  @JsonKey(ignore: true)
  @override
  _$OpinionCopyWith<_Opinion> get copyWith =>
      __$OpinionCopyWithImpl<_Opinion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OpinionToJson(this);
  }
}

abstract class _Opinion implements Opinion {
  factory _Opinion(
      {required String id,
      required String opinion,
      required DateTime createTime}) = _$_Opinion;

  factory _Opinion.fromJson(Map<String, dynamic> json) = _$_Opinion.fromJson;

  @override
  String get id;
  @override
  String get opinion;
  @override
  DateTime get createTime;
  @override
  @JsonKey(ignore: true)
  _$OpinionCopyWith<_Opinion> get copyWith =>
      throw _privateConstructorUsedError;
}
