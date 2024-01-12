// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) {
  return _TodoModel.fromJson(json);
}

/// @nodoc
class _$TodoModelTearOff {
  const _$TodoModelTearOff();

  _TodoModel call(
      {required String todoId,
      required String subject,
      required String todo,
      required bool isDone,
      required DateTime createdAt,
      required int predictingTime,
      required int leadTime}) {
    return _TodoModel(
      todoId: todoId,
      subject: subject,
      todo: todo,
      isDone: isDone,
      createdAt: createdAt,
      predictingTime: predictingTime,
      leadTime: leadTime,
    );
  }

  TodoModel fromJson(Map<String, Object> json) {
    return TodoModel.fromJson(json);
  }
}

/// @nodoc
const $TodoModel = _$TodoModelTearOff();

/// @nodoc
mixin _$TodoModel {
  String get todoId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get todo => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get predictingTime => throw _privateConstructorUsedError;
  int get leadTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoModelCopyWith<TodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoModelCopyWith<$Res> {
  factory $TodoModelCopyWith(TodoModel value, $Res Function(TodoModel) then) =
      _$TodoModelCopyWithImpl<$Res>;
  $Res call(
      {String todoId,
      String subject,
      String todo,
      bool isDone,
      DateTime createdAt,
      int predictingTime,
      int leadTime});
}

/// @nodoc
class _$TodoModelCopyWithImpl<$Res> implements $TodoModelCopyWith<$Res> {
  _$TodoModelCopyWithImpl(this._value, this._then);

  final TodoModel _value;
  // ignore: unused_field
  final $Res Function(TodoModel) _then;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? subject = freezed,
    Object? todo = freezed,
    Object? isDone = freezed,
    Object? createdAt = freezed,
    Object? predictingTime = freezed,
    Object? leadTime = freezed,
  }) {
    return _then(_value.copyWith(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      todo: todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictingTime: predictingTime == freezed
          ? _value.predictingTime
          : predictingTime // ignore: cast_nullable_to_non_nullable
              as int,
      leadTime: leadTime == freezed
          ? _value.leadTime
          : leadTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$TodoModelCopyWith<$Res> implements $TodoModelCopyWith<$Res> {
  factory _$TodoModelCopyWith(
          _TodoModel value, $Res Function(_TodoModel) then) =
      __$TodoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String todoId,
      String subject,
      String todo,
      bool isDone,
      DateTime createdAt,
      int predictingTime,
      int leadTime});
}

/// @nodoc
class __$TodoModelCopyWithImpl<$Res> extends _$TodoModelCopyWithImpl<$Res>
    implements _$TodoModelCopyWith<$Res> {
  __$TodoModelCopyWithImpl(_TodoModel _value, $Res Function(_TodoModel) _then)
      : super(_value, (v) => _then(v as _TodoModel));

  @override
  _TodoModel get _value => super._value as _TodoModel;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? subject = freezed,
    Object? todo = freezed,
    Object? isDone = freezed,
    Object? createdAt = freezed,
    Object? predictingTime = freezed,
    Object? leadTime = freezed,
  }) {
    return _then(_TodoModel(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      todo: todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      predictingTime: predictingTime == freezed
          ? _value.predictingTime
          : predictingTime // ignore: cast_nullable_to_non_nullable
              as int,
      leadTime: leadTime == freezed
          ? _value.leadTime
          : leadTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoModel implements _TodoModel {
  _$_TodoModel(
      {required this.todoId,
      required this.subject,
      required this.todo,
      required this.isDone,
      required this.createdAt,
      required this.predictingTime,
      required this.leadTime});

  factory _$_TodoModel.fromJson(Map<String, dynamic> json) =>
      _$$_TodoModelFromJson(json);

  @override
  final String todoId;
  @override
  final String subject;
  @override
  final String todo;
  @override
  final bool isDone;
  @override
  final DateTime createdAt;
  @override
  final int predictingTime;
  @override
  final int leadTime;

  @override
  String toString() {
    return 'TodoModel(todoId: $todoId, subject: $subject, todo: $todo, isDone: $isDone, createdAt: $createdAt, predictingTime: $predictingTime, leadTime: $leadTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoModel &&
            (identical(other.todoId, todoId) ||
                const DeepCollectionEquality().equals(other.todoId, todoId)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality()
                    .equals(other.subject, subject)) &&
            (identical(other.todo, todo) ||
                const DeepCollectionEquality().equals(other.todo, todo)) &&
            (identical(other.isDone, isDone) ||
                const DeepCollectionEquality().equals(other.isDone, isDone)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.predictingTime, predictingTime) ||
                const DeepCollectionEquality()
                    .equals(other.predictingTime, predictingTime)) &&
            (identical(other.leadTime, leadTime) ||
                const DeepCollectionEquality()
                    .equals(other.leadTime, leadTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(todoId) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(todo) ^
      const DeepCollectionEquality().hash(isDone) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(predictingTime) ^
      const DeepCollectionEquality().hash(leadTime);

  @JsonKey(ignore: true)
  @override
  _$TodoModelCopyWith<_TodoModel> get copyWith =>
      __$TodoModelCopyWithImpl<_TodoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoModelToJson(this);
  }
}

abstract class _TodoModel implements TodoModel {
  factory _TodoModel(
      {required String todoId,
      required String subject,
      required String todo,
      required bool isDone,
      required DateTime createdAt,
      required int predictingTime,
      required int leadTime}) = _$_TodoModel;

  factory _TodoModel.fromJson(Map<String, dynamic> json) =
      _$_TodoModel.fromJson;

  @override
  String get todoId => throw _privateConstructorUsedError;
  @override
  String get subject => throw _privateConstructorUsedError;
  @override
  String get todo => throw _privateConstructorUsedError;
  @override
  bool get isDone => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  int get predictingTime => throw _privateConstructorUsedError;
  @override
  int get leadTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodoModelCopyWith<_TodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
