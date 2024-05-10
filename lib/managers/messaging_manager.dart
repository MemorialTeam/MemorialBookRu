import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../helpers/constants.dart';

Future initFirebaseMessaging() async {
  await Firebase.initializeApp();

  await FirebaseMessagingManager.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(FirebaseMessagingManager.channel);

  if (Platform.isAndroid) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

class FirebaseMessagingManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  static registerAction(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ignore: unused_local_variable
      RemoteNotification? notification = message.notification;
    });
  }

  static void init() {
    requestPermissions();
    registerNotificationsSettings();
    onForegroundMessage();
  }

  static requestPermissions() {
    FirebaseMessaging.instance.requestPermission();
  }

  static void registerNotificationsSettings() {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsiOS =
    const DarwinInitializationSettings(defaultPresentBadge: true);

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsiOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String fcmToken = await messaging.getToken() ?? '';

    final storage = await SharedPreferences.getInstance();
    storage.setString(ConstantsKeys.fcm, fcmToken);
    // ignore: avoid_print
    print('Получили токен: $fcmToken');
  }

  static Future<void> onBackgroundMessage(
      RemoteMessage message,
      ) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            icon: null,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: true,
          ),
        ),
      );
    }
  }

  static void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        RemoteNotification? notification = message.notification;

        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                playSound: true,
                icon: null,
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
          );
        }
      },
    );
  }
}
