import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studyhelper/data/user/model/user_model.dart';

class FriendsController extends GetxController {
  static FriendsController get to => Get.find<FriendsController>();
  final CollectionReference friendsCollection =
      FirebaseFirestore.instance.collection('friends');

  final RxList<UserModel> _friends = RxList.empty();
  List<UserModel> get friends => _friends;
  set friends(List<UserModel> friends) => _friends(friends);

  Future<void> responseFriend({
    required bool isAccepted,
    required Map<String, dynamic> notification,
    required String myUid,
  }) async {
    if (isAccepted) {
      await friendsCollection.doc(myUid).set({
        "friends": FieldValue.arrayUnion([notification['sender']])
      });
      await friendsCollection.doc(notification['sender']).set({
        "friends": FieldValue.arrayUnion([myUid])
      });
    }
  }

  Stream<DocumentSnapshot> getFriends({required String myUid}) {
    return friendsCollection.doc(myUid).snapshots();
  }
}
