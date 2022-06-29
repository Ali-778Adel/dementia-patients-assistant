import 'package:untitled/models/week-days-missions-model.dart';

class WeekdaysListTileModel {
  String? weekdayName;
  List<WeekDaysMissionsModel>? weekDaysMissionsModel;
  Function()? onListTileAddButtonTapped;

  WeekdaysListTileModel(
      {this.weekdayName,
      this.weekDaysMissionsModel,
      this.onListTileAddButtonTapped});
}
