import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/notification/model/notification_model.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/services/user_service.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find<NotificationController>();

  final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('notifications');

  final userService = UserService.to;
  final RxList<NotificationModel> _notifications = RxList.empty();
  List<NotificationModel> get notifications => _notifications;
  set notifications(List<NotificationModel> notifications) =>
      _notifications(notifications);

  @override
  void onReady() async {
    getNotification(myUid: userService.currentUser.uid);
    super.onReady();
  }

  Future<void> addNotifcation({
    required UserModel receiver,
    required String content,
    required String myUid,
    String? type,
  }) async {
    String docId = notificationCollection.doc().id;
    await notificationCollection.doc(docId).set({
      'docId': docId,
      'type': type ?? '',
      'receiverToken': receiver.deviceToken,
      'receiver': receiver.uid,
      'content': content,
      'sender': myUid,
    });
  }

  Future<void> deleteNotification(
      {required NotificationModel notification}) async {
    await notificationCollection.doc(notification.docId).delete();
    notifications.remove(notification);
  }

  void getNotification({required String myUid}) {
    RxList<NotificationModel> newNotifications = RxList.empty();
    notificationCollection
        .where('receiver', isEqualTo: myUid)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        newNotifications
            .add(NotificationModel.fromJson(e.data() as Map<String, dynamic>));
      });
    });
    _notifications(newNotifications);
  }
}
