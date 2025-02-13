import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../routes/routes.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();


  static Future<void> initialize(Function(String?) onNotificationTap) async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        onNotificationTap(response.payload);
      },
    );


    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      description: 'VPN Connection Notifications',
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }



  static Future<bool> requestPermissions() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print('✅ Notification permission granted');
    } else if (status.isDenied) {
      print('❌ Notification permission denied');
      return false;
    } else if (status.isPermanentlyDenied) {
      print(
          '⚠️ Notification permission permanently denied. Ask user to enable it from settings.');
      openAppSettings();
      return false;
    }

    NotificationSettings fcmSettings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (fcmSettings.authorizationStatus == AuthorizationStatus.denied) {
      print('❌ Firebase Messaging permission denied.');
      return false;
    } else if (fcmSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('⚠️ Firebase Messaging permission granted provisionally.');
    } else {
      print('✅ Firebase Messaging permission granted.');
    }

    return true;
  }

  static Future<void> showSimpleNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      1,
      "VPN Disconnected",
      "Your time is over, tap to connect it again",
      details,
      payload: "open_page",
    );
  }

  void showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id', 'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(0, title, body, notificationDetails);
  }

  void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔔 Foreground Message Received!");

      if (message.notification != null) {
        showLocalNotification(
          message.notification!.title!,
          message.notification!.body!,
        );
      }
    });
  }

  void checkInitialMessage() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print("🚀 App opened via terminated notification!");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");

      // Navigate to screen specified in data payload
      if (message.data.containsKey('screen')) {
        Get.toNamed(message.data['screen']);
      } else {
        Get.toNamed(AppRoutes.guestHome); // Default screen if no data key
      }
    }
  }
}