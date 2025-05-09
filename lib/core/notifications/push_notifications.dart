import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class FCMServices {
  String? _token;

  static final _fcmServices = FirebaseMessaging.instance;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  

  _init() async {
    _token = await _fcmServices.getToken();
  }
}
