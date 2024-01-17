// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClassModel _$$_ClassModelFromJson(Map<String, dynamic> json) =>
    _$_ClassModel(
      classId: json['classId'] as String,
      className: json['className'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as int,
      teacherId: json['teacherId'] as String,
      parentsId:
          (json['parentsId'] as List<dynamic>).map((e) => e as String).toList(),
      studentId:
          (json['studentId'] as List<dynamic>).map((e) => e as String).toList(),
      duration: json['duration'] as int,
      homework: (json['homework'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ClassModelToJson(_$_ClassModel instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'className': instance.className,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'teacherId': instance.teacherId,
      'parentsId': instance.parentsId,
      'studentId': instance.studentId,
      'duration': instance.duration,
      'homework': instance.homework,
    };
