// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bank _$BankFromJson(Map<String, dynamic> json) {
  return _Bank.fromJson(json);
}

/// @nodoc
class _$BankTearOff {
  const _$BankTearOff();

  _Bank call(
      {required int id,
      required String title,
      required String tel,
      required String zipcode,
      required String address,
      required double lat,
      required double lng,
      required String imagePath,
      @JsonKey(name: 'organ_name') required String organName,
      @JsonKey(name: 'organ_volumn') required int organVolumn}) {
    return _Bank(
      id: id,
      title: title,
      tel: tel,
      zipcode: zipcode,
      address: address,
      lat: lat,
      lng: lng,
      imagePath: imagePath,
      organName: organName,
      organVolumn: organVolumn,
    );
  }

  Bank fromJson(Map<String, Object?> json) {
    return Bank.fromJson(json);
  }
}

/// @nodoc
const $Bank = _$BankTearOff();

/// @nodoc
mixin _$Bank {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get tel => throw _privateConstructorUsedError;
  String get zipcode => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'organ_name')
  String get organName => throw _privateConstructorUsedError;
  @JsonKey(name: 'organ_volumn')
  int get organVolumn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankCopyWith<Bank> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankCopyWith<$Res> {
  factory $BankCopyWith(Bank value, $Res Function(Bank) then) =
      _$BankCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String tel,
      String zipcode,
      String address,
      double lat,
      double lng,
      String imagePath,
      @JsonKey(name: 'organ_name') String organName,
      @JsonKey(name: 'organ_volumn') int organVolumn});
}

/// @nodoc
class _$BankCopyWithImpl<$Res> implements $BankCopyWith<$Res> {
  _$BankCopyWithImpl(this._value, this._then);

  final Bank _value;
  // ignore: unused_field
  final $Res Function(Bank) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? tel = freezed,
    Object? zipcode = freezed,
    Object? address = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? imagePath = freezed,
    Object? organName = freezed,
    Object? organVolumn = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tel: tel == freezed
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: zipcode == freezed
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      organName: organName == freezed
          ? _value.organName
          : organName // ignore: cast_nullable_to_non_nullable
              as String,
      organVolumn: organVolumn == freezed
          ? _value.organVolumn
          : organVolumn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$BankCopyWith<$Res> implements $BankCopyWith<$Res> {
  factory _$BankCopyWith(_Bank value, $Res Function(_Bank) then) =
      __$BankCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String tel,
      String zipcode,
      String address,
      double lat,
      double lng,
      String imagePath,
      @JsonKey(name: 'organ_name') String organName,
      @JsonKey(name: 'organ_volumn') int organVolumn});
}

/// @nodoc
class __$BankCopyWithImpl<$Res> extends _$BankCopyWithImpl<$Res>
    implements _$BankCopyWith<$Res> {
  __$BankCopyWithImpl(_Bank _value, $Res Function(_Bank) _then)
      : super(_value, (v) => _then(v as _Bank));

  @override
  _Bank get _value => super._value as _Bank;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? tel = freezed,
    Object? zipcode = freezed,
    Object? address = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? imagePath = freezed,
    Object? organName = freezed,
    Object? organVolumn = freezed,
  }) {
    return _then(_Bank(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tel: tel == freezed
          ? _value.tel
          : tel // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: zipcode == freezed
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      organName: organName == freezed
          ? _value.organName
          : organName // ignore: cast_nullable_to_non_nullable
              as String,
      organVolumn: organVolumn == freezed
          ? _value.organVolumn
          : organVolumn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bank implements _Bank {
  _$_Bank(
      {required this.id,
      required this.title,
      required this.tel,
      required this.zipcode,
      required this.address,
      required this.lat,
      required this.lng,
      required this.imagePath,
      @JsonKey(name: 'organ_name') required this.organName,
      @JsonKey(name: 'organ_volumn') required this.organVolumn});

  factory _$_Bank.fromJson(Map<String, dynamic> json) => _$$_BankFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String tel;
  @override
  final String zipcode;
  @override
  final String address;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String imagePath;
  @override
  @JsonKey(name: 'organ_name')
  final String organName;
  @override
  @JsonKey(name: 'organ_volumn')
  final int organVolumn;

  @override
  String toString() {
    return 'Bank(id: $id, title: $title, tel: $tel, zipcode: $zipcode, address: $address, lat: $lat, lng: $lng, imagePath: $imagePath, organName: $organName, organVolumn: $organVolumn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Bank &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.tel, tel) &&
            const DeepCollectionEquality().equals(other.zipcode, zipcode) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lng, lng) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality().equals(other.organName, organName) &&
            const DeepCollectionEquality()
                .equals(other.organVolumn, organVolumn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(tel),
      const DeepCollectionEquality().hash(zipcode),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(lng),
      const DeepCollectionEquality().hash(imagePath),
      const DeepCollectionEquality().hash(organName),
      const DeepCollectionEquality().hash(organVolumn));

  @JsonKey(ignore: true)
  @override
  _$BankCopyWith<_Bank> get copyWith =>
      __$BankCopyWithImpl<_Bank>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BankToJson(this);
  }
}

abstract class _Bank implements Bank {
  factory _Bank(
      {required int id,
      required String title,
      required String tel,
      required String zipcode,
      required String address,
      required double lat,
      required double lng,
      required String imagePath,
      @JsonKey(name: 'organ_name') required String organName,
      @JsonKey(name: 'organ_volumn') required int organVolumn}) = _$_Bank;

  factory _Bank.fromJson(Map<String, dynamic> json) = _$_Bank.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get tel;
  @override
  String get zipcode;
  @override
  String get address;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String get imagePath;
  @override
  @JsonKey(name: 'organ_name')
  String get organName;
  @override
  @JsonKey(name: 'organ_volumn')
  int get organVolumn;
  @override
  @JsonKey(ignore: true)
  _$BankCopyWith<_Bank> get copyWith => throw _privateConstructorUsedError;
}
