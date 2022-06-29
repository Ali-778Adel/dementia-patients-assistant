import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled/services/notifications_service.dart';
import 'package:http/http.dart' as http;

class FirebaseNotificationService{
NotificationsService notificationsService=NotificationsService();

  onInit(){
    // loadFCM();
    // requestPermission();
    // listenFCM();
   getInitialMessage();
   onMessage();
   onMessageOpenedApp();
  }
  Future<void> backgroundHandler(RemoteMessage message) async {
    print('background messeage *8888888***************');
  }

Future<void>getInitialMessage()async{
  await FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );
}
Future<void>onMessage()async{
  FirebaseMessaging.onMessage.listen(
        (message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data11 ${message.data}");
        createanddisplaynotification(message);
      }
    },
  );
}

Future<void>onMessageOpenedApp()async{
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data22 ${message.data['_id']}");
      }
    },
  );

}
 void createanddisplaynotification(RemoteMessage message) async {
  try {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "firebaseNotifications",
        "firebaseNotifications",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await notificationsService.flutterLocalNotificationsPlugin.show(
      id,

      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data['_id'],
    );
  } on Exception catch (e) {
    print(e);
  }
}






FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
var channel;
void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}
void loadFCM() async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'firebaseNotifications', // id
      'firebaseNotifications', // title
      importance: Importance.high,
      enableVibration: true,
    );



    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);


    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}


void listenFCM() async {
 print(' startr listining');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            icon: '@drawable/notebook',
          ),
        ),
      );
    }
  });
}

void sendPushMessage(String body, String title, String token) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAAHJxb3ds:APA91bGo43_ZnqyUlpnJI67JWg2xiLng1xdmGifpgD21gt3Os85V-F1dcSgrSO10WynkUCJYyoP1wVcfQwPg_kjVQcTCElRQIvnJoicY5fPqXS6fWfsbr4UE-9knpTijEkKl9AEMoXLI',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
    print('done');
  } catch (e) {
    print("error push notification");
  }
}


}