import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_backgroundMessage);
  }

  @pragma('vm:entry-point')
  Future<void> _backgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
  }

    static Future<void> subscribeToTopic(String topic) async {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    }
}
