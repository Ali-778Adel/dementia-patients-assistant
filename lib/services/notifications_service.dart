import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationsService{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  BehaviorSubject? onNotificationsTapped=BehaviorSubject<String>();


  Future <void>initNotifications()async{
    configureTimeZone();

    const android=  AndroidInitializationSettings('@drawable/notebook');
    const iOS=IOSInitializationSettings();
    const settings=InitializationSettings(android: android,iOS: iOS);
    
    await flutterLocalNotificationsPlugin.initialize(
        settings,
        onSelectNotification:((payload) {
          onNotificationsTapped!.add(payload);
        }) );

  }

  Future notificationsDetails()async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'tasksChannel',
        channelDescription: 'this Notifications Channel for tasks time schedule',
        importance: Importance.max,
        priority: Priority.high
      ),
      iOS: IOSNotificationDetails( )
    );
  }


  Future showScheduledNotifications( {required int id ,String ?title ,String?body,String ?payload,required int hours,required int minutes })async{
    flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        convertTime(hour: hours,minute: minutes),
        await notificationsDetails(),
        payload: payload,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidAllowWhileIdle: true,
    );
  }



  tz.TZDateTime convertTime({required  int hour,required int minute}){
    final tz.TZDateTime now=tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduleDateTime=tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minute);

    // if(scheduleDateTime.isBefore(now)){
    //   scheduleDateTime.add(const Duration(days: 1));
    // }
    return scheduleDateTime;
  }
  Future<void>configureTimeZone()async{
    tz.initializeTimeZones();
    final String timezone=await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  void listenNotifications()=>onNotificationsTapped!.stream.listen((event) { onClickNotifications;});
  void onClickNotifications(BuildContext context,Widget targetWidget,String payload){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>targetWidget));
  }

//firebaseSection


}