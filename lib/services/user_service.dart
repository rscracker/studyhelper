import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhelper/data/notification/model/notification_model.dart';
import 'package:studyhelper/services/notification_service.dart';
import 'package:studyhelper/data/user/model/user_model.dart';
import 'package:studyhelper/modules/main/teacher_view.dart';
import 'package:studyhelper/modules/register/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends GetxService {
  static UserService get to => Get.find<UserService>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference friendsRequestCollection =
      FirebaseFirestore.instance.collection('friendsRequest');

  final Rx<UserModel> _currentUser = UserModel.initUser().obs;
  UserModel get currentUser => _currentUser.value;
  set currentUser(UserModel user) => _currentUser(user);

  final RxList<UserModel> _friends = RxList.empty();
  List<UserModel> get friends => _friends;
  set friends(List<UserModel> friends) => _friends(friends);
  RxString verId = ''.obs;

  @override
  void onReady() {
    super.onReady();
  }

  Future<bool> signInWithPhoneNumber(
      {required String authNum, required String phoneNum}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId.value,
        smsCode: authNum,
      );
      final User? temp = (await _auth.signInWithCredential(credential)).user;
      if (temp != null) {
        _currentUser(currentUser.copyWith(phoneNum: phoneNum, uid: temp.uid));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', temp.uid);
        bool result = await checkUser();
        if (result) {
          Get.offNamed('/main');
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

  Future<void> smsAuth({required String phoneNum}) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          timeout: const Duration(seconds: 60),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            print('completed');
            //await _auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException authException) {
            print('auth Error');
            print(authException.toString());
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            verId.value = verificationId;
            print(verificationId);
            print('complete');
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      print("Failed to Verify Phone Number: $e");
    }
  }

  Future<bool> checkUser() async {
    String token = await NotificationService.to.getToken() ?? '';
    DocumentSnapshot snapshot = await userCollection.doc(currentUser.uid).get();
    if (snapshot.data() == null) {
      await userCollection.doc(currentUser.uid).set(currentUser.toJson());
      return Future.value(false);
    } else {
      UserModel user =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      if (user.deviceToken.isEmpty || user.deviceToken != token) {
        user = user.copyWith(deviceToken: token);
        await userCollection.doc(user.uid).update({'deviceToken': token});
      }
      _currentUser(user);
      getFriends(myUid: currentUser.uid);
      if (user.isRegistered) {
        return Future.value(true);
      }
      return Future.value(false);
    }
  }

  Future<void> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');
    if (uid != null && uid.isNotEmpty) {
      _currentUser(currentUser.copyWith(uid: uid));
      bool result = await checkUser();
      if (result) {
        if (currentUser.type == '선생님') {
          Get.to(() => const TeacherView());
        } else if (currentUser.type == '학부모') {
          Get.offNamed('/parents');
        } else {
          Get.offNamed('/main');
        }
      } else {
        Get.to(() => const RegisterView());
      }
    }
  }

  void signOut() async {}

  Future<UserModel> findUser({required String nick}) async {
    QuerySnapshot snapshot =
        await userCollection.where('nick', isEqualTo: nick).get();
    return UserModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>);
  }

  Future<UserModel> getUser({required String uid}) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<List<UserModel>> findUsers(
      {required bool isNick, required String nameOrNick}) async {
    final QuerySnapshot snapshot;
    if (isNick) {
      snapshot =
          await userCollection.where('nick', isEqualTo: nameOrNick).get();
    } else {
      snapshot =
          await userCollection.where('name', isEqualTo: nameOrNick).get();
    }
    RxList<UserModel> users = RxList.empty();

    snapshot.docs.forEach((e) {
      users.add(UserModel.fromJson(e.data() as Map<String, dynamic>));
    });

    return users;
  }

  Future<void> responseFriend({
    required bool isAccepted,
    required NotificationModel notification,
  }) async {
    if (isAccepted) {
      await userCollection.doc(currentUser.uid).update({
        "friends": FieldValue.arrayUnion([notification.sender])
      });
      await userCollection.doc(notification.sender).update({
        "friends": FieldValue.arrayUnion([currentUser.uid])
      });
    }
  }

  void getFriends({required String myUid}) {
    RxList<UserModel> temp = RxList.empty();
    userCollection.doc(myUid).snapshots().listen((DocumentSnapshot snapshot) {
      UserModel user =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      if (user.friends != null) {
        user.friends!.forEach((e) async {
          temp.add(await getUser(uid: e));
        });
        _friends(temp);
      }
    });
  }
}
