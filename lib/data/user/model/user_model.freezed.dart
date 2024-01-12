// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
class _$UserModelTearOff {
  const _$UserModelTearOff();

  _UserModel call(
      {required String uid,
      required String nick,
      required String name,
      required int age,
      required String phoneNum,
      required String deviceToken,
      required bool isRegistered,
      required String type}) {
    return _UserModel(
      uid: uid,
      nick: nick,
      name: name,
      age: age,
      phoneNum: phoneNum,
      deviceToken: deviceToken,
      isRegistered: isRegistered,
      type: type,
    );
  }

  UserModel fromJson(Map<String, Object> json) {
    return UserModel.fromJson(json);
  }
}

/// @nodoc
const $UserModel = _$UserModelTearOff();

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get nick => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get phoneNum => throw _privateConstructorUsedError;
  String get deviceToken => throw _privateConstructorUsedError;
  bool get isRegistered => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String nick,
      String name,
      int age,
      String phoneNum,
      String deviceToken,
      bool isRegistered,
      String type});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? nick = freezed,
    Object? name = freezed,
    Object? age = freezed,
    Object? phoneNum = freezed,
    Object? deviceToken = freezed,
    Object? isRegistered = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nick: nick == freezed
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNum: phoneNum == freezed
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: deviceToken == freezed
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      isRegistered: isRegistered == freezed
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) then) =
      __$UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String nick,
      String name,
      int age,
      String phoneNum,
      String deviceToken,
      bool isRegistered,
      String type});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(_UserModel _value, $Res Function(_UserModel) _then)
      : super(_value, (v) => _then(v as _UserModel));

  @override
  _UserModel get _value => super._value as _UserModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? nick = freezed,
    Object? name = freezed,
    Object? age = freezed,
    Object? phoneNum = freezed,
    Object? deviceToken = freezed,
    Object? isRegistered = freezed,
    Object? type = freezed,
  }) {
    return _then(_UserModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nick: nick == freezed
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNum: phoneNum == freezed
          ? _value.phoneNum
          : phoneNum // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: deviceToken == freezed
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      isRegistered: isRegistered == freezed
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {required this.uid,
      required this.nick,
      required this.name,
      required this.age,
      required this.phoneNum,
      required this.deviceToken,
      required this.isRegistered,
      required this.type});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String uid;
  @override
  final String nick;
  @override
  final String name;
  @override
  final int age;
  @override
  final String phoneNum;
  @override
  final String deviceToken;
  @override
  final bool isRegistered;
  @override
  final String type;

  @override
  String toString() {
    return 'UserModel(uid: $uid, nick: $nick, name: $name, age: $age, phoneNum: $phoneNum, deviceToken: $deviceToken, isRegistered: $isRegistered, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserModel &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.nick, nick) ||
                const DeepCollectionEquality().equals(other.nick, nick)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)) &&
            (identical(other.phoneNum, phoneNum) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNum, phoneNum)) &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)) &&
            (identical(other.isRegistered, isRegistered) ||
                const DeepCollectionEquality()
                    .equals(other.isRegistered, isRegistered)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(nick) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age) ^
      const DeepCollectionEquality().hash(phoneNum) ^
      const DeepCollectionEquality().hash(deviceToken) ^
      const DeepCollectionEquality().hash(isRegistered) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required String uid,
      required String nick,
      required String name,
      required int age,
      required String phoneNum,
      required String deviceToken,
      required bool isRegistered,
      required String type}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get nick => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get age => throw _privateConstructorUsedError;
  @override
  String get phoneNum => throw _privateConstructorUsedError;
  @override
  String get deviceToken => throw _privateConstructorUsedError;
  @override
  bool get isRegistered => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserModelCopyWith<_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
