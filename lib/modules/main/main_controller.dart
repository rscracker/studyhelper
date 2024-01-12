import 'package:get/get.dart';
import 'package:studyhelper/data/class/class_controller.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/services/user_service.dart';

class MainController extends GetxController {
  final todoService = TodoService.to;
  final userService = UserService.to;
  final classController = ClassController.to;

  UserModel get currentUser => userService.currentUser;
  List<TodoModel> get todos => todoService.todos;
  List<TodoModel> get thisWeekTodos => todoService.thisWeekTodos;
  List<ClassModel> get classes => classController.classes;

  @override
  void onInit() async {
    await todoService.getTodo();
    await todoService.getThisWeekTodos();
    super.onInit();
  }

  void onTodoDone(TodoModel todo) {
    todoService.onTodoDone(todo: todo);
  }

  void onDeleteTodo(TodoModel todo) {
    todoService.deteteTodo(todo: todo);
  }
}
