import 'package:intl/intl.dart';
import 'package:studyhelper/data/todo/model/todo_model.dart';

class Utils {
  Utils._();

  static String convertDate({required date}) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static int getTime(
      {required String subject, required List<TodoModel> todoList}) {
    int temp = 0;
    for (var e in todoList) {
      if (e.subject == subject) {
        temp += e.leadTime;
      }
    }
    return temp;
  }

  static String convertTime({required int time}) {
    return '${(time ~/ 60).toString().padLeft(2, '0')}:${(time % 60).toString().padLeft(2, '0')}';
  }

  static String convertTime2({required int time}) {
    return '${time.toString().substring(0, 2)}:${time.toString().substring(2, 4)}';
  }
}
