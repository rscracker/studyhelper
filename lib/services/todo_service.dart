import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';
import 'package:studyhelper/utils/utils.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';

class TodoService extends GetxService {
  static TodoService get to => Get.find<TodoService>();

  final userService = UserService.to;

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todo');

  RxList<TodoModel> todos = RxList.empty();
  RxList<TodoModel> thisWeekTodos = RxList.empty();

  UserModel get user => userService.currentUser;

  int get korean => Utils.getTime(subject: '국어', todoList: todos);
  int get english => Utils.getTime(subject: '영어', todoList: todos);
  int get math => Utils.getTime(subject: '수학', todoList: todos);
  int get etc => Utils.getTime(subject: '기타', todoList: todos);

  int get korean2 => Utils.getTime(subject: '국어', todoList: thisWeekTodos);
  int get english2 => Utils.getTime(subject: '영어', todoList: thisWeekTodos);
  int get math2 => Utils.getTime(subject: '수학', todoList: thisWeekTodos);
  int get etc2 => Utils.getTime(subject: '기타', todoList: thisWeekTodos);

  int get total => korean + english + math + etc;

  RxInt maxTime = 0.obs;

  Future<void> createTodo(
      {required String subject,
      required String todo,
      required DateTime date}) async {
    String docId = todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: DateTime.now()))
        .doc()
        .id;
    TodoModel newTodo = TodoModel(
        todoId: docId,
        subject: subject,
        todo: todo,
        isDone: false,
        createdAt: date,
        predictingTime: 0,
        leadTime: 0);
    todos.add(newTodo);
    await todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: DateTime.now()))
        .doc(docId)
        .set(newTodo.toJson());
  }

  Future<void> deteteTodo({required TodoModel todo}) async {
    todos.remove(todo);
    await todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: todo.createdAt))
        .doc(todo.todoId)
        .delete();
  }

  Future<void> getTodo() async {
    QuerySnapshot snapshot = await todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: DateTime.now()))
        .get();
    List<TodoModel> temp = RxList.empty();
    for (final e in snapshot.docs) {
      temp.add(TodoModel.fromJson(e.data() as Map<String, dynamic>));
    }
    todos.assignAll(temp);
  }

  Future<List<TodoModel>> getStudentTodo({required String uid}) async {
    QuerySnapshot snapshot = await todoCollection
        .doc(uid)
        .collection(Utils.convertDate(date: DateTime.now()))
        .get();

    List<TodoModel> temp = RxList.empty();
    for (var e in snapshot.docs) {
      temp.add(TodoModel.fromJson(e.data() as Map<String, dynamic>));
    }
    return temp;
  }

  Future<void> getThisWeekTodos() async {
    int today = DateTime.now().weekday;
    List<TodoModel> temp = RxList.empty();

    if (today != 1) {
      for (int i = 1; i < today; i++) {
        QuerySnapshot snapshot = await todoCollection
            .doc(user.uid)
            .collection(Utils.convertDate(
                date: DateTime.now().subtract(Duration(days: i))))
            .get();
        for (var e in snapshot.docs) {
          TodoModel now = TodoModel.fromJson(e.data() as Map<String, dynamic>);
          temp.add(now);
          if (now.leadTime > maxTime.value) {
            maxTime.value = now.leadTime;
          }
        }
      }
    }
    thisWeekTodos.assignAll(temp);
  }

  Future<void> onTodoDone({required TodoModel todo}) async {
    await todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: todo.createdAt))
        .doc(todo.todoId)
        .update({'isDone': !todo.isDone});

    for (int i = 0; i < todos.length; i++) {
      if (todos[i].todoId == todo.todoId) {
        todos[i] = todos[i].copyWith(isDone: !todos[i].isDone);
        break;
      }
    }
  }

  Future<void> timeCheck({required TodoModel todo, required int time}) async {
    await todoCollection
        .doc(user.uid)
        .collection(Utils.convertDate(date: todo.createdAt))
        .doc(todo.todoId)
        .update({'leadTime': FieldValue.increment(time)});
    await getTodo();
  }
}
