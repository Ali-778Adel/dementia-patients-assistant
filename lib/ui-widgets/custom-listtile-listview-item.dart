import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/neu-text.dart';
import '../constants/constants.dart';
import '../models/week-days-missions-model.dart';
class CustomListTileListViewItem extends StatelessWidget{
  final WeekDaysMissionsModel ?weekDaysMissionsModel;
  const CustomListTileListViewItem({Key? key,this.weekDaysMissionsModel}) : super(key: key);

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
                    text:weekDaysMissionsModel!.missionName??'No text ',
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
                  text:weekDaysMissionsModel!.missionTime??'set Time'
                  ,size: 14,color: Colors.black54,)),
              ),

            ],
          ),

        ),
      ),
      onTap: weekDaysMissionsModel!.onMissionTapped,
    );
  }

}

class CustomListTileListViewItem1 extends StatelessWidget{
 final String?missionName;
 final String?missionTime;
 final Function()?onMissionTapped;
  const CustomListTileListViewItem1({Key? key,this.missionName,this.missionTime,this.onMissionTapped}) : super(key: key);

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
                    text:missionName??'No text ',
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
                  text:missionTime??'set Time'
                  ,size: 14,color: Colors.black54,)),
              ),

            ],
          ),

        ),
      ),
      onTap: onMissionTapped,
    );
  }

}