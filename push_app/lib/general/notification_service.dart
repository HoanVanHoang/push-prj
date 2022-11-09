
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_common.dart';
class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    "2403",   //Required for Android 8.0 or after
    "laginza", //Required for Android 8.0 or after
    channelDescription: "app for shopping", //Required for Android 8.0 or after
    importance: Importance.high,
    priority: Priority.max,
    autoCancel: true,
    icon: 'app_icon',
  );

  final IOSNotificationDetails iOSPlatformChannelSpecifics =
  IOSNotificationDetails(
      presentAlert: true,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound: true,  // Specifics the file path to play (only from iOS 10 onwards)
      attachments: [],
      subtitle: "laginza", //Secondary description  (only from iOS 10 onwards)
      threadIdentifier: "threadIsolate"
  );



  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    requestIOSPermissions(flutterLocalNotificationsPlugin);
  }


  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
    Map<String,dynamic> data = json.decode(payload!);
    print("on select data: $data");
    ConfigApp().processNotification(data['data'], data['data']['title'], data['data']['content']);
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page

  }


  void showMessage(int? id, String? title, String? body,
      String? payload) async{
    print("show message");
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id!, title!, body!, platformChannelSpecifics,payload: payload!);
  }


  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

}