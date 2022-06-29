// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/ui-widgets/custom-app-bar.dart';
import 'package:untitled/ui-widgets/custom-darwer.dart';
import 'package:untitled/ui-widgets/custom_week-days-listview-item.dart';
import '../../components/neu-text.dart';
import '../../components/show_modal_bottomsheet.dart';
import '../../constants/weekdays-list.dart';
import '../../ui-widgets/custom-attachments-bottomsheet.dart';
import '../../ui-widgets/custom-week-days-bottomsheet.dart';

class WeekdaysMissionScreen extends StatelessWidget {
   WeekdaysMissionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(child: CustomNewAppBar(appBarTitle: 'Weekdays Missions',),preferredSize: Size(double.infinity,60),),
      drawer: Drawer(child:const CustomDrawer(),width: MediaQuery.of(context).size.width*.60,),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin:
            const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: const PublicNeumoText(
              text: 'Add Missions For Current Week',
              size: 18,
              color: Colors.teal,
              align: TextAlign.center,
            ),
          ),
          Flexible(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return  WeekdaysListviewItem(
                        weekdayName: daysOfWeek[index],
                        listTileIndex: index,
                        onListTileAddButtonTapped: () {
                          print(('index is $index'));
                          showBarModalBottomsheet(
                              context: context,
                              widget:CustomWeekdaysMissionsBottomSheet(
                                index: index,
                                headerText:daysOfWeek[index],
                                missionRecordUri: '.com',
                                onAddAttachmentsTapped: (){
                                  showCustomModalBottomsheet(
                                      context: context,
                                      widget:const   CustomAttachmentsBottomSheet()
                                  );
                                },
                                onDeleteButtonTapped: (){},

                              )


                          );
                        },
                      );

                    }),
              ))
        ],
      ) ,
    );
  }
}
