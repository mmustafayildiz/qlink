


import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grock/grock.dart';



class FirebaseMessagingService{
  late final FirebaseMessaging messaging;

  void settingNotification() async{
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,

    );
  }

  void connetctNotification()async{
    await Firebase.initializeApp();
    messaging= FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(alert: true,
      sound: true,
      badge: true,);
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        sound: true,
        badge: true
    );
    settingNotification();
    void _messageHandler(Map<dynamic, dynamic> message, String type) async {

    }
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _messageHandler(message.data, 'onMessage');
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _messageHandler(message.data, 'onResume');
        // İlgili işlemleri gerçekleştir
      });

      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        _messageHandler(message.data, 'onBackground');
        // İlgili işlemleri gerçekleştir
      });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      Grock.snackBar(title: "${event.notification?.title  }",
        description: "${event.notification?.body }",
      opacity: 0.5,
      position: SnackbarPosition.top
      );
    });
    messaging.getToken().then((value) => log("Token:$value", name: "Fcm Token"));
  }

}}
