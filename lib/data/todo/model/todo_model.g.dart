// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoModel _$$_TodoModelFromJson(Map<String, dynamic> json) => _$_TodoModel(
      todoId: json['todoId'] as String,
      subject: json['subject'] as String,
      todo: json['todo'] as String,
      isDone: json['isDone'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      predictingTime: json['predictingTime'] as int,
      leadTime: json['leadTime'] as int,
    );

Map<String, dynamic> _$$_TodoModelToJson(_$_TodoModel instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'subject': instance.subject,
      'todo': instance.todo,
      'isDone': instance.isDone,
      'createdAt': instance.createdAt.toIso8601String(),
      'predictingTime': instance.predictingTime,
      'leadTime': instance.leadTime,
    };
