import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../components/neu-text.dart';
import '../constants/constants.dart';
import '../models/database-model.dart';

class NetworkMissionViewItem extends StatelessWidget {
Color getColorStatus(){
  Color?color;
  switch(missionRepeat){
    case 'custom':{
      color= Colors.tealAccent;
    }break;
    case'daily':{
      color= Colors.blue;
    }break;
    case 'weekly':{
      color=Colors.orange;
    }break;
    case 'monthly':{
      color =Colors.yellowAccent;
    }break;
    case 'yearly':{
      color=Colors.red;
    }
  }

  return color!;
}
final String?missionName;
final String?missionTime;
final String?missionDate;
final String?missionRepeat;
final String?missionLocationName;
final Function()onMissionTapped;
final Function()onLongPress;
const NetworkMissionViewItem({Key? key,this.missionName,this.missionDate,this.missionTime,this.missionRepeat,this.missionLocationName,required this.onMissionTapped,required this.onLongPress}) : super(key: key);
@override
Widget build(BuildContext context) {
  return Container(
    height: 200,
    color: baseColor,
    margin: const EdgeInsets.only(top: 20,bottom: 20,right: 10,left: 10),
    child: InkWell(
      child: ClayContainer(
        depth: 60,
        width: MediaQuery.of(context).size.width*90,
        color: baseColor,
        spread: 4,
        curveType: CurveType.convex,
        surfaceColor:getColorStatus(),
        borderRadius: 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(

                margin: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                child: PublicNeumoText(
                  text: missionName,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                      decoration: BoxDecoration(
                          borderRadius:const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color:Colors.black,width: 1 )
                      ),
                      child: Center(child: Text(missionTime??'SetTime',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                    )
                ),
                Expanded(child:   Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color:Colors.black,width: 1 )
                  ),
                  child: Center(child: Text(missionDate??'Set Date',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                ),),
              ],
            ),
            const SizedBox(
              height: 5,

            ),
            Row(
              children: [
                Expanded( child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color:Colors.black,width: 1 )
                  ),
                  child: Center(child: Text(missionRepeat??'Custom',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                ),),
                Expanded( child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color:Colors.black,width: 1 )
                  ),
                  child: Center(child: Text(missionLocationName??'at location',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                ),),
              ],
            ),

          ],
        ),
      ),
      onTap: onMissionTapped,
      onLongPress:onLongPress,
    ),
  );
}
}

