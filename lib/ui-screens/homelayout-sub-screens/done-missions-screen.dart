import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-cubit.dart';
import 'package:untitled/ui-widgets/done-misions-view-item.dart';

import '../../bloc/daily-mission-bloc/daily-missions-states.dart';
import '../../components/neu-text.dart';
class DoneMissionScreen extends StatelessWidget {
  const DoneMissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyMissionCubit=DailyMissionsCubit.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(30),
        ),
        Flexible(
            fit: FlexFit.loose,
            child: BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                builder: (context, snapshot) {
                  if(context.read<DailyMissionsCubit>().doneMissions.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'no done missions yet',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.doneMissions.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          CustomDoneMissionsViewItem(
                            missionViewModel:dailyMissionCubit.doneMissions.elementAt(customMissionsIndex) ,
                            onLongPress: (){},
                            onMissionTapped: () {}
                          );

                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.teal,
                        thickness: 1.2,
                      ),
                    );

                  }



                })

        ),

      ],
    ) ;
  }
}
