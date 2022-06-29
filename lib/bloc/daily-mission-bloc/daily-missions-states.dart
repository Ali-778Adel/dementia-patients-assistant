abstract class DailyMissionsStates{}
class DMInitState extends DailyMissionsStates{}
class DMDisposeState extends DailyMissionsStates{}
class GetWigetsState extends DailyMissionsStates{}
class OnSetTimeButtonTappedState extends DailyMissionsStates{}
class OnSetDateButtonTappedState extends DailyMissionsStates{}
class OnLocationButtonTappedState extends DailyMissionsStates{}
class OnBottomSheetDoneButtonTappedState extends DailyMissionsStates{}
class OnRepeatValueDetectedState extends DailyMissionsStates{
  String?repeatValue;
  OnRepeatValueDetectedState({this.repeatValue});
}
class UpdateMissionNoteController extends DailyMissionsStates{}
class AddMissionToDatabaseSuccessState extends DailyMissionsStates{}
class AddMissionToDatabaseFailureState extends DailyMissionsStates{}
class GetDataFromDatabaseState extends DailyMissionsStates{}
class UpdateDatabaseRowState extends DailyMissionsStates{}
class DeleteRowFromDatabaseState extends DailyMissionsStates{}
class GetDoneMissionsState extends DailyMissionsStates{}
class GetArchivedState extends DailyMissionsStates{}