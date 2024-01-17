import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/exam/model/exam_model.dart';
import 'package:studyhelper/utils/utils.dart';

class ExamController extends GetxController {
  static ExamController get to => Get.find<ExamController>();

  final CollectionReference examCollection =
      FirebaseFirestore.instance.collection('exam');

  Future<void> addExam({
    required String userId,
    required ExamModel exam,
  }) async {
    String examId = examCollection
        .doc(userId)
        .collection(Utils.convertDate(date: exam.date))
        .doc()
        .id;
    exam.copyWith(examId: examId);
    await examCollection
        .doc(userId)
        .collection(Utils.convertDate(date: exam.date))
        .add(exam.toJson());
  }
}
