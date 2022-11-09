
import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_app/views/detail_notify.dart';

import 'context_global.dart';
import 'notification_service.dart';

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  String body = message.notification!.body!;
  String title = message.notification!.title!;
  //print(message.data);
  print("on backgournd: "+message.notification!.android!.imageUrl!);
  // NotificationService().showMessage(Random().nextInt(10000), title +"asgdg", body, json.encode(
  //     {"data":message.data}));
  return;
}


GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



class ConfigApp {
  Future instance() async {
    await _configFirebase();
  }

  final PRODUCT_DETAIL = 1;
  final VOUCHER = 2;
  final CAMPAIN = 3;
  final ID_KEY = "id";
  final TYPE_KEY = "type";
  final LINK_KEY = "link_url";
  final IMAGE = "image";

  Future _configFirebase() async {
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage,);
    FirebaseMessaging.onMessage.listen(_onMessage);

    FirebaseMessaging.instance.getToken().then((value) {
      print(" --------------${value}");
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {

    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      print("on select data open app: ${event.data}");
      processNotification(event.data, event.notification?.title??"", event.notification?.body??"");

    });
  }
  void processNotification(Map<String,dynamic> data, String tiltle, String content) async{
    Navigator.push(NavigationService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (builder)=>DetailNotify(object: {"title":tiltle, "content": content})));
  }


  Future<void> _onMessage(RemoteMessage event) async {
    String body = event.notification!.body!;
    String title = event.notification!.title!;
    print("on messgae ${event.data}");

    NotificationService()
        .showMessage(Random().nextInt(10000),
        title, body, json.encode( {"data":event.data}));
  }

}
