import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxService {
  static NotificationService get to => Get.find<NotificationService>();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } on FirebaseException catch (exception, stackTrace) {
      if (exception.code != 'unknown') {}

      return null;
    }
  }

  Future<void> deleteToken() async {
    return FirebaseMessaging.instance.deleteToken();
  }

  @override
  void onInit() async {
    super.onInit();

    await _configureLocalTimeZone();
    await _initializeNotification();
  }

  Future<void> _initializeNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
    // await _flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  void _onSelectNotification(String? payload) {
    if (payload == null || payload == '') {
      return;
    }

    final decode = jsonDecode(payload) as Map<String, dynamic>;
    final url = decode['url'] as String?;
    final arguments = decode['arguments'] as Map<String, dynamic>?;
  }

  Future<void> createMessage({
    String title = 'semotalk',
    required String message,
    required int notificationId,
    Map<String, dynamic>? payload,
    int? setDay,
    int? setHour,
    int? setMinute,
    int? afterDay,
    int? afterHour,
    int? afterMinute,
  }) async {
    if ([setDay, setHour, setMinute, afterDay, afterHour, afterMinute]
        .every((e) => e == null)) {
      await _flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        message,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: jsonEncode(payload),
      );
    } else {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        setDay ?? now.day + (afterDay ?? 0),
        setHour ?? now.hour + (afterHour ?? 0),
        setMinute ?? now.minute + (afterMinute ?? 0),
      );

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        title,
        message,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: jsonEncode(payload),
      );
    }
  }

  Future<void> deleteMessage({
    required int notificationId,
  }) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> allDeleteMessage({
    required int notificationId,
  }) async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
