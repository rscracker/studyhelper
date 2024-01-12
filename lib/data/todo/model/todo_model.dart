import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  factory TodoModel({
    required String todoId,
    required String subject,
    required String todo,
    required bool isDone,
    required DateTime createdAt,
    required int predictingTime,
    required int leadTime,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
