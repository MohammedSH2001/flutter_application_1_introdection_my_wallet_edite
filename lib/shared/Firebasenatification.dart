// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1_introdection_my_wallet/main.dart';
// import 'package:flutter_application_1_introdection_my_wallet/pasges/NotificationScreen.dart';

// class FirebaseNatification {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     String? token = await _firebaseMessaging.getToken();
//     print("Token : $token");
//     handleBackgroundNotification();
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     navigatorkey.currentState!
//         .pushNamed(NotificationScreen.routeName, arguments: message);
//   }

//   Future handleBackgroundNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }
