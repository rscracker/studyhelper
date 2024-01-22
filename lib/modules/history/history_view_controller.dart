import 'package:get/get.dart';
import 'package:studyhelper/services/todo_service.dart';

class HistoryViewController extends GetxController {
  static HistoryViewController get to => Get.find<HistoryViewController>();

  final todoService = TodoService.to;

  int get korean => todoService.korean;
  int get math => todoService.math;
  int get english => todoService.english;
  int get etc => todoService.etc;

  int get korean2 => todoService.korean2;
  int get math2 => todoService.math2;
  int get english2 => todoService.english2;
  int get etc2 => todoService.etc2;
}
