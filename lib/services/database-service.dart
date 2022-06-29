
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:untitled/models/database-model.dart';

//to rebuild database-model.gen
//flutter pub run build_runner build --delete-conflicting-outputs
@immutable
class DatabaseService {
 late final WeekdaysMission? weekdaysMission;
 late final RepeatableMissionsTable? repeatableMissionsTable;

  Future initDatabase() async {
    weekdaysMission = WeekdaysMission();
    repeatableMissionsTable = RepeatableMissionsTable();
  }

  //work with weekdays missions table
  Future addMissionToWeekdayMissionsTable({
    String?weekdayName,
    int?weekdayId,
    String? missionName,
    String? missionTime,
    String?locationId,
    String ?missionLocationName,
    String?missionLocationLat,
    String?missionLocationLng,
    String? missionDate,
    String? missionDescription,
    String? missionRecordPath,
  }) async {
    weekdaysMission!.weekdayName=weekdayName;
    weekdaysMission!.missionName = missionName;
    weekdaysMission!.missionTime = missionTime;
    weekdaysMission!.missionDate = missionDate;
    weekdaysMission!.missionLocationId = locationId;
    weekdaysMission!.missionLocationName=missionLocationName;
    weekdaysMission!.missionLocationLat=missionLocationLat;
    weekdaysMission!.missionLocationLng=missionLocationLng;
    weekdaysMission!.missionDescription = missionDescription;
    weekdaysMission!.missionRecordPath = missionRecordPath;
    await weekdaysMission!.save().catchError((error) {
      throw (Exception(
          'error on addMissionToWeekdayMissionsTable method  row from database ${error.toString()}'));
    });
  }


  Future<List<WeekdaysMission>> getMissionsFromWeekdaysMissionsTable() async {
   return await weekdaysMission!.select().toList().catchError((error) {
      throw (Exception(
          'error on getMissionsFromWeekdaysMissionsTable method  row from database ${error.toString()}'));
    });
  }



  Future updateWeekdaysMissionsQueries({
    int?missionId,
    String?missionName,
    String?missionTime,
    String?missionDescription,
    String?missionRecordPath,
    String?locationId,
    String?missionLocationName,
    String?missionLocationLat,
    String?missionLocationLng,

  })async{
    return await weekdaysMission!
        .select().id.equals(missionId)
        .update({
      'missionName':missionName,
      'missionTime':missionTime,
      'missionDescription':missionDescription,
      'missionRecordPath':missionRecordPath,
      'missionLocationId':locationId,
      'missionLocationLat':missionLocationLat,
      'missionLocationLng':missionLocationLng,
    }).catchError((error){
      throw(Exception('error on updating data base ${error.toString()}'));
    });
  }


  Future deleteMissionsFromWeekdaysMissionsTable({int?missionId}) async {
    await weekdaysMission!
        .select()
        .id
        .equals(missionId)
        .delete()
        .catchError((error) {
      throw (Exception(
          'error on delete row from database ${error.toString()}'));
    });
  }

//work with repeatable  missions table

  Future addMissionsToRepeatableMissionsTable({
    String ?missionName,
    String?missionTime,
    String? missionDate,
    String?missionRepeat,
    String?missionLocationName,
    String?missionLocationId,
    String?missionLocationLat,
    String?missionLocationLng,
    String?missionDescription,
    String?missionRecordUri
  })async{
     repeatableMissionsTable!.missionName=missionName;
     repeatableMissionsTable!.missionTime=missionTime;
     repeatableMissionsTable!.missionDate=missionDate;
     repeatableMissionsTable!.missionRepeat=missionRepeat;
     repeatableMissionsTable!.missionLocationName=missionLocationName;
     repeatableMissionsTable!.missionLocationId=missionLocationId;
     repeatableMissionsTable!.missionLocationLat=missionLocationLat;
     repeatableMissionsTable!.missionLocationLng=missionLocationLng;
     repeatableMissionsTable!.missionDescription=missionDescription;
     repeatableMissionsTable!.missionRecordPath=missionRecordUri;
     await repeatableMissionsTable!.save().catchError((error){
       throw("Error : can't insert mission in method addMissionsToRepeatableMissionsTable ${error.toString()}");
     });

  }

  Future<List<RepeatableMissionsTable>> getMissionsFromRepeatableMissionsTable()async{
    return await repeatableMissionsTable!.select().toList().catchError((error){
      throw("Error:can't get missions From method getMissions From getMissionsFromRepeatableMissionsTable ${error.toString()}");
    });
  }

  Future updateMissionsFromRepeatableMissionsTable({
    required int ?missionId,
    String ?missionName,
    String?missionTime,
    String?missionDate,
    String?missionRepeat,
    String?missionLocationName,
    String?missionLocationId,
    String?missionLocationLat,
    String?missionLocationLng,
    String?missionDescription,
    String?missionRecordUri,
    bool?completed,
    bool?archived,

  })async{
 return await repeatableMissionsTable!.select().repeatableMissionId.equals(missionId).update({
    'missionName':missionName,
    'missionTime':missionTime,
    'missionDate':missionDate,
    'missionRepeat':missionRepeat,
    'missionLocationName':missionLocationName,
    'missionLocationId':missionLocationId,
    'missionLocationLat':missionLocationLat,
    'missionLocationLng':missionLocationLng,
    'missionDescription':missionDescription,
    'missionRecordPath':missionRecordUri,
    'completed':completed,
    'archived':archived
  }
  ).catchError((error){
    throw("can't update row with id equals $missionId in method updateMissionsFromRepeatableMissionsTable ${error.toString()}");
  });
  }

  Future deleteMissionsFromRepeatableMissionsTable({required int missionId})async{
   return await repeatableMissionsTable!.select().repeatableMissionId.equals(missionId).delete()
        .catchError((error){
          throw("Error: can't delete row with id equal $missionId in method deleteMissionsFromRepeatableMissionsTable ${error.toString()}");
    });
  }

}
