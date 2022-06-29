
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-states.dart';
import 'package:untitled/services/database-service.dart';

import '../../components/show_modal_bottomsheet.dart';
import '../../models/database-model.dart';
import '../../services/notifications_service.dart';
import '../../ui-screens/google-maps-screen.dart';
import '../../ui-screens/homelayout-sub-screens/daily-missions-screen.dart';
import '../google-maps-cubit/google-maps-cubit.dart';
import '../google-maps-cubit/google-maps-states.dart';
//solving missionLocation bug ;
//check all mission quality;
//work with whatsapp integration;


class DailyMissionsCubit extends Cubit<DailyMissionsStates> {
  DailyMissionsCubit() : super(DMInitState());
  static DailyMissionsCubit get(context) => BlocProvider.of(context);
  DatabaseService?databaseService;

  String ?repeatValue;
  String ?missionNotes;
  bool doneForEdit=false;


  List<RepeatableMissionsTable>customMissionsList=[];
  List<RepeatableMissionsTable>dailyMissionsList=[];
  List<RepeatableMissionsTable>weeklyMissionList=[];
  List<RepeatableMissionsTable>monthlyMissionsList=[];
  List<RepeatableMissionsTable>yearlyMissionsList=[];
  List<RepeatableMissionsTable>doneMissions=[];
  List<RepeatableMissionsTable>archivedMissions=[];
  TextEditingController? missionController=TextEditingController();



  initDailyMissionsCubit(){
    databaseService=DatabaseService();
    databaseService!.initDatabase();
    getDataFromDatabase();
    pushNotifications();
    getDoneMissions();
    getArchivedMissions();
    emit(DMInitState());
  }


  disposeDailyMissionsCubit(BuildContext context){
    missionController!.clear();
    databaseService=null;
    timeValue=null;
    dateValue=null;
    repeatValue=null;
    initDailyMissionsCubit();
    Navigator.pop(context);
    emit(DMDisposeState());
  }

  int index=0;
  List<Color>frameColor=[Colors.grey,Colors.grey,Colors.grey,Colors.grey,Colors.grey];
  getIndex(){
    switch(index){
      case 0:{
        frameColor[0]=Colors.teal;
        index=0;
      }break;
      case 1:{
        frameColor[1]=Colors.blue;
        index=1;
       }break;
      case 2:{
        frameColor[2]=Colors.orange;
        index=2;
      }break;
      case 3:{
        frameColor[3]=Colors.yellowAccent;
        index=3;
      }break;
      case 4:{
        frameColor[4]=Colors.red;
        index=4;
      }break;
    }
    emit(GetWigetsState());

  }


  String?timeValue;
  onsetTimeButtonTapped({required BuildContext context}) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
          timeValue=value!.format(context).toString();
      emit(OnSetTimeButtonTappedState());
    });
  }


  String? dateValue;
  onsetDateButtonTapped({required BuildContext context}) {
    showDatePicker(context: context,
        firstDate:DateTime.now() ,
        initialDate: DateTime.now(),
      lastDate: DateTime.parse('2032-12-01')
    )
        .then((value) {
          dateValue= DateFormat.yMMMd( ).format( value! );
      emit(OnSetDateButtonTappedState());
    });
  }

  onSetLocationTapped({
    required BuildContext context,
    required int index,
    required GoogleMapsCubit googleMapsCubit,
    required List wichListCheck
  }){
    if (customMissionsList[index].missionLocationId != 'null') {
      showMapModalBottomSheet(
          context: context,
          mapWidget: GoogleMapsScreen());

      googleMapsCubit
          .setSelectedLocation(
          wichListCheck[index]
          .missionLocationId!);
      googleMapsCubit.emit(SetSelectedLocationState());
      googleMapsCubit.selectedLocationStatic==null?  BlocProvider.of<GoogleMapsCubit>(context)
          .initCameraPositionTarget =
          LatLng(
            double.parse(wichListCheck[index].missionLocationLat!),
            double.parse(wichListCheck[index].missionLocationLng!),)
          :
      googleMapsCubit
          .initCameraPositionTarget =
          LatLng(
            googleMapsCubit.selectedLocationStatic!.geometry!.location!.lat!,
            googleMapsCubit.selectedLocationStatic!.geometry!.location!.lng!,
          );
      if(googleMapsCubit.searchResultSelectedItem==null){
        googleMapsCubit.goToMissionPlace();
      }
      googleMapsCubit.addPolyLine();
    }
    else{
       print('i am in else condition ');
      showMapModalBottomSheet(
          context: context,
          mapWidget: GoogleMapsScreen());
    }
    emit(OnLocationButtonTappedState());

  }
  onSetLocationTappedForNetwork({
    required BuildContext context,
    required int index,
    required GoogleMapsCubit googleMapsCubit,
    required List wichListCheck,
    required bool checkCondition,
  }){
    if (checkCondition) {
      showMapModalBottomSheet(
          context: context,
          mapWidget: GoogleMapsScreen());

      googleMapsCubit
          .setSelectedLocation(
          wichListCheck[index]
              .missionLocationId!);
      googleMapsCubit.emit(SetSelectedLocationState());
      googleMapsCubit.selectedLocationStatic==null?  BlocProvider.of<GoogleMapsCubit>(context)
          .initCameraPositionTarget =
          LatLng(
            double.parse(wichListCheck[index].missionLocationLat!),
            double.parse(wichListCheck[index].missionLocationLng!),)
          :
      googleMapsCubit
          .initCameraPositionTarget =
          LatLng(
            googleMapsCubit.selectedLocationStatic!.geometry!.location!.lat!,
            googleMapsCubit.selectedLocationStatic!.geometry!.location!.lng!,
          );
      if(googleMapsCubit.searchResultSelectedItem==null){
        googleMapsCubit.goToMissionPlace();
      }
      googleMapsCubit.addPolyLine();
    }
    else{
      print('i am in else condition ');
      showMapModalBottomSheet(
          context: context,
          mapWidget: GoogleMapsScreen());
    }
    emit(OnLocationButtonTappedState());

  }


  insertDatabaseMissions({
    String?missionLocationName,
    String?missionLocationLat,
    String?missionLocationLng,
    String?missionLocationId,
    String?missionRecordUri,

  }){
   databaseService!.addMissionsToRepeatableMissionsTable(
     missionName: missionController!.text,
     missionTime: timeValue,
     missionDate:dateValue,
     missionRepeat: repeatValue??'custom',
     missionLocationName: missionLocationName,
     missionLocationLat: missionLocationLat??'null',
     missionLocationLng: missionLocationLng??'null',
     missionLocationId:missionLocationId??'null',
     missionRecordUri: missionRecordUri??'null'
   ).then((value) {
    getDataFromDatabase();
    print('data added successfully to data base ');
    emit(AddMissionToDatabaseSuccessState());
   }).catchError((error){
     emit(AddMissionToDatabaseFailureState());
     throw(Exception('error on iserting data into data base ${error.toString()}'));
   });
  }


  getDataFromDatabase()async{
    customMissionsList=await databaseService!.repeatableMissionsTable!
       .select().missionRepeat
       .equals('custom').toList();
    // for(int i=0;i<customMissionsList.length;i++){
    //   print('custom misions is ${customMissionsList.elementAt(i).toMap()}');
    // }
    dailyMissionsList=await databaseService!.repeatableMissionsTable!
        .select().missionRepeat
        .equals('daily').toList();
    // for(int i=0;i<dailyMissionsList.length;i++){
    //   print('daily misions is ${dailyMissionsList.elementAt(i).toMap()}');
    // }
    weeklyMissionList=await databaseService!.repeatableMissionsTable!
        .select().missionRepeat
        .equals('weekly').toList();
    // for(int i=0;i<weeklyMissionList.length;i++){
    //   print('custom misions is ${weeklyMissionList.elementAt(i).toMap()}');
    // }
    monthlyMissionsList=await databaseService!.repeatableMissionsTable!
        .select().missionRepeat
        .equals('monthly').toList();
    // for(int i=0;i<monthlyMissionsList.length;i++){
    //   print('custom misions is ${monthlyMissionsList.elementAt(i).toMap()}');
    // }
    yearlyMissionsList=await databaseService!.repeatableMissionsTable!
        .select().missionRepeat
        .equals('yearly').toList();
    // for(int i=0;i<yearlyMissionsList.length;i++){
    //   print('custom misions is ${yearlyMissionsList.elementAt(i).toMap()}');
    // }

    emit(GetDataFromDatabaseState());
  }


  updateDataFromDatabase({
   required int ?missionId,
    String?missionName,
    String?missionTime,
    String?missionDate,
    String?missionRepeat,
    String?missionLocationName,
    String?missionDescription,
    String?missionLocationId,
    String?missionLocationLat,
    String?missionLocationLng,
    String?missionRecordPath,
    bool?completed,
    bool?archived,
  }){
   databaseService!.updateMissionsFromRepeatableMissionsTable(
       missionId:missionId,
       missionName: missionName,
       missionTime: missionTime,
       missionDate: missionDate,
       missionRepeat: missionRepeat,
       missionLocationName: missionLocationName,
       missionDescription: missionDescription,
       missionLocationLng: missionLocationLng,
       missionLocationLat: missionLocationLat,
       missionLocationId: missionLocationId,
       missionRecordUri: missionRecordPath,
       completed: completed,
       archived: archived
   ).then((value) {
     print('mission update info $value');
     getDataFromDatabase();
   }).catchError((error){
     print(error.toString());
   });
   emit(UpdateDatabaseRowState());
  }


  deleteDataFromDatabase({required int missionId,BuildContext? context}){
    databaseService!.deleteMissionsFromRepeatableMissionsTable(missionId: missionId);
      getDataFromDatabase();
      disposeDailyMissionsCubit(context!);
      emit(DeleteRowFromDatabaseState());
  }

  getDoneMissions()async{
  doneMissions= await databaseService!.repeatableMissionsTable!.select().missionRepeat.equals('done').toList();
  for (int i=0;i<doneMissions.length;i++){
    print('done missions is ${doneMissions[i].toMap()}');
  }
  emit(GetDoneMissionsState());
    // doneMissions.add(databaseService!.repeatableMissionsTable.select().repeatableMissionId.equals(id));
  }

  getArchivedMissions()async{
    archivedMissions= await databaseService!.repeatableMissionsTable!.select().missionRepeat.equals('archived').toList();
    for (int i=0;i<archivedMissions.length;i++){
      print('archived missions is ${doneMissions[i].toMap()}');
    }
    emit(GetArchivedState());

  }

  addMissionToDoneMissionsList({int ?id,required itemIndex,required List<RepeatableMissionsTable>wichList }){
   updateDataFromDatabase(
     missionId: wichList[itemIndex].repeatableMissionId,
       missionName: wichList[itemIndex].missionName,
       missionTime:  wichList[itemIndex].missionTime??'Set Time',
       missionDate : wichList[itemIndex].missionDate??'Set Date ',
       missionRepeat:'done',
       missionLocationName:wichList[itemIndex].missionLocationName,
       missionRecordPath: wichList[itemIndex].missionRecordPath,
       missionLocationId: wichList[itemIndex].missionLocationId,
       missionLocationLat: wichList[itemIndex].missionLocationLat,
       missionLocationLng: wichList[itemIndex].missionLocationLng ,
       missionDescription: '',
       completed: true
   );
   getDoneMissions();
   emit(UpdateDatabaseRowState());
  }

  addMissionToArchivedMissionsList({required itemIndex,required List<RepeatableMissionsTable>wichList }){
    updateDataFromDatabase(
        missionId: wichList[itemIndex].repeatableMissionId,
        missionName: wichList[itemIndex].missionName??'',
        missionTime:  wichList[itemIndex].missionTime??'Set Time',
        missionDate : wichList[itemIndex].missionDate??'Set Date ',
        missionRepeat:'archived',
        missionLocationName:wichList[itemIndex].missionLocationName,
        missionRecordPath: wichList[itemIndex].missionRecordPath,
        missionLocationId: wichList[itemIndex].missionLocationId,
        missionLocationLat: wichList[itemIndex].missionLocationLat,
        missionLocationLng: wichList[itemIndex].missionLocationLng ,
        missionDescription: '',
        completed: wichList[itemIndex].completed,
        archived: true
    );
    getArchivedMissions();
    emit(UpdateDatabaseRowState());
  }

  pushNotifications() async{
    // final now=DateTime.now().toString();
    final format=DateFormat.yMMMd().format(DateTime.now());
    print('Date Time now is >>>>>>>>>>>$format');
    List<RepeatableMissionsTable>notificationList=await databaseService!
        .repeatableMissionsTable!
        .select().missionDate.equals(format).toList();
    for(int i=0;i<notificationList.length;i++){
      DateTime taskTimeFormat =DateFormat.jm().parse(notificationList[i].missionTime!);
      final taskTime=DateFormat('HH:mm').format(taskTimeFormat);
      NotificationsService().showScheduledNotifications(
          id:notificationList[i].repeatableMissionId! ,
          title: '',
          body: '${notificationList[i].missionName}  \n'
              '${notificationList[i].missionTime}  \n'
              'at ${(notificationList[i].missionLocationName)??'no location '}',
          hours: int.parse(taskTime.split(':')[0]),
          minutes:  int.parse(taskTime.split(':')[1]));
    }
  }




}
