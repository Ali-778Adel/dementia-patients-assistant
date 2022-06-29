import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:untitled/bloc/notifications-bloc/notifications-states.dart';
import 'package:untitled/services/notifications_service.dart';
import 'package:timezone/data/latest.dart' as tz;


class NotificationsCubit extends Cubit<NotificationsStates>{

  NotificationsCubit():super(NInitState());

  static NotificationsCubit get(context)=>BlocProvider.of(context);

  NotificationsService?notificationsService;

  initNotifications(){
    notificationsService=NotificationsService();
    configureTimeZone();
    notificationsService!.initNotifications();
    emit(InitializeNotificationsState());
  }

  dispose(){
    // notificationsService!.flutterLocalNotificationsPlugin=null;
   notificationsService=null;
   initNotifications();
  }


  showScheduledNotification({
    required int id ,
    String ?title,
    String ?body,
   required int hours,
   required int minutes
})async{
       await notificationsService!.showScheduledNotifications(
           id: id,
           title: title,
           body: body,
           hours:hours,
           minutes: minutes
       ).catchError((error){
         throw(Exception('error on show schedule notifications$error'));
       });
  }



  Future<void>configureTimeZone()async{
   tz.initializeTimeZones();
   final String timezone=await FlutterNativeTimezone.getLocalTimezone();
   tz.setLocalLocation(tz.getLocation(timezone));
  }


}

