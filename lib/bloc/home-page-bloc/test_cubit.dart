//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:untitled/models/database-model.dart';
//
//
// class TestCubit extends Cubit<TestStates> {
//   TestCubit() : super(WDMSInitState());
//   static TestCubit get(context) => BlocProvider.of(context);
//   WeekdaysTable weekday = WeekdaysTable();
//   WeekdaysMission weekdaysMission = WeekdaysMission();
//   final ImagePicker picker = ImagePicker();
//   var missionNameController = TextEditingController();
//   var notesController = TextEditingController();
//   List<XFile>? images;
//   BuildContext? context;
//   Map<int, List<WeekdaysMission>> mwdms = {};
//
//   getWeekdayId(int? index) {
//     switch (daysOfWeek[index!]) {
//       case 'Saturday':
//         {
//           return 1;
//         }
//       case 'Sunday':
//         {
//           return 2;
//         }
//       case 'Monday':
//         {
//           return 3;
//         }
//       case 'Tuesday':
//         {
//           return 4;
//         }
//       case 'Wednesday':
//         {
//           return 5;
//         }
//       case 'Thursday':
//         {
//           return 6;
//         }
//       case 'Friday':
//         {
//           return 7;
//         }
//     }
//   }
//
//   List<String> getDaysOfWeek([String? locale]) {
//     final now = DateTime.now();
//     final firstDayOfWeek = now;
//     return List.generate(7, (index) => index)
//         .map((value) => DateFormat(DateFormat.WEEKDAY, locale)
//             .format(firstDayOfWeek.add(Duration(days: value))))
//         .toList();
//   }
//
//   List<String>? _daysOfWeek;
//   List<String> get daysOfWeek {
//     _daysOfWeek ??= getDaysOfWeek();
//     return _daysOfWeek!;
//   }
//
//   onOkTapped() {
//     print(notesController.text);
//     emit(OpenDatabaseState());
//   }
//
//   TimeOfDay? missionTime;
//   onSetTimeButtonTaped({required BuildContext context}) {
//     emit(OnSetTimeButtonTappedState());
//     showTimePicker(context: context, initialTime: TimeOfDay.now())
//         .then((value) {
//       missionTime = value;
//       print(missionTime);
//       emit(OnSetTimeButtonTappedState());
//     });
//     emit(OnSetTimeButtonTappedState());
//   }
//
//   onDoneButtonTapped({int? index,String? missionRecordPath}) {
//     addWeekdaysMissionsToDatabase(
//         weekDayId: getWeekdayId(index!),
//         missionName: missionNameController.text,
//         missionDate: daysOfWeek[index],
//         weekdayName: daysOfWeek[index],
//         missionTime: missionTime,
//         missionDescription: notesController.text,
//       missionRecordPath: missionRecordPath
//     );
//     loadDataFromDatabase();
//     emit(OnAddButtonTappedState());
//   }
//
//   onAddPhotoButtonTapped() async {
//     final imagesList = await picker.pickMultiImage();
//     images = imagesList;
//     print(images?[0].readAsBytes());
//     emit(OnAddPhotoButtonTappedStateState());
//   }
//
//
//
//   addWeekdaysMissionsToDatabase({
//     String? weekdayName,
//     String? missionName,
//     TimeOfDay? missionTime,
//     String? missionDate,
//     String? missionDescription,
//     String?missionRecordPath,
//     required int weekDayId,
//   }) async {
//     // weekdaysMission.weekdayId = weekDayId;
//     weekdaysMission.weekdayName = weekdayName;
//     weekdaysMission.missionName = missionName;
//     weekdaysMission.missionTime = missionTime.toString();
//     weekdaysMission.missionDescription = missionDescription;
//     weekdaysMission.missionRecordPath =missionRecordPath;
//     await weekdaysMission.save();
//     emit(InsertIntoDatabaseState());
//   }
//
//   addWeekdaysTableItems() async {
//     await WeekdaysTable.withFields('Saturday', false, false).save();
//     await WeekdaysTable.withFields('Sunday', false, false).save();
//     await WeekdaysTable.withFields('Monday', false, false).save();
//     await WeekdaysTable.withFields('Tuesday', false, false).save();
//     await WeekdaysTable.withFields('Wednesday', false, false).save();
//     await WeekdaysTable.withFields('Thursday', false, false).save();
//     await WeekdaysTable.withFields('friday', false, false).save();
//   }
//
//   loadDataFromDatabase() async {
//     final allWeekdaysMissions = await weekdaysMission.select().toList();
//     for (int i = 1; i < 8; i++) {
//       // mwdms[i] = await weekdaysMission.select().weekdayId.equals(i).toList();
//     }
//     for (int i = 0; i < allWeekdaysMissions.length; i++) {
//       print(allWeekdaysMissions[i].toMap());
//     }
//     final l = await weekday.select().toList();
//     for (int i = 0; i < l.length; i++) {
//       print(l[i].toMap());
//     }
//
//     emit(GetDataFromDatabaseCreateDatabaseState());
//   }
//
//   deleteMissionFromDatabase(int? missionId) async {
//     await weekdaysMission.select().id.equals(missionId).delete().then((value) {
//       loadDataFromDatabase();
//       emit(DeleteDataFromDatabaseState());
//     }).catchError((error) {
//       throw (Exception(
//           'error on delete row from database ${error.toString()}'));
//     });
//   }
//    editMissionsFromDatabase({int?missionId, required String missionName})async{
//     await weekdaysMission.select().id.equals(missionId).update({'missionName':missionName}).then((value){
//       loadDataFromDatabase();
//       emit(UpdateDataOnDatabaseState());
//     }).catchError((error) {
//       throw (Exception(
//           'error on update row from database ${error.toString()}'));
//     });
//   }
// }
//
// class TestStates {}
//
// class WDMSInitState extends TestStates {}
//
// class OnAddListTileButtonTappedState extends TestStates {}
//
// class OnSetTimeButtonTappedState extends TestStates {}
//
// class OnAddButtonTappedState extends TestStates {}
//
// class OnAddMissionButtonTappedState extends TestStates {}
//
// class OnModalBottomSheetDismissedState extends TestStates {}
//
// class OnAddPhotoButtonTappedStateState extends TestStates {}
//
// class CreateDatabaseState extends TestStates {}
//
// class OpenDatabaseState extends TestStates {}
//
// class InsertIntoDatabaseState extends TestStates {}
//
// class GetDataFromDatabaseCreateDatabaseState extends TestStates {}
//
// class DeleteDataFromDatabaseState extends TestStates {}
//
// class UpdateDataOnDatabaseState extends TestStates {}
//
