// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExamModel _$$_ExamModelFromJson(Map<String, dynamic> json) => _$_ExamModel(
      examId: json['examId'] as String,
      subject: json['subject'] as String,
      examName: json['examName'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_ExamModelToJson(_$_ExamModel instance) =>
    <String, dynamic>{
      'examId': instance.examId,
      'subject': instance.subject,
      'examName': instance.examName,
      'date': instance.date.toIso8601String(),
    };
