import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studyhelper/modules/main/bindings/main_binding.dart';
import 'package:studyhelper/routes/app_pages.dart';
import 'package:studyhelper/services/notification_service.dart';
import 'package:studyhelper/services/todo_service.dart';
import 'package:studyhelper/services/user_service.dart';
import 'package:studyhelper/firebase_options.dart';
import 'package:studyhelper/modules/login/login_view.dart';
import 'package:studyhelper/modules/main/main_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('back : ${message.notification?.body}');
}

Future<void> _firebaseMessagingForegroundHandler(RemoteMessage message) async {
  print('fore : ${message.notification?.body}');
  NotificationService.to.createMessage(
    title: message.notification?.title ?? '',
    message: message.notification?.body ?? '',
    notificationId: message.hashCode,
    payload: message.data,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final url = message.data['url'] as String?;
    final arguments = message.data['arguments'] as Map<String, dynamic>?;
  });
  FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansKR',
      ),
      home: const LoginView(),
      initialBinding: BindingsBuilder(() {
        Get.put(UserService());
        Get.put(TodoService());
        Get.put(NotificationService());
      }),
      getPages: AppPages.routes,
    );
  }
}
