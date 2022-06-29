import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_scheduler/firebase_notification_scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/auth_cubit/auth_cubit.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-cubit.dart';
import 'package:untitled/bloc/home-layout-bloc.dart';
import 'package:untitled/bloc/home-page-bloc/test_cubit.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-cubit.dart';
import 'package:untitled/bloc/mission-category-bloc/mission-category-cubit.dart';
import 'package:untitled/bloc/network-cubit/network-cubit.dart';
import 'package:untitled/services/background-geolocation-service.dart';
import 'package:untitled/services/firebase-notifications-service.dart';
import 'package:untitled/services/notifications_service.dart';
import 'package:untitled/test-package/record-cubit.dart';
import 'package:untitled/ui-screens/login-screen.dart';
import 'package:workmanager/workmanager.dart';
import 'bloc/google-maps-cubit/google-maps-cubit.dart';
import 'bloc/notifications-bloc/notifications-cubit.dart';
import 'constants/Bloc_Observer.dart';
import 'constants/app-theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


void headlessTask(bg.HeadlessEvent headlessEvent) async {
  print('[BackgroundGeolocation HeadlessTask]: $headlessEvent');
  // Implement a 'case' for only those events you're interested in.
  switch(headlessEvent.name) {
    case bg.Event.TERMINATE:
      bg.State state = headlessEvent.event;
      print('- State: $state');
      break;
    case bg.Event.HEARTBEAT:
      bg.HeartbeatEvent event = headlessEvent.event;
      print('- HeartbeatEvent: $event');
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      print('- Location: $location');
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print('- Location: $location');
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print('- GeofenceEvent: $geofenceEvent');
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print('- GeofencesChangeEvent: $event');
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print('- State: $state');
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print('ActivityChangeEvent: $event');
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      print('HttpEvent: $response');
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      print('ProviderChangeEvent: $enabled');
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      print('ConnectivityChangeEvent: $event');
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print('EnabledChangeEvent: $enabled');
      break;
  }
}


Future<void> _backgroundHandler(RemoteMessage message) async {
  print('background messeage *8888888***************');
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task:"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
void main()async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( );
  await NotificationsService().initNotifications();

   FirebaseNotificationService().onInit();
   FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  BackgroundGeoLocationService().initState();


  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()..getDeviceToken()),
          BlocProvider(create: (context) => NetworkCubit()..onInit()),
          BlocProvider(create: (context) => HomeLayoutCubit()),
          BlocProvider(create: (context) => DailyMissionsCubit()..initDailyMissionsCubit()),
          BlocProvider(create: (context) => TestRecordCubit()..onInit()),
          BlocProvider(create: (context) => WeekdaysMissionsCubit()..onInit()),
          BlocProvider(create: (context) => MissionCategoryCubit()..onCategoryScreenLaunch()),
          BlocProvider(create: (context) => GoogleMapsCubit()..onInit()),
          BlocProvider(create: (context) => NotificationsCubit()..initNotifications()),],

        child: Material(
          child: NeumorphicApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home:const LoginScreen ()),
        ));
  }
}
// display audio in background
// on tap notification mission be doned ;