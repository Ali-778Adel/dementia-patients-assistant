import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-text.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/models/database-model.dart';

@immutable
class CustomArchivedMissionsViewItem  extends StatelessWidget {
  final  RepeatableMissionsTable missionViewModel;
  final Function()onMissionTapped;
  final Function()onLongPress;
  const CustomArchivedMissionsViewItem({Key? key,required this.missionViewModel,required this.onMissionTapped,required this.onLongPress}) : super(key: key);
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
          surfaceColor:Colors.grey,
          borderRadius: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Container(

                  margin: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: PublicNeumoText(
                    text: missionViewModel.missionName??'',
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
                        child: Center(child: Text(missionViewModel.missionTime??'SetTime',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                      )
                  ),
                  Expanded(child:   Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color:Colors.black,width: 1 )
                    ),
                    child: Center(child: Text(missionViewModel.missionDate??'Set Date',style:const TextStyle(color: Colors.black,fontSize: 18),)),
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
                    child: Center(child: Text(missionViewModel.missionRepeat??'Custom',style:const TextStyle(color: Colors.black,fontSize: 18),)),
                  ),),
                  Expanded( child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color:Colors.black,width: 1 )
                    ),
                    child: Center(child: Text(missionViewModel.missionLocationName??'at location',style:const TextStyle(color: Colors.black,fontSize: 18),)),
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