import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/google-maps-cubit/google-maps-cubit.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-cubit.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-states.dart';
import 'package:untitled/constants/weekdays-list.dart';
import 'package:untitled/test-package/record-cubit.dart';
import '../components/neu-icon.dart';
import '../components/neu-text.dart';
import '../components/show_modal_bottomsheet.dart';
import '../constants/constants.dart';
import '../models/database-model.dart';
import 'custom-attachments-bottomsheet.dart';
import 'custom-week-days-bottomsheet.dart';
import 'custom-week-days-missions-widget.dart';

class WeekdaysListviewItem extends StatelessWidget {
  final String? weekdayName;
  final int?listTileIndex;
  final Function()? onListTileAddButtonTapped;
  const WeekdaysListviewItem(
      {Key? key,
        this.weekdayName,
        this.listTileIndex,
        this.onListTileAddButtonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<WeekdaysMissionsCubit,WeekdaysMissionStates>(
      builder: (context, state) {
        WeekdaysMissionsCubit weekdaysMissionsCubit=WeekdaysMissionsCubit.get(context);
        return  ExpansionTile(
            key: ValueKey(weekdayName),
            tilePadding: const EdgeInsets.only(left: 1),
            leading: IconButton(
              key: ValueKey(weekdayName),
              color: Colors.black,
              alignment: Alignment.topLeft,
              icon: const PublicNeumoIcon(
                iconData: Icons.add,
                iconColor: onBoardingTextColor,
                size: 18,
              ),
              onPressed: (){
                weekdaysMissionsCubit.doneForEdit=false;
                weekdaysMissionsCubit.getWeekdaysMissionByWeekdaysName();
                  showBarModalBottomsheet(
                      context: context,
                      widget: BlocBuilder<TestRecordCubit,TestRecordStates>(
                        builder: (context, snapshot) {
                          return CustomWeekdaysMissionsBottomSheet(
                            index: listTileIndex,
                            headerText:daysOfWeek[listTileIndex!],
                            missionRecordUri: context.read<TestRecordCubit>().recordUri,
                            onAddAttachmentsTapped: (){
                              showCustomModalBottomsheet(
                                  context: context,
                                  widget:   CustomAttachmentsBottomSheet()
                              );
                            },
                            onDeleteButtonTapped: (){
                              weekdaysMissionsCubit.onDispose(context: context);
                            },

                          );
                        }
                      )
                  );
              },
            ),
            title: PublicNeumoText(
              text: weekdayName,
              size: 18,
              color: Colors.black,
              align: TextAlign.start,
            ),
            children: [
              if (weekdaysMissionsCubit.weekdaysMissionsList.isEmpty||weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]!.isEmpty)
                Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    child: Text.rich(TextSpan(
                        text: 'No tasks for ',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              text: weekdayName,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                          const TextSpan(
                            text: 'AddOneNow',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )
                        ]))),
              if (weekdaysMissionsCubit.weekdaysMissionsList.isNotEmpty)
                 BlocBuilder<WeekdaysMissionsCubit,WeekdaysMissionStates>(
                     builder: (context, state) {
                   return
                     ListView.builder(
                     shrinkWrap: true,
                       physics:const NeverScrollableScrollPhysics(),
                       itemCount: weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]!.length,
                       itemBuilder: (context,index){
                           return CustomWeekDaysMissionsWidgets1(
                      weekdaysMission: weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index],
                       onMissionTapped: (){
                        weekdaysMissionsCubit.doneForEdit=true;
                        BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem= weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionLocationName;
                        weekdaysMissionsCubit.missionNameController.text=weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionName??'no name for this mission ';
                        weekdaysMissionsCubit.missionNoteController.text=weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionDescription??'no description for this mission ';
                        weekdaysMissionsCubit.timeValue=weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionTime!=null?
                        (weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionTime):TimeOfDay.now().format(context).toString();
                         showBarModalBottomsheet(
                             context: context,
                             widget:CustomWeekdaysMissionsBottomSheet(
                               index:listTileIndex,
                               missionsListVewIndex: index,
                               missionId:weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].id!,
                               headerText:daysOfWeek[listTileIndex!],
                               missionRecordUri:weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].missionRecordPath?? 'com.example.aac',
                               onAddAttachmentsTapped: (){
                                 showCustomModalBottomsheet(
                                     context: context,
                                     widget:  const CustomAttachmentsBottomSheet()
                                 );
                               },
                               onDeleteButtonTapped: (){
                                weekdaysMissionsCubit.deleteMission(
                                  missionId: weekdaysMissionsCubit.weekdaysMissionsList[daysOfWeek[listTileIndex!]]![index].id,
                                  context: context
                                );
                               },
                             )
                         );
                       },
                     );
                   });
                 })
            ]);
      }
    );
  }
}

class WeekdaysListviewItem1 extends StatelessWidget {
  final String? weekdayName;
  final List<WeekdaysMission>? weekdayMissions;
  final List<Widget>?missionsList;
  final Function()? onListTileAddButtonTapped;
  final Function()? onMissionTapped;
  const WeekdaysListviewItem1(
      {Key? key,
      this.weekdayName,
      this.weekdayMissions,
        this.missionsList,
        this.onMissionTapped,
      this.onListTileAddButtonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        key: ValueKey(weekdayName),
        tilePadding: const EdgeInsets.only(left: 1),
        leading: IconButton(
          key: ValueKey(weekdayName),
          color: Colors.black,
          alignment: Alignment.topLeft,
          icon: const PublicNeumoIcon(
            iconData: Icons.add,
            iconColor: onBoardingTextColor,
            size: 18,
          ),
          onPressed: onListTileAddButtonTapped,
        ),
        title: PublicNeumoText(
          text: weekdayName,
          size: 18,
          color: Colors.black,
          align: TextAlign.start,
        ),
        children: [
          if (weekdayMissions!.isEmpty)
            Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: Text.rich(TextSpan(
                    text: 'No tasks for ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: weekdayName,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      const TextSpan(
                        text: 'AddOneNow',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )
                    ]))),
          if (weekdayMissions!.isNotEmpty)
            Column(
              children: missionsList!
            )
        ]);
  }
}
