// ignore_for_file: file_names

import 'package:untitled/models/week-day-bottomsheet-model.dart';
import 'package:untitled/models/weekdays-missions-model.dart';
class WeekDayExpansionTileModel{
  String?title;
  Function()?onAddIconTapped;
  List<WeekDayMissionModel>?weekDayMissionModel;
  WeekdaysBottomSheetModel?weekdaysBottomSheetModel;
  WeekDayExpansionTileModel(
      {
         this.title,
         this.onAddIconTapped,
         this.weekDayMissionModel,
         this.weekdaysBottomSheetModel
      }
      );
  }