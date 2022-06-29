// ignore_for_file: file_names

class AllWeekDayMissionsContentModel{
  String?missionName;
  String?missionTime;
  String?missionDate;
  List<String>?missionGeolocation;
  String?missionNotes;
  List<dynamic>?missionAttachments;

  AllWeekDayMissionsContentModel({
    this.missionName,
    this.missionTime,
    this.missionGeolocation,
    this.missionNotes,
    this.missionAttachments
});
}