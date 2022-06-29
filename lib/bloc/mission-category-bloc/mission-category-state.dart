// ignore_for_file: file_names

abstract class MissionCategoryStates{}
class MCSInitState extends MissionCategoryStates{
  final Function()?function;
  MCSInitState({this.function});
}
class OnCategoryScreenLaunch extends MissionCategoryStates{}
class OnPlusItemTappedState extends MissionCategoryStates{}
