import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_service.dart';

class BackgroundGeoLocationService extends Cubit<BackgroundGeoLocationServiceStates>{
  BackgroundGeoLocationService() : super(BGSSInitState());
  NotificationsService notificationsService=NotificationsService();
  initState(){
    bg.BackgroundGeolocation.onLocation((bg.Location location)async {
      print('[location] - $location');
      notificationsService.flutterLocalNotificationsPlugin.show(1, '${location.coords.longitude}','do not warry',await notificationsService.notificationsDetails());
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location)async {
      print('[motionchange] - $location');
      notificationsService.flutterLocalNotificationsPlugin.show(2, '${location.coords.longitude}','longtiude',await notificationsService.notificationsDetails());

    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event)async {
      print('[providerchange] - $event');
      notificationsService.flutterLocalNotificationsPlugin.show(3, '${event.gps}','motion',await notificationsService.notificationsDetails());

    });


    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: .5,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state)async {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        notificationsService.flutterLocalNotificationsPlugin.show(4, '${state.notification}','state1',await notificationsService.notificationsDetails());
      bg.BackgroundGeolocation.start().then((value)async{
          notificationsService.flutterLocalNotificationsPlugin.show(5, '${value.notification}','state 2',await notificationsService.notificationsDetails());
           value.notification;
          print('current user location is ${value.notification}');
        });
      }else if (state.didLaunchInBackground){
        notificationsService.flutterLocalNotificationsPlugin.show(6, '${state.notification}','state1',await notificationsService.notificationsDetails());
        bg.BackgroundGeolocation.start().then((value)async{
          notificationsService.flutterLocalNotificationsPlugin.show(7, '${value.notification}','state2',await notificationsService.notificationsDetails());
          value.notification;
          print('current user location is ${value.notification}');
        });
      }else if (state.enabled){
        notificationsService.flutterLocalNotificationsPlugin.show(10, '${state.notification}','state10',await notificationsService.notificationsDetails());
        bg.BackgroundGeolocation.start().then((value)async{
          notificationsService.flutterLocalNotificationsPlugin.show(7, '${value.notification}','state2',await notificationsService.notificationsDetails());
          value.notification;
          print('current user location is ${value.notification}');
        });
      }
    });
    emit(BGSSInitState());
  }


}

class BackgroundGeoLocationServiceStates{}
 class BGSSInitState extends BackgroundGeoLocationServiceStates{}
