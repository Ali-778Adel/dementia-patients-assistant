// ignore_for_file: file_names

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/models/database-model.dart';
import 'package:untitled/models/weekdays-missions-model.dart';
import '../components/neu-text.dart';

class CustomWeekDaysMissionsWidgets extends StatelessWidget {
 final WeekDayMissionModel?weekDayMissionModel;
  const CustomWeekDaysMissionsWidgets({Key? key,required this.weekDayMissionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      // constraints: BoxConstraints(minHeight: 1000,minWidth:double.infinity,maxHeight: double.infinity),
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(7),
      color: baseColor,
      child: ClayContainer(
        depth: 10,
        width: MediaQuery.of(context).size.width * .99,
        color: baseColor,
        spread: 4,
        borderRadius: 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 7,
              child: Container(
                // width: MediaQuery.of(context).size.width*.75,
                margin: const EdgeInsets.only(left:5,right: 5),
                child:  PublicNeumoText(
                  text:weekDayMissionModel!.missionText??'No text ',
                  color: Colors.blue,
                  size: 20,
                  align: TextAlign.start,
                ),
              ),
            ),
          const  Spacer(),
           Container(
             margin: const EdgeInsets.all(10),
             padding: const EdgeInsets.all(5),
             height: 30,
             width: 80,
             decoration: BoxDecoration(
               color: baseColor,
               border: Border.all(color: Colors.black,width: 1),
               borderRadius:const BorderRadius.all(Radius.circular(12.5))
             ),
             child: Center(child:  PublicNeumoText(
               text:weekDayMissionModel!.missionTime??'12:30 Am'
               ,size: 14,color: Colors.black54,)),
           )
          ],
        ),

      ),
    );
  }
}
class CustomWeekDaysMissionsWidgets1 extends StatelessWidget {

  final WeekdaysMission? weekdaysMission;
  final Function()?onMissionTapped;
  const CustomWeekDaysMissionsWidgets1({Key? key,this.weekdaysMission,this.onMissionTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // height: 120,
        // constraints: BoxConstraints(minHeight: 1000,minWidth:double.infinity,maxHeight: double.infinity),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(7),
        color: baseColor,
        child: ClayContainer(
          depth: 10,
          width: MediaQuery.of(context).size.width * .99,
          color: baseColor,
          spread: 4,
          borderRadius: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 7,
                child: Container(
                  // width: MediaQuery.of(context).size.width*.75,
                  margin: const EdgeInsets.only(left:5,right: 5),
                  child:  PublicNeumoText(
                    text:weekdaysMission!.missionName??'No text ',
                    color: Colors.blue,
                    size: 20,
                    align: TextAlign.start,
                  ),
                ),
              ),
            const  Spacer(),
             Container(
               margin: const EdgeInsets.all(10),
               padding: const EdgeInsets.all(5),
               height: 30,
               width: 80,
               decoration: BoxDecoration(
                 color: baseColor,
                 border: Border.all(color: Colors.black,width: 1),
                 borderRadius:const BorderRadius.all(Radius.circular(12.5))
               ),
               child: Center(child:  PublicNeumoText(
                 text:'${weekdaysMission!.missionTime}'
                 ,size: 14,color: Colors.black54,)),
             )
            ],
          ),

        ),
      ),
      onTap: onMissionTapped,
    );
  }
}
