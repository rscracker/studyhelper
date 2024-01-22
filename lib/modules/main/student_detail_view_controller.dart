import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/todo_service.dart';

class StudentDetailViewController extends GetxController {
  static StudentDetailViewController get to =>
      Get.find<StudentDetailViewController>();

  final todoService = TodoService.to;

  final Rx<UserModel> _selectedUser = UserModel.initUser().obs;
  UserModel get selectedUser => _selectedUser.value;
  set selectedUser(UserModel user) => _selectedUser(user);

  final RxList<TodoModel> _todos = RxList.empty();
  List<TodoModel> get todos => _todos;
  set todos(List<TodoModel> todos) => _todos(todos);

  @override
  void onInit() async {
    _selectedUser(Get.arguments);
    _todos(await todoService.getStudentTodo(uid: selectedUser.uid));
    super.onInit();
  }
}
