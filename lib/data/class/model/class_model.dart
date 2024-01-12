import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

@freezed
class ClassModel with _$ClassModel {
  factory ClassModel({
    required String classId,
    required String className,
    required String subject,
    required DateTime date,
    required int time,
    required String teacherId,
    required List<String> parentsId,
    required List<String> studentId,
    required int duration,
  }) = _ClassModel;

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
}
