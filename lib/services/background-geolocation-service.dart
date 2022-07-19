import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'notifications_service.dart';

class BackgroundGeoLocationService extends Cubit<BackgroundGeoLocationServiceStates>{
  BackgroundGeoLocationService() : super(BGSSInitState());
  NotificationsService notificationsService=NotificationsService();
  // static final url ='https://www.google.com/maps/dir/?api=1&origin=30.4322397,31.4535374&destination=30.4459651,31.4464248&&travelmode=driving&dir_action=navigate';

  launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await  launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  initState(){
    bg.BackgroundGeolocation.onLocation((bg.Location location)async {
      print('here is data for location ###########################[]');
      print('[location] - $location');
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location)async {
      print('here is data for motion  ###########################[]');
      print('[motionchange] - $location');
       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
           {
             'locationLat':'${location.coords.latitude}',
             'locationLng':'${location.coords.longitude}',

           }
       );
      bg.BackgroundGeolocation.setConfig(Config(
          stopOnStationary: false,
          stationaryRadius: 1,
          notification: Notification(
            layout: 'notification_layout',
            title: 'you are moving to where motion  ',
            text: "please keep safe  ",
            actions: [
              'notificationButtonFoo',
              'notificationButtonBar'
            ],
           sticky: true
          )
      )
      ).then((value) {
        bg.BackgroundGeolocation.onNotificationAction((p0){
          0

























          switch(p0){
            case 'notificationButtonFoo':{
              final url ='https://www.google.com/maps/dir/?api=1&origin=${location.coords.latitude},${location.coords.longitude}&destination=30.5850036,31.5239059&&travelmode=driving&dir_action=navigate';
              launchUrl(Uri.parse(url));
              print('foo is tapped');
            }
            break;
            case 'notificationButtonBar':{
              final url ='https://www.google.com/maps/dir/?api=1&origin=${location.coords.latitude},${location.coords.longitude}&destination=30.4318738,31.4537318&&travelmode=driving&dir_action=navigate';
              launchUrl(Uri.parse(url));
              print('foo is tapped');
            }
              break;
          }
        });
      });
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event)async {

      bg.BackgroundGeolocation.setConfig(Config(
        stopOnStationary: false,
          stationaryRadius: 1,
          notification: Notification(
        layout: 'notification_layout',
        title: 'location back ground service is running provider',
        text: "please don't turn location off ",
        actions: [
          'notificationButtonFoo',
          'notificationButtonBar'
        ],

      )
      )
      );
      BackgroundGeolocation.ready(bg.Config(
         notification: Notification(
          layout: 'notification_layout',
          title: 'location back ground service is running provider',
          text: "please don't turn location off ",
          actions: [
            'notificationButtonFoo',
            'notificationButtonBar'
          ],

      ),
      ));
      BackgroundGeolocation.onNotificationAction((buttonId) {
        // Listen to custom notification button clicks (notification.actions)
        print('[onNotificationAction] - $buttonId');
        switch(buttonId) {
          case 'notificationButtonFoo':{
            const url ='https://www.google.com/maps/dir/?api=1&origin=30.4322397,31.4535374&destination=30.4459651,31.4464248&&travelmode=driving&dir_action=navigate';
            launchUrl(Uri.parse(url));
            print('foo is tapped');
          }
          break;
          case 'notificationButtonBar':
          // Handle button click on [Bar]
            break;
        }
      });

    });
    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 1,
        stationaryRadius: 1,
        stopOnStationary: false,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        notification: Notification(
            layout: 'notification_layout',
            title: 'you are moving to where ?',
          text: "please keep safe  ",
            actions: [
              'notificationButtonFoo',
              'notificationButtonBar'
            ],
          // sticky: true
        ),

    ),


    ).then((bg.State state)async {
      BackgroundGeolocation.onNotificationAction((buttonId) {
        // Listen to custom notification button clicks (notification.actions)
        print('[onNotificationAction] - $buttonId');
        switch(buttonId) {
          case 'notificationButtonFoo':{
            const url ='https://www.google.com/maps/dir/?api=1&origin=30.4322397,31.4535374&destination=30.4459651,31.4464248&&travelmode=driving&dir_action=navigate';
            launchUrl(Uri.parse(url));
            print('foo is tapped');
          }
          break;
          case 'notificationButtonBar':{
            const url ='https://www.google.com/maps/dir/?api=1&origin=30.58604679999999,31.5234661&destination=30.4322397,31.4535374&&travelmode=driving&dir_action=navigate';
            launchUrl(Uri.parse(url));
            print('foo is tapped');
          }
          // Handle button click on [Bar]
            break;
        }
      });
      if (!state.enabled) {
      bg.BackgroundGeolocation.start().then((value)async{
          if (value.isMoving!){


          }
        });
      }else {
        bg.BackgroundGeolocation.start().then((value)async{
          if(value.isMoving!){
            // BackgroundGeolocation.setConfig(Config(
            //   notification: Notification(
            //     title: 'i am in back ground ',
            //     text: 'app is terminated now and it is in background '
            //   )
            // )
            // );
          }
          // notificationsService.flutterLocalNotificationsPlugin.show(7, '${value.notification}','state2',await notificationsService.notificationsDetails());
          // print('current user location is ${value.notification}');
        });
      }
    });
    emit(BGSSInitState());
  }


}

class BackgroundGeoLocationServiceStates{}
 class BGSSInitState extends BackgroundGeoLocationServiceStates{}
