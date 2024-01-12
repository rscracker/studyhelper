import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhelper/services/notification_service.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/main/main_view.dart';
import 'package:studyhelper/modules/parents/parents_view.dart';
import 'package:studyhelper/modules/main/teacher_view.dart';
import 'package:studyhelper/modules/register/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends GetxService {
  static UserService get to => Get.find<UserService>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController authNumController = TextEditingController();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference friendsCollection =
      FirebaseFirestore.instance.collection('friends');

  final CollectionReference friendsRequestCollection =
      FirebaseFirestore.instance.collection('friendsRequest');

  final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('notifications');

  final Rx<UserModel> _currentUser = UserModel.initUser().obs;
  UserModel get currentUser => _currentUser.value;
  set currentUser(UserModel user) => _currentUser(user);

  RxString verId = ''.obs;

  Future<bool> signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId.value,
        smsCode: authNumController.text,
      );
      final User? temp = (await _auth.signInWithCredential(credential)).user;
      if (temp != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', temp.uid);
        bool result = await checkUser(uid: temp.uid);
        if (result) {
          Get.to(() => MainView());
        } else {
          Get.to(() => RegisterView());
        }
        return Future.value(true);
      }
      return Future.value(false);
    } catch (e) {
      print('error : ${e.toString()}');
      return Future.value(false);
    }
  }

  Future<void> smsAuth() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+82${phoneNumController.text.substring(1, 11)}',
          timeout: const Duration(seconds: 5),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            //await _auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException authException) {
            print('fail');
            print(authException.toString());
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            verId.value = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      print("Failed to Verify Phone Number: $e");
    }
  }

  Future<bool> checkUser({required String uid}) async {
    String token = await NotificationService.to.getToken() ?? '';
    print('device token : $token');
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    if (snapshot.data() == null) {
      currentUser.copyWith(
        uid: uid,
        deviceToken: token,
      );
      await userCollection.doc(uid).set(UserModel(
              uid: uid,
              type: '',
              nick: '',
              name: '',
              age: 0,
              phoneNum: phoneNumController.text,
              deviceToken: token,
              isRegistered: false)
          .toJson());
      return Future.value(false);
    } else {
      UserModel user =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      if (user.deviceToken.isEmpty || user.deviceToken != token) {
        user = user.copyWith(deviceToken: token);
        await userCollection.doc(user.uid).update({'deviceToken': token});
      }
      currentUser = user;
      if (user.isRegistered) {
        return Future.value(true);
      }
      return Future.value(false);
    }
  }

  Future<void> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');
    if (uid != null) {
      bool result = await checkUser(uid: uid);
      if (result) {
        //Get.to(() => MainView());
        if (currentUser.type == '선생님') {
          Get.to(() => TeacherView());
        } else if (currentUser.type == '학부모') {
          Get.to(() => ParentsView());
        } else {
          Get.toNamed('/main');
        }
      } else {
        Get.to(() => RegisterView());
      }
    }
  }

  Future<UserModel> findUser({required String nick}) async {
    QuerySnapshot snapshot =
        await userCollection.where('nick', isEqualTo: nick).get();
    return UserModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>);
  }

  Future<UserModel> getUser({required String uid}) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> addNotifcation(
      {required UserModel receiver,
      required String content,
      String? type}) async {
    String docId = notificationCollection.id;
    await notificationCollection.doc(docId).set({
      'docId': docId,
      'type': type ?? '',
      'receiverToken': receiver.deviceToken,
      'receiver': receiver.uid,
      'content': content,
      'sender': currentUser.uid
    });
  }

  Stream<QuerySnapshot> getNotification() {
    return notificationCollection
        .where('receiver', isEqualTo: currentUser.uid)
        .snapshots();
  }

  Future<QuerySnapshot> findUsers(
      {required bool isNick, required String nameOrNick}) async {
    if (isNick) {
      return await userCollection.where('nick', isEqualTo: nameOrNick).get();
    } else {
      return await userCollection.where('name', isEqualTo: nameOrNick).get();
    }
  }

  Future<void> requestFriend({required UserModel user}) async {
    await friendsRequestCollection.add({
      'sender': currentUser.uid,
      'receiver': user.uid,
      'createdAt': DateTime.now()
    });
    addNotifcation(
        receiver: user,
        content: '${currentUser.name}님의 친구요청이 있습니다.',
        type: 'friendRequest');
  }

  Future<void> responseFriend(
      {required bool isAccepted,
      required Map<String, dynamic> notification}) async {
    if (isAccepted) {
      await friendsCollection.doc(currentUser.uid).set({
        "friends": FieldValue.arrayUnion([notification['sender']])
      });
      await friendsCollection.doc(notification['sender']).set({
        "friends": FieldValue.arrayUnion([currentUser.uid])
      });
    }
    await notificationCollection.doc(notification['docId']).delete();
  }

  Stream<DocumentSnapshot> getFriends() {
    return friendsCollection.doc(currentUser.uid).snapshots();
  }
}