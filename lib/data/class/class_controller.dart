import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/class/model/class_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';

class ClassController extends GetxController {
  static ClassController get to => Get.find<ClassController>();

  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('class');

  final userService = UserService.to;
  UserModel get currentUser => userService.currentUser;

  final RxList<ClassModel> _classes = RxList.empty();
  List<ClassModel> get classes => _classes;
  set classes(List<ClassModel> classes) => _classes(classes);

  @override
  void onInit() async {
    getClass();
    super.onInit();
  }

  Future<void> getClass() async {
    switch (currentUser.type) {
      case ('학생'):
        await getStudentClass(uid: currentUser.uid);
        break;
      case ('학부모'):
        await getParentsClass(uid: currentUser.uid);
        break;
      default:
        return;
    }
  }

  Future<void> getParentsClass({required String uid}) async {
    QuerySnapshot snapshot = await classCollection
        .where('parentsId', arrayContains: UserService.to.currentUser.uid)
        .get();

    if (snapshot.docs.isEmpty) return;

    List<ClassModel> temp = RxList.empty();
    for (final e in snapshot.docs) {
      temp.add(ClassModel.fromJson(e.data() as Map<String, dynamic>));
    }
    _classes(temp);
  }

  Future<void> getStudentClass({required String uid}) async {
    QuerySnapshot snapshot = await classCollection
        .where('studentId', arrayContains: UserService.to.currentUser.uid)
        .get();

    if (snapshot.docs.isEmpty) return;

    List<ClassModel> temp = RxList.empty();
    for (final e in snapshot.docs) {
      temp.add(ClassModel.fromJson(e.data() as Map<String, dynamic>));
    }
    _classes(temp);
  }

  Future<void> changeClass({required ClassModel item}) async {
    await classCollection.doc(item.classId).set(item.toJson());
  }
}
