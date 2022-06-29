import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_scheduler/firebase_notification_scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:untitled/bloc/google-maps-cubit/google-maps-cubit.dart';
import 'package:untitled/bloc/network-cubit/network-states.dart';
import 'package:untitled/services/firebase-notifications-service.dart';

import '../../models/firebase-mission-model.dart';
import '../daily-mission-bloc/daily-missions-cubit.dart';

class NetworkCubit extends Cubit<NetworkStates> {
  NetworkCubit() : super( NSInitState( ) );

 static NetworkCubit get(context) => BlocProvider.of( context );
 final FirebaseNotificationService firebaseNotificationService=FirebaseNotificationService();

 onInit(){
   getAllNotifications();
   getCurrentUserInfo();
   checkConnectivityState();
   refreshDeviceToken();
   firebaseNotificationService.onInit();
   emit(NSInitState());
 }

 refreshDeviceToken()async{
   await FirebaseMessaging.instance.getToken().then((value)async{
     await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'deviceToken':value});
   });
 }

  String?text;
 String? get getTextFieldErrorText{
  if(text== null){
   return "'can't be null";
   }
   else{
    if(text!.length!=11){
      return 'not valid number';
    }
   else if(errormsg !=''){
      return errormsg;
    }
     return null;


  }
 }

  ConnectivityResult? _connectivityResult;
   bool isConnected=false;
  Future<void> checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      isConnected=true;
    } else if (result == ConnectivityResult.mobile) {
      isConnected=true;
    } else {
      isConnected=false;
    }
    emit(CheckConnectivityStat());

  }

  String?userId;
  bool isFriendListEmpty = true;
  String errormsg='';
  var targetUserInfo;
 Future getTargetUserData({String?phoneNumber}) async {
    emit( GetUserByPhoneNumberLoadingState( ) );
    await FirebaseFirestore
        .instance
        .collection( 'users' )
        .where( 'userPhone', isEqualTo: '+2$phoneNumber' )
        .get().then( (value) async{
          if(value.docs.isEmpty){
            errormsg='there no user carry this number try again with correct number \n,or ask him to download "missionMan "';
            print ('there no user carry this number tyr again');
          }else{
            targetUserInfo=value.docs[0];
            await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'friends':value.docs[0]['userPhone'],
            }).then((val) async{
              errormsg='';
              await FirebaseFirestore.instance.collection('users').doc(value.docs[0]['userId'])
                  .update({
                'friends':FirebaseAuth.instance.currentUser!.phoneNumber,
              }).then((value) {
                errormsg='';

              });
            });

          }
          emit( GetUserByPhoneNumberSuccessState( ) );

    } ).catchError( (error) {
      print( 'error ${error.toString( )}' );
      emit( GetUserByPhoneNumberSuccessState( ) );
    } );
  }

  Map<String,dynamic> currentUserInfo={};
 var token;
  getCurrentUserInfo()async{
    emit(CheckUserCollaboratesLoadingState());
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth
        .instance
        .currentUser!
        .uid).get().then((snapshot)async{
          if(snapshot.data()!.isNotEmpty){
            currentUserInfo= snapshot.data()!;
            if(currentUserInfo['friends']!=null){
              await FirebaseFirestore.instance.collection('users')
                  .where('userPhone',isEqualTo: currentUserInfo['friends'])
                  .get().then((targetInfo)async{
                    targetUserInfo=targetInfo.docs;
                    print(' >>>>>>>>>>>>>>>>>>>>${targetUserInfo[0]['userEmail']}');
                    print(' >>>>>>>>>>>>>>>>>>>>${targetUserInfo[0]['deviceToken']}');
              });
            }
            print('user friends List is   ${currentUserInfo['friends']}');
            print('user friends List is   ${currentUserInfo['state']}');
            // getAllDataFromFireStore();
            getFirebaseStream();
            emit(CheckUserCollaboratesSuccessState());
          }else{
            print ('error on checkUserDataNap ');
            emit(CheckUserCollaboratesFailureState());
          }

    }).catchError((error){
      print('error on check if UserHave Collaborate method ${error.toString()}');
      emit(CheckUserCollaboratesFailureState());
    });
  }
var x;
    sendMissionsToDementian({
      String?targetUserId,
      DailyMissionsCubit?dailyMissionsCubit,
      GoogleMapsCubit?googleMapsCubit,

    }) async {
      emit( SendMissionsToFriendLoadingState( ) );
      await FirebaseFirestore.instance.collection('users').doc(targetUserId)
          .collection( 'missions' ).add( {
        'missionName': dailyMissionsCubit!.missionController!.text,
        'missionTime': dailyMissionsCubit.timeValue??'set Time',
        'missionDate': dailyMissionsCubit.dateValue??'set Date',
        'missionRepeat':dailyMissionsCubit.repeatValue??'custom',
        'missionDescription': 'des',
        'missionLocationName':googleMapsCubit!.searchResultSelectedItem??'set Location',
        'missionLocationId':googleMapsCubit.selectedPlaceId??'null',
        'missionLocationLat':googleMapsCubit.selectedLocationStatic !=null?googleMapsCubit.selectedLocationStatic!.geometry!.location!.lat:'null',
        'missionLocationLng':googleMapsCubit.selectedLocationStatic !=null?googleMapsCubit.selectedLocationStatic!.geometry!.location!.lng:'null',
        'missionRecordPath':'missionRecordPath',
        'archived':'archived',
        'completed':'completed',
        'network':true
      })
          .then( (value)async {
            await FirebaseFirestore.instance.collection('users').doc(getDataForWhom()).collection('missions')
                .doc(value.id).update({'docPath':'${value.id}'});
        FirebaseNotificationService().sendPushMessage('${currentUserInfo['userPhone'] } sent you mission right now ','sent missionTo you right now  '
            ,'${targetUserInfo[0]['deviceToken']}');
        pushScheduleNotifications();
            getFirebaseStream();
            emit( SendMissionsToFriendSuccessState( ) );
        // getAllDataFromFireStore();
      } ).catchError( (error) {
        print('error on sending data${error.toString()}');
        emit( SendMissionsToFriendFailureState( ) );
      } );
    }

    updateFireStoreDoc({
      DailyMissionsCubit?dailyMissionsCubit
      ,int?docPath,
      String?missionTime,
      String?missionDate,
      String?missionRepeat

    })async{
    emit(UpdateFireStoreMissionsLoadingState());
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(getDataForWhom())
        .collection('missions')
        .doc('$docPath').update({
      'missionName':dailyMissionsCubit!.missionController!.text,
      'missionTime':dailyMissionsCubit.timeValue??missionTime,
      'missionDate':dailyMissionsCubit.dateValue??missionDate,
      'missionRepeat':dailyMissionsCubit.repeatValue??missionRepeat,
    }).then((value) {
      getFirebaseStream();
      emit(UpdateFireStoreMissionsSuccessState());
    }).catchError((error){
      emit(UpdateFireStoreMissionsFailureState());
      throw(Exception('error on updating firestore docs method ${error.toString()}'));
    });
    }
    deleteDocFromFireStore(String docPath)async{
    emit(DeleteFireStoreMissionsLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(getDataForWhom()).collection('missions').doc(docPath).delete()
        .then((value){
          getFirebaseStream();
          emit(DeleteFireStoreMissionsSuccessState());
    }).catchError((error){
      emit(DeleteFireStoreMissionsFailureState());
      throw(Exception('error on deleting item from firestore doc${error.toString()}'));

    });
    }

    String getDataForWhom(){
    if(currentUserInfo.isNotEmpty){
      if(currentUserInfo['state']=='writer'){
        return FirebaseAuth.instance.currentUser!.uid;
      }else if(currentUserInfo['state']=='reader'){
        return targetUserInfo[0]['userId'];
      }
    }
    return 'null';
    }




  // final  StreamController<List<FirebaseMissionModel>>userStream=BehaviorSubject();
  final  StreamController<List<QueryDocumentSnapshot<Map<String,dynamic>>>>userStream1=BehaviorSubject();
   // List<FirebaseMissionModel> notes= <FirebaseMissionModel>[];
   List<QueryDocumentSnapshot<Map<String,dynamic>>>lists=<QueryDocumentSnapshot<Map<String,dynamic>>>[];

    Future getFirebaseStream()async{
      emit(GetFirebaseStreamLoadingState());
     var userQuery=  FirebaseFirestore.instance.collection('users').doc(getDataForWhom()).collection('missions');
     await userQuery.get().then((res) {
       print('docs for user query has got ');
       if(res.docs.isNotEmpty){
         print('getFirebaseStream${res.docs[0]['missionName']}');
         userQuery.snapshots().listen((data) {
           lists=data.docs;
             data.docChanges.forEach((element) {
               userStream1.sink.add(lists);
               print ('strean is active ');
               if(userStream1.hasListener){
                 print('it has listner ');
               }
               emit(GetFirebaseStreamSuccessState());
             });
         });
       }else{
         print('docs have no data');
       }
     }).catchError((e,s){
       emit(GetFirebaseStreamFailureState());
       throw(Exception(
         'error on getFirebaseStreamMethod $e\n'
             '$s'
       ));
     });
   }


  final FirebaseNotificationScheduler firebaseNotificationScheduler =
  FirebaseNotificationScheduler(
      authenticationKey: 'YjUxYjNiOWMtYmQxZS00ZDNlLWFiY2QtNjYzYzhkODcyMmQwOkNxbURwdDk2c2dETmNxY3IzdXR0cXpWQy41cmhERTY=' ,
      rapidApiKey:'ea927d26eamsh104898b06fb9afap155f76jsn9d9844299633'
  );
    pushScheduleNotifications()async{
     final String _payload = {
       "to": "${currentUserInfo['deviceToken']}",
       "notification": {
         "title": "Title of Your Notification",
         "body": "Body of Your Notification"
       },
       // "data": {"key_1": "gf", "key_2": "k"}
     }.toString();
     final DateTime _now = DateTime.now().toUtc();
     final DateTime _dateTimeInUtc = _now.add(const Duration(minutes: 1));

     await firebaseNotificationScheduler.scheduleNotification(
         payload: _payload, dateTimeInUtc: _dateTimeInUtc).then((value)async{
           print(value);


           print('notification will be sent after 1 minuter due to notification channel ');
     }).catchError((error){
       throw(Exception('error on send schedule notifiation ${error.toString()}'));
     });
   }
   getAllNotifications()async{
      await firebaseNotificationScheduler.getAllScheduledNotification().then((value) {
        print(value[1].toMap());
      }).catchError((error){
        print(error.toString());
      });
   }
  @override
  void dispose() {
  }
}