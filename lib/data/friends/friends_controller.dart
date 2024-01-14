// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:studyhelper/data/notification/model/notification_model.dart';
// import 'package:studyhelper/data/user/model/user_model.dart';
// import 'package:studyhelper/services/user_service.dart';
//
// class FriendsController extends GetxController {
//   static FriendsController get to => Get.find<FriendsController>();
//   final CollectionReference friendsCollection =
//       FirebaseFirestore.instance.collection('friends');
//
//   final RxList<UserModel> _friends = RxList.empty();
//   List<UserModel> get friends => _friends;
//   set friends(List<UserModel> friends) => _friends(friends);
//
//   final userService = UserService.to;
//
//   @override
//   void onInit() {
//     getFriends(myUid: userService.currentUser.uid);
//     super.onInit();
//   }
//
//   Future<void> responseFriend({
//     required bool isAccepted,
//     required NotificationModel notification,
//     required String myUid,
//   }) async {
//     if (isAccepted) {
//       await friendsCollection.doc(myUid).set({
//         "friends": FieldValue.arrayUnion([notification.sender])
//       });
//       await friendsCollection.doc(notification.sender).set({
//         "friends": FieldValue.arrayUnion([myUid])
//       });
//     }
//   }
//
//   void getFriends({required String myUid}) {
//     RxList<UserModel> temp = RxList.empty();
//     friendsCollection
//         .doc(myUid)
//         .snapshots()
//         .listen((DocumentSnapshot snapshot) {});
//     _friends(temp);
//   }
// }
