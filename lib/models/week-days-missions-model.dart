class WeekDaysMissionsModel {
  String? missionName;
  String? missionTime;
  String? missionDate;
  double? lat;
  double? lng;
  String? description;
  Function()?onMissionTapped;
  dynamic  Attachements;

  WeekDaysMissionsModel(
      {this.missionName,
      this.missionTime,
      this.missionDate,
      this.lat,
      this.lng,
      this.description,
      this.Attachements,
      this.onMissionTapped
      });
}
