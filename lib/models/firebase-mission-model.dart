import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMissionModel{
String?missionName;
String?missionTime;
String?missionDate;
String?missionDescription;
String?missionRepeat;
String?missionLocationId;
String?missionLocationName;
String?missionLocationLat;
String?missionLocationLng;

FirebaseMissionModel(
    {
      this.missionName,
      this.missionTime,
      this.missionDate,
      this.missionDescription,
      this.missionRepeat,
      this.missionLocationId,
      this.missionLocationName,
      this.missionLocationLat,
      this.missionLocationLng
});

FirebaseMissionModel.fromSnapshot(QueryDocumentSnapshot<Map<String,dynamic>>firebaseMissionData){
 missionName=firebaseMissionData['missionName'];
 missionTime=firebaseMissionData['missionTime'];
 missionDate=firebaseMissionData['missionDate'];
 missionRepeat=firebaseMissionData['missionRepeat'];
 missionDescription=firebaseMissionData['missionDescription'];
 missionLocationId=firebaseMissionData['missionLocationId'];
 missionLocationName=firebaseMissionData['missionLocationName'];
 missionLocationLat=firebaseMissionData['missionLocationLat'];
 missionLocationLng=firebaseMissionData['missionLocationLng'];
}
}