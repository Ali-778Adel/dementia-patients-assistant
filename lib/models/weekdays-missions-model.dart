class WeekDayMissionModel{
  String?missionText;
  String?missionTime;
  String?missionDate;
  String?missionNotes;
  String? missionAttachements;
  TargetLocationData?targetLocationData;

  WeekDayMissionModel(
  {this.missionText, this.missionTime, this.missionDate,
      this.missionNotes, this.missionAttachements, this.targetLocationData});
}
class TargetLocationData{
  String?locationName;
  double?locationLatLng;
  TargetLocationData({this.locationName,this.locationLatLng});
}