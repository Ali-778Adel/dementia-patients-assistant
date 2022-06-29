import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-cubit.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-states.dart';
import 'package:untitled/components/neu-tadbar-container.dart';
import 'package:untitled/components/neu-text.dart';
class CustomYYRepeatDialogDialog extends StatelessWidget {
  const CustomYYRepeatDialogDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         PublicNeumorContainer(
           margin: const EdgeInsets.only(bottom: 20),
           height: 40,
           width:double.infinity ,
           child:const Center(
             child:  PublicNeumoText(
                text: 'Select Repeat method for this mission ',
               color: Colors.black,
               size: 16,
              ),
           ),
         ),
          Row(
            children: [
              Expanded(child:    RawMaterialButton(
                onPressed: () {
                  BlocProvider.of<DailyMissionsCubit>(context).repeatValue='daily';
                  BlocProvider.of<DailyMissionsCubit>(context).emit(OnRepeatValueDetectedState(repeatValue: 'daily'));
                  Navigator.pop(context);
                },
                elevation: 2.0,
                constraints:const BoxConstraints(minHeight: 60,maxWidth: 80),
                fillColor: Colors.white,
                child:const PublicNeumoText(
                  text: 'Daily',
                  size: 16,
                  color: Colors.black,
                ),
                padding:const EdgeInsets.all(5.0),
                shape:const CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid),
                ),
              )),
              Expanded(child:    RawMaterialButton(
                onPressed: () {
                  BlocProvider.of<DailyMissionsCubit>(context).repeatValue='weekly';
                  BlocProvider.of<DailyMissionsCubit>(context).emit(OnRepeatValueDetectedState(repeatValue: 'weakly'));
                  Navigator.pop(context);
                },
                elevation: 2.0,
                constraints:const BoxConstraints(minHeight: 60,maxWidth: 80),
                fillColor: Colors.white,
                child:const PublicNeumoText(
                  text: 'weekly',
                  size: 16,
                  color: Colors.black,
                ),
                padding:const EdgeInsets.all(5.0),
                shape:const CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid),
                ),
              )),
              Expanded(child:    RawMaterialButton(
                onPressed: () {
                  BlocProvider.of<DailyMissionsCubit>(context).repeatValue='monthly';
                  BlocProvider.of<DailyMissionsCubit>(context).emit(OnRepeatValueDetectedState(repeatValue: 'monthly'));
                  Navigator.pop(context);
                },
                elevation: 2.0,
                constraints:const BoxConstraints(minHeight: 60,maxWidth: 80),

                fillColor: Colors.white,
                child:const PublicNeumoText(
                  text: 'monthly',
                  size: 16,
                  color: Colors.black,
                ),
                padding:const EdgeInsets.all(5.0),
                shape:const CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid),
                ),
              )),
              Expanded(child:    RawMaterialButton(
                onPressed: () {
                  BlocProvider.of<DailyMissionsCubit>(context).repeatValue='yearly';
                  BlocProvider.of<DailyMissionsCubit>(context).emit(OnRepeatValueDetectedState(repeatValue: 'yearly'));
                  Navigator.pop(context);
                },
                elevation: 2.0,
                constraints:const BoxConstraints(minHeight: 60,maxWidth: 80),

                fillColor: Colors.white,
                child:const PublicNeumoText(
                  text: 'yearly',
                  size: 16,
                  color: Colors.black,
                ),
                padding:const EdgeInsets.all(5.0),
                shape:const CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid),
                ),
              )),

            ],
          )
        ],
      ),
    );
  }
}
