// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationModel _$$_NotificationModelFromJson(Map<String, dynamic> json) =>
    _$_NotificationModel(
      docId: json['docId'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      type: json['type'] as String,
      receiverToken: json['receiverToken'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_NotificationModelToJson(
        _$_NotificationModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'type': instance.type,
      'receiverToken': instance.receiverToken,
      'content': instance.content,
    };
