// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      nick: json['nick'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      phoneNum: json['phoneNum'] as String,
      deviceToken: json['deviceToken'] as String,
      isRegistered: json['isRegistered'] as bool,
      type: json['type'] as String,
      friends:
          (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nick': instance.nick,
      'name': instance.name,
      'age': instance.age,
      'phoneNum': instance.phoneNum,
      'deviceToken': instance.deviceToken,
      'isRegistered': instance.isRegistered,
      'type': instance.type,
      'friends': instance.friends,
    };
