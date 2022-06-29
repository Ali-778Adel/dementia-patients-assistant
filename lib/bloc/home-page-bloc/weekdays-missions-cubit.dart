// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-states.dart';
import 'package:untitled/services/database-service.dart';
import 'package:untitled/services/notifications_service.dart';
import 'package:workmanager/workmanager.dart';
import '../../constants/weekdays-list.dart';
import '../../models/database-model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart'as tz;

class WeekdaysMissionsCubit extends Cubit<WeekdaysMissionStates>{
  WeekdaysMissionsCubit():super(WMSIniState());
  static WeekdaysMissionsCubit get(context)=>BlocProvider.of(context);

  DatabaseService?databaseService;
  TextEditingController missionNameController=TextEditingController();
  TextEditingController missionNoteController=TextEditingController();
  String?timeValue;
  TimeOfDay?missionTime;
   ImagePicker?imagePicker;
   List<XFile>? images;
   bool doneForEdit=false;
   Map<String, List<WeekdaysMission>> weekdaysMissionsList = {};

  static const platform = MethodChannel('samples.flutter.dev/battery');


  onInit(){
      databaseService=DatabaseService();
      databaseService!.initDatabase();
      getWeekdaysMissionByWeekdaysName();
      databaseService!.getMissionsFromWeekdaysMissionsTable().then((value) {
        for(int i=0;i<value.length;i++){
          print('all database missions is ${value[i].toMap()}');
        }
      });
      showNotificationsByWeekdayName();


     emit(WMSIniState());

   }

  setMissionTime({required BuildContext context}){
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
      timeValue=value!.format(context).toString();
      missionTime=value;
      emit(OnSetTimeButtonTappedState());
    } );
  }

  setMissionLocation(){}

  setMissionDescription(){

  }

  setMissionImages(){}

  onDoneButtonTapped({
    int ?index,
    String? missionRecordPath,
    String?locationId,
    String?missionLocationName,
    String ?missionWeekdayName,
    String?missionLocationLat,
    String?missionLocationLng
  }){
    databaseService!.addMissionToWeekdayMissionsTable(
      weekdayName:daysOfWeek[index!] ,
      missionName: missionNameController.text,
      missionTime:timeValue,
      missionDate:missionWeekdayName,
      locationId: locationId,
      missionLocationName: missionLocationName,
      missionLocationLat: missionLocationLat,
      missionLocationLng: missionLocationLng,
      missionDescription: missionNoteController.text,
      missionRecordPath:missionRecordPath
    ).then((value) {
      getWeekdaysMissionByWeekdaysName();
      emit(SaveMissionState());
    });
  }

  getWeekdaysMissionByWeekdaysName()async{
     for(int i=0;i<7;i++){
       weekdaysMissionsList[daysOfWeek[i]]=await databaseService!
           .weekdaysMission!.select()
           .weekdayName.equals(daysOfWeek[i]).toList() ;
     }
    emit(GetWeekdaysMissionState());
  }

   showNotificationsByWeekdayName()async{
final List<WeekdaysMission>d=await databaseService!
        .weekdaysMission!
        .select()
        .missionDate
        .equals(daysOfWeek[0])
        .toList();
    for (int n=0;n<d.length;n++){
      print('its value ${d[n].toMap()}');
      DateTime taskTimeFormat =DateFormat.jm().parse(d[n].missionTime!);
      final taskTime=DateFormat('HH:mm').format(taskTimeFormat);
      NotificationsService().showScheduledNotifications(
          id:d[n].id! ,
          title: '',
          body: '${d[n].missionName}\n'
              'go \n'
              'next',
          hours: int.parse(taskTime.split(':')[0]),
          minutes:  int.parse(taskTime.split(':')[1]));
    }

  }

  static callDisPatcher(){
    Workmanager().executeTask((taskName, inputData)async{
      try{

        final List<WeekdaysMission>d=await DatabaseService()
            .weekdaysMission!
            .select()
            .missionDate
            .equals(daysOfWeek[0])
            .toList();
        for (int n=0;n<d.length;n++){
          print('its value ${d[n].toMap()}');
          DateTime taskTimeFormat =DateFormat.jm().parse(d[n].missionTime!);
          final taskTime=DateFormat('HH:mm').format(taskTimeFormat);
          NotificationsService().showScheduledNotifications(
              id:d[n].id! ,
              title: "it's time for this mission",
              body: '${d[n].missionName}\n'
                  'go \n'
                  'next',
              hours: int.parse(taskTime.split(':')[0]),
              minutes:  int.parse(taskTime.split(':')[1]));
        }
      }catch(e,s){
        throw('error on ork Manger ${e.toString()} ${s.toString()}');
      }
      return Future.value(true);

    });
  }

  updateWeekdaysMissionQueries({
    int?missionId,
    String?missionRecordPath,
    String?locationId,
    String?missionLocationName,
    String?missionLocationLat,
    String?missionLocationLng,
  }){
     databaseService!.updateWeekdaysMissionsQueries(
       missionId:missionId,
       missionName: missionNameController.text,
       missionDescription: missionNoteController.text,
       missionTime: timeValue??TimeOfDay.now().toString(),
       missionRecordPath: missionRecordPath,
       locationId: locationId,
       missionLocationName:missionLocationName,
       missionLocationLat: missionLocationLat,
       missionLocationLng: missionLocationLng
     ).then((value) {
       print('mission query updated =$value');
       getWeekdaysMissionByWeekdaysName();
       emit(UpdateWeekdaysMissionQueriesState());

     });
  }

  deleteMission({int?missionId,BuildContext ?context}){
    databaseService!.deleteMissionsFromWeekdaysMissionsTable(missionId: missionId);
      getWeekdaysMissionByWeekdaysName();
      onDispose(context: context);
      emit(DeleteMissionState());
   }

  onDispose({BuildContext ?context}){
    doneForEdit=false;
    timeValue='set Time';
    missionNameController.clear();
    missionNoteController.clear();
    databaseService=null;
    onInit();
    Navigator.pop(context!);
    emit(OnDisposeState());
  }

  String batteryLevel1 = 'Unknown battery level.';

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel',);
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
      batteryLevel1 = batteryLevel;
    print('())))))))))))))))))))))))))))))))))))))))))))))))) $batteryLevel');

    emit(GetBatteryleveState());
  }
}