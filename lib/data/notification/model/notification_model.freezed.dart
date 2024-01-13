// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
class _$NotificationModelTearOff {
  const _$NotificationModelTearOff();

  _NotificationModel call(
      {required String docId,
      required String receiver,
      required String sender,
      required String type,
      required String receiverToken,
      required String content}) {
    return _NotificationModel(
      docId: docId,
      receiver: receiver,
      sender: sender,
      type: type,
      receiverToken: receiverToken,
      content: content,
    );
  }

  NotificationModel fromJson(Map<String, Object> json) {
    return NotificationModel.fromJson(json);
  }
}

/// @nodoc
const $NotificationModel = _$NotificationModelTearOff();

/// @nodoc
mixin _$NotificationModel {
  String get docId => throw _privateConstructorUsedError;
  String get receiver => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get receiverToken => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res>;
  $Res call(
      {String docId,
      String receiver,
      String sender,
      String type,
      String receiverToken,
      String content});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  final NotificationModel _value;
  // ignore: unused_field
  final $Res Function(NotificationModel) _then;

  @override
  $Res call({
    Object? docId = freezed,
    Object? receiver = freezed,
    Object? sender = freezed,
    Object? type = freezed,
    Object? receiverToken = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      docId: docId == freezed
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      receiver: receiver == freezed
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      receiverToken: receiverToken == freezed
          ? _value.receiverToken
          : receiverToken // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$NotificationModelCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(
          _NotificationModel value, $Res Function(_NotificationModel) then) =
      __$NotificationModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String docId,
      String receiver,
      String sender,
      String type,
      String receiverToken,
      String content});
}

/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(
      _NotificationModel _value, $Res Function(_NotificationModel) _then)
      : super(_value, (v) => _then(v as _NotificationModel));

  @override
  _NotificationModel get _value => super._value as _NotificationModel;

  @override
  $Res call({
    Object? docId = freezed,
    Object? receiver = freezed,
    Object? sender = freezed,
    Object? type = freezed,
    Object? receiverToken = freezed,
    Object? content = freezed,
  }) {
    return _then(_NotificationModel(
      docId: docId == freezed
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      receiver: receiver == freezed
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      receiverToken: receiverToken == freezed
          ? _value.receiverToken
          : receiverToken // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationModel implements _NotificationModel {
  _$_NotificationModel(
      {required this.docId,
      required this.receiver,
      required this.sender,
      required this.type,
      required this.receiverToken,
      required this.content});

  factory _$_NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationModelFromJson(json);

  @override
  final String docId;
  @override
  final String receiver;
  @override
  final String sender;
  @override
  final String type;
  @override
  final String receiverToken;
  @override
  final String content;

  @override
  String toString() {
    return 'NotificationModel(docId: $docId, receiver: $receiver, sender: $sender, type: $type, receiverToken: $receiverToken, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationModel &&
            (identical(other.docId, docId) ||
                const DeepCollectionEquality().equals(other.docId, docId)) &&
            (identical(other.receiver, receiver) ||
                const DeepCollectionEquality()
                    .equals(other.receiver, receiver)) &&
            (identical(other.sender, sender) ||
                const DeepCollectionEquality().equals(other.sender, sender)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.receiverToken, receiverToken) ||
                const DeepCollectionEquality()
                    .equals(other.receiverToken, receiverToken)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(docId) ^
      const DeepCollectionEquality().hash(receiver) ^
      const DeepCollectionEquality().hash(sender) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(receiverToken) ^
      const DeepCollectionEquality().hash(content);

  @JsonKey(ignore: true)
  @override
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationModelToJson(this);
  }
}

abstract class _NotificationModel implements NotificationModel {
  factory _NotificationModel(
      {required String docId,
      required String receiver,
      required String sender,
      required String type,
      required String receiverToken,
      required String content}) = _$_NotificationModel;

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationModel.fromJson;

  @override
  String get docId => throw _privateConstructorUsedError;
  @override
  String get receiver => throw _privateConstructorUsedError;
  @override
  String get sender => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get receiverToken => throw _privateConstructorUsedError;
  @override
  String get content => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
