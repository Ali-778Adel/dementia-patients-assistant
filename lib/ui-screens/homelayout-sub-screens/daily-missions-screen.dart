import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-cubit.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-states.dart';
import 'package:untitled/bloc/google-maps-cubit/google-maps-cubit.dart';
import 'package:untitled/components/neu-button.dart';
import 'package:untitled/components/neu-text.dart';
import 'package:untitled/test-package/record-cubit.dart';
import 'package:untitled/ui-widgets/custom-app-bar.dart';
import 'package:untitled/ui-widgets/custom-daily-mission-view-item.dart';
import 'package:untitled/ui-widgets/custom-darwer.dart';
import 'package:untitled/ui-widgets/daily-mission-bottomsheet.dart';
import '../../components/mission-add-notes-dialog.dart';
import '../../components/show_modal_bottomsheet.dart';
import '../google-maps-screen.dart';

class DailyMissionScreen extends StatelessWidget {
 const DailyMissionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
return Scaffold(
appBar: const PreferredSize(child:CustomNewAppBar(appBarTitle: 'Custom Missions',),preferredSize: Size(double.infinity,60),),
drawer: Drawer(child:const CustomDrawer(),width: MediaQuery.of(context).size.width *.60,),
  body: Container(
    margin: const EdgeInsets.only(top:10),
    child: Stack(
      children: [
        BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
            builder: (context, snapshot) {
              return IndexedStack(
                children:const [
                  CustomMissionsView(),
                  DailyMissionsView(),
                  WeaklyDailyMissionsView(),
                  MonthlyMissionsView(),
                  YearlyMissionsView()
                ],
                index: BlocProvider.of<DailyMissionsCubit>(context).index,
              );
            }
        ),
        Positioned(
            top: 5,
            left: 5,
            right: 5,

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics:const BouncingScrollPhysics(),
              child: BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        CustomBottomSheetButton(text: 'custom mission',textColor:context.read<DailyMissionsCubit>().frameColor[0]
                            ,borderColor:context.read<DailyMissionsCubit>().frameColor[0],function: (){
                              context.read<DailyMissionsCubit>().index=0;
                              context.read<DailyMissionsCubit>().frameColor[0]=Colors.teal;
                              context.read<DailyMissionsCubit>().frameColor[1]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[2]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[3]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[4]=Colors.grey;
                              context.read<DailyMissionsCubit>().emit(GetWigetsState());
                            }),
                        CustomBottomSheetButton(text: 'Daily mission',textColor:context.read<DailyMissionsCubit>().frameColor[1]
                            ,borderColor:context.read<DailyMissionsCubit>().frameColor[1],function: (){
                              context.read<DailyMissionsCubit>().index=1;
                              context.read<DailyMissionsCubit>().frameColor[1]=Colors.blue;
                              context.read<DailyMissionsCubit>().frameColor[0]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[2]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[3]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[4]=Colors.grey;
                              context.read<DailyMissionsCubit>().emit(GetWigetsState());
                            }),
                        CustomBottomSheetButton(text: 'Weekly mission',textColor:context.read<DailyMissionsCubit>().frameColor[2]
                            ,borderColor:context.read<DailyMissionsCubit>().frameColor[2],function: (){
                              context.read<DailyMissionsCubit>().index=2;
                              context.read<DailyMissionsCubit>().frameColor[1]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[0]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[2]=Colors.orange;
                              context.read<DailyMissionsCubit>().frameColor[3]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[4]=Colors.grey;
                              context.read<DailyMissionsCubit>().emit(GetWigetsState());
                            }),
                        CustomBottomSheetButton(text: 'Monthly mission',textColor:context.read<DailyMissionsCubit>().frameColor[3]
                            ,borderColor:context.read<DailyMissionsCubit>().frameColor[3],function: (){
                              context.read<DailyMissionsCubit>().index=3;
                              context.read<DailyMissionsCubit>().frameColor[1]=Colors.blue;
                              context.read<DailyMissionsCubit>().frameColor[0]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[2]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[3]=Colors.yellowAccent;
                              context.read<DailyMissionsCubit>().frameColor[4]=Colors.grey;
                              context.read<DailyMissionsCubit>().emit(GetWigetsState());
                            }),
                        CustomBottomSheetButton(text: 'Yearly mission',textColor:context.read<DailyMissionsCubit>().frameColor[4]
                            ,borderColor:context.read<DailyMissionsCubit>().frameColor[4],function: (){
                              context.read<DailyMissionsCubit>().index=4;
                              context.read<DailyMissionsCubit>().frameColor[1]=Colors.blue;
                              context.read<DailyMissionsCubit>().frameColor[0]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[2]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[3]=Colors.grey;
                              context.read<DailyMissionsCubit>().frameColor[4]=Colors.red;
                              context.read<DailyMissionsCubit>().emit(GetWigetsState());
                            }),

                      ],
                    );
                  }
              ),
            )
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child:
          CustomNewMissionButton(
            width: MediaQuery.of(context).size.width*.60,
            text: 'Add new mission',
            iconData:Icons.add ,
            function: (){
              showBarModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  context: context,
                  builder: (context) {
                    return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                        builder: (context, snapshot) {
                          var dailyMissionsCubit=DailyMissionsCubit.get(context);
                          return DailyMissionBottomSheet(
                            missionController:dailyMissionsCubit.missionController!,
                            onSelectingTime:(){
                              dailyMissionsCubit.onsetTimeButtonTapped(context: context);
                            } ,
                            timeValue:dailyMissionsCubit.timeValue??'Set Time',
                            onSelectingDate: (){
                              dailyMissionsCubit.onsetDateButtonTapped(context: context);
                            },
                            doneForEdit: false,
                            missionRecordUri: BlocProvider.of<TestRecordCubit>(context).recordUri,
                            dateValue: dailyMissionsCubit.dateValue??'Set Date',
                            repeatValue: dailyMissionsCubit.repeatValue??'Repeat',
                            locationName:BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??'At Location',
                            onDeleteMission: (){
                              dailyMissionsCubit.disposeDailyMissionsCubit(context);
                            },
                            onSelectingLocation: (){
                              showMapModalBottomSheet(
                                  context: context,
                                  mapWidget: GoogleMapsScreen());
                            },
                            onDoneTappedFunction: (){
                              if(dailyMissionsCubit.timeValue==null||dailyMissionsCubit.dateValue==null){
                                customMissionAlertDialog(
                                    context: context,
                                    alertText: 'Please set up date and time ',
                                    onOkTapped: (){},
                                    onCancelTapped: (){}
                                );
                              }else{
                                dailyMissionsCubit.insertDatabaseMissions(
                                  missionRecordUri:BlocProvider.of<TestRecordCubit>(context).recordUri,
                                  missionLocationName:BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??'null',
                                  missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId??'null',
                                  missionLocationLng:BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic !=null
                                      ?
                                  '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng!}':'null',
                                  missionLocationLat:BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic !=null
                                      ?
                                  '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}':'null',
                                );
                                BlocProvider.of<TestRecordCubit>(context).recordUri='com.example.aac';
                                dailyMissionsCubit.disposeDailyMissionsCubit(context);
                                BlocProvider.of<GoogleMapsCubit>(context).onDispose();
                                BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic=null;
                                BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId=null;
                                BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem=null;



                              }

                            },

                          );
                        }
                    );

                  });
            },
          ),
        )
      ],
    ),
  ),
);

  }
}
@immutable
class CustomMissionsView extends StatelessWidget {
  const CustomMissionsView({Key? key}) : super(key: key);
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
                  if(context.read<DailyMissionsCubit>().customMissionsList.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'No custom missions Add one',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.customMissionsList.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          Stack(
                            children: [
                              CustomDailyMissionViewItem(
                                missionViewModel:dailyMissionCubit.customMissionsList[customMissionsIndex] ,
                                onLongPress: (){
                                  customMissionControlDialog(context: context,
                                      onArchiveTapped: (){
                                        dailyMissionCubit.addMissionToArchivedMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                        Navigator.pop(context);
                                      },onDoneTapped: (){
                                    dailyMissionCubit.addMissionToDoneMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);

                                      });
                                },
                                onMissionTapped: (){
                                  dailyMissionCubit.doneForEdit=true;
                                  dailyMissionCubit.missionController!.text
                                  =dailyMissionCubit.customMissionsList[customMissionsIndex].missionName!;
                                  showBarModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      context: context,
                                      builder: (context){
                                        return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                            builder: (context, snapshot) {
                                              return DailyMissionBottomSheet(
                                                  missionController: dailyMissionCubit.missionController,
                                                  timeValue:context.read<DailyMissionsCubit>().timeValue?? dailyMissionCubit.customMissionsList[customMissionsIndex].missionTime,
                                                  dateValue: dailyMissionCubit.dateValue?? dailyMissionCubit.customMissionsList[customMissionsIndex].missionDate,
                                                  repeatValue: dailyMissionCubit.repeatValue?? dailyMissionCubit.customMissionsList[customMissionsIndex].missionRepeat??'custom',
                                                  locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.customMissionsList[customMissionsIndex].missionLocationName??'At Location',
                                                  doneForEdit: true,
                                                  onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                                  missionRecordUri: dailyMissionCubit.customMissionsList[customMissionsIndex].missionRecordPath!,
                                                  onSelectingLocation: (){
                                                    context.read<DailyMissionsCubit>().onSetLocationTapped(
                                                        context: context,
                                                        index: customMissionsIndex,
                                                        googleMapsCubit:BlocProvider.of<GoogleMapsCubit>(context),
                                                        wichListCheck: context.read<DailyMissionsCubit>().customMissionsList
                                                    );

                                                  },
                                                  onSelectingTime: (){
                                                    dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                                  },
                                                  onDeleteMission: (){
                                                    dailyMissionCubit.deleteDataFromDatabase(
                                                        missionId: dailyMissionCubit.customMissionsList[customMissionsIndex].repeatableMissionId!,
                                                        context: context
                                                    );
                                                  },
                                                  onDoneTappedFunction: (){
                                                    dailyMissionCubit.updateDataFromDatabase
                                                      (
                                                        missionId:dailyMissionCubit.customMissionsList[customMissionsIndex].repeatableMissionId,
                                                        missionName: dailyMissionCubit.missionController!.text,
                                                        missionTime:  dailyMissionCubit.timeValue??dailyMissionCubit.customMissionsList[customMissionsIndex].missionTime??'Set Time',
                                                        missionDate : dailyMissionCubit.timeValue??dailyMissionCubit.customMissionsList[customMissionsIndex].missionDate??'Set Date ',
                                                        missionRepeat:dailyMissionCubit.repeatValue?? dailyMissionCubit.repeatValue??'custom',
                                                        missionLocationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.customMissionsList[customMissionsIndex].missionLocationName,
                                                        missionRecordPath: BlocProvider.of<TestRecordCubit>(context).recordUri,
                                                        missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId,
                                                        missionLocationLat:BlocProvider.of<GoogleMapsCubit>(context)
                                                            .selectedLocationStatic !=
                                                            null
                                                            ? '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat}'
                                                            : dailyMissionCubit.customMissionsList[customMissionsIndex].missionLocationLat??'',
                                                        missionLocationLng: BlocProvider.of<GoogleMapsCubit>(context)
                                                            .selectedLocationStatic !=
                                                            null
                                                            ? '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng}'
                                                            :  dailyMissionCubit.customMissionsList[customMissionsIndex].missionLocationLng??'',
                                                        missionDescription: ''
                                                    );
                                                    Navigator.pop(context);
                                                    // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                                  });
                                            }
                                        );
                                      });
                                },
                              ),
                            ],
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

@immutable
class DailyMissionsView extends StatelessWidget {
  const DailyMissionsView({Key? key}) : super(key: key);
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
                  if(context.read<DailyMissionsCubit>().dailyMissionsList.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'no daily missions Add one',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.dailyMissionsList.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          CustomDailyMissionViewItem(
                            missionViewModel:dailyMissionCubit.dailyMissionsList.elementAt(customMissionsIndex) ,
                            onLongPress: (){
                              customMissionControlDialog(context: context,
                                  onArchiveTapped: (){
                                    dailyMissionCubit.addMissionToArchivedMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);
                                  },onDoneTapped: (){
                                    dailyMissionCubit.addMissionToDoneMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);

                                  });
                            },
                            onMissionTapped: (){
                              dailyMissionCubit.doneForEdit=true;
                              dailyMissionCubit.missionController!.text
                              =dailyMissionCubit.dailyMissionsList.elementAt(customMissionsIndex).missionName!;
                              showBarModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  context: context,
                                  builder: (context){
                                    return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                        builder: (context, snapshot) {
                                          return DailyMissionBottomSheet(
                                              missionController: dailyMissionCubit.missionController,
                                              timeValue:context.read<DailyMissionsCubit>().timeValue?? dailyMissionCubit.dailyMissionsList.elementAt(customMissionsIndex).missionTime,
                                              dateValue: dailyMissionCubit.dateValue?? dailyMissionCubit.dailyMissionsList.elementAt(customMissionsIndex).missionDate,
                                              repeatValue:  dailyMissionCubit.dailyMissionsList.elementAt(customMissionsIndex).missionRepeat??'custom',
                                              doneForEdit:true,
                                              locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionLocationName??'At Location',
                                              onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                              missionRecordUri: dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionRecordPath!,
                                              onSelectingLocation: (){
                                                context.read<DailyMissionsCubit>().onSetLocationTapped(
                                                    context: context,
                                                    index: customMissionsIndex,
                                                    googleMapsCubit:BlocProvider.of<GoogleMapsCubit>(context),
                                                    wichListCheck: context.read<DailyMissionsCubit>().dailyMissionsList
                                                );
                                              },
                                              onSelectingTime: (){
                                                dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                              },
                                              onDeleteMission: (){
                                                dailyMissionCubit.deleteDataFromDatabase(
                                                    missionId: dailyMissionCubit.dailyMissionsList[customMissionsIndex].repeatableMissionId!,
                                                    context: context
                                                );
                                              },
                                              onDoneTappedFunction: (){
                                                dailyMissionCubit.updateDataFromDatabase
                                                  (
                                                    missionId:dailyMissionCubit.dailyMissionsList[customMissionsIndex].repeatableMissionId,
                                                    missionName: dailyMissionCubit.missionController!.text,
                                                    missionTime:  dailyMissionCubit.timeValue??dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionTime??'Set Time',
                                                    missionDate : dailyMissionCubit.timeValue??dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionDate??'Set Date ',
                                                    missionRepeat: dailyMissionCubit.repeatValue?? dailyMissionCubit.timeValue??dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionRepeat??'custom',
                                                    missionLocationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionLocationName,
                                                    missionRecordPath: BlocProvider.of<TestRecordCubit>(context).recordUri,
                                                    missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId,
                                                    missionLocationLat:BlocProvider.of<GoogleMapsCubit>(context)
                                                        .selectedLocationStatic !=
                                                        null
                                                        ? '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat}'
                                                        : dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionLocationLat??'',
                                                    missionLocationLng: BlocProvider.of<GoogleMapsCubit>(context)
                                                        .selectedLocationStatic !=
                                                        null
                                                        ? '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng}'
                                                        :  dailyMissionCubit.dailyMissionsList[customMissionsIndex].missionLocationLng??'',
                                                    missionDescription: ''
                                                );
                                                Navigator.pop(context);
                                                // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                              });
                                        }
                                    );
                                  });
                            },
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

@immutable
class WeaklyDailyMissionsView extends StatelessWidget {
  const WeaklyDailyMissionsView({Key? key}) : super(key: key);
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
                  if(context.read<DailyMissionsCubit>().weeklyMissionList.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'no weekly missions, Add one',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.weeklyMissionList.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          CustomDailyMissionViewItem(
                            missionViewModel:dailyMissionCubit.weeklyMissionList.elementAt(customMissionsIndex) ,
                            onLongPress: (){
                              customMissionControlDialog(context: context,
                                  onArchiveTapped: (){
                                    dailyMissionCubit.addMissionToArchivedMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);
                                  },onDoneTapped: (){
                                    dailyMissionCubit.addMissionToDoneMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);

                                  });
                            },
                            onMissionTapped: (){
                              dailyMissionCubit.doneForEdit=true;
                              dailyMissionCubit.missionController!.text
                              =dailyMissionCubit.weeklyMissionList.elementAt(customMissionsIndex).missionName!;
                              showBarModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  context: context,
                                  builder: (context){
                                    return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                        builder: (context, snapshot) {
                                          return DailyMissionBottomSheet(
                                              missionController: dailyMissionCubit.missionController,
                                              timeValue:context.read<DailyMissionsCubit>().timeValue?? dailyMissionCubit.weeklyMissionList.elementAt(customMissionsIndex).missionTime,
                                              dateValue: dailyMissionCubit.dateValue?? dailyMissionCubit.weeklyMissionList.elementAt(customMissionsIndex).missionDate,
                                              repeatValue:  dailyMissionCubit.weeklyMissionList.elementAt(customMissionsIndex).missionRepeat??'custom',
                                              doneForEdit: true,
                                              locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.weeklyMissionList[customMissionsIndex].missionLocationName??'At Location',
                                              onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                              missionRecordUri: dailyMissionCubit.weeklyMissionList[customMissionsIndex].missionRecordPath!,
                                              onSelectingLocation: (){
                                                context.read<DailyMissionsCubit>().onSetLocationTapped(
                                                    context: context,
                                                    index: customMissionsIndex,
                                                    googleMapsCubit:BlocProvider.of<GoogleMapsCubit>(context),
                                                    wichListCheck: context.read<DailyMissionsCubit>().weeklyMissionList
                                                );
                                              },
                                              onSelectingTime: (){
                                                dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                              },
                                              onDeleteMission: (){
                                                dailyMissionCubit.deleteDataFromDatabase(
                                                    missionId: dailyMissionCubit.weeklyMissionList[customMissionsIndex].repeatableMissionId!,
                                                    context: context
                                                );
                                              },
                                              onDoneTappedFunction: (){
                                                dailyMissionCubit.updateDataFromDatabase
                                                  (
                                                    missionId:dailyMissionCubit.weeklyMissionList[customMissionsIndex].repeatableMissionId,
                                                    missionName: dailyMissionCubit.missionController!.text,
                                                    missionTime:  dailyMissionCubit.timeValue??dailyMissionCubit.weeklyMissionList[customMissionsIndex].missionTime??'Set Time',
                                                    missionDate : dailyMissionCubit.timeValue??dailyMissionCubit.weeklyMissionList[customMissionsIndex].missionDate??'Set Date ',
                                                    missionRepeat: dailyMissionCubit.repeatValue??'custom',
                                                    missionLocationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.weeklyMissionList[customMissionsIndex].missionLocationName,
                                                    missionRecordPath: BlocProvider.of<TestRecordCubit>(context).recordUri,
                                                    missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId,
                                                    missionLocationLat:'${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}' ,
                                                    missionLocationLng: '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}',
                                                    missionDescription: ''
                                                );
                                                Navigator.pop(context);
                                                // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                              });
                                        }
                                    );
                                  });
                            },
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

@immutable
class MonthlyMissionsView extends StatelessWidget {
  const MonthlyMissionsView({Key? key}) : super(key: key);
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
                  if(context.read<DailyMissionsCubit>().monthlyMissionsList.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'no monthly missions Add one',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.monthlyMissionsList.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          CustomDailyMissionViewItem(
                            missionViewModel:dailyMissionCubit.monthlyMissionsList.elementAt(customMissionsIndex) ,
                            onLongPress: (){
                              customMissionControlDialog(context: context,
                                  onArchiveTapped: (){
                                    dailyMissionCubit.addMissionToArchivedMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);
                                  },onDoneTapped: (){
                                    dailyMissionCubit.addMissionToDoneMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);

                                  });
                            },
                            onMissionTapped: (){
                              dailyMissionCubit.doneForEdit=true;
                              dailyMissionCubit.missionController!.text
                              =dailyMissionCubit.monthlyMissionsList.elementAt(customMissionsIndex).missionName!;
                              showBarModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  context: context,
                                  builder: (context){
                                    return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                        builder: (context, snapshot) {
                                          return DailyMissionBottomSheet(
                                              missionController: dailyMissionCubit.missionController,
                                              timeValue:context.read<DailyMissionsCubit>().timeValue?? dailyMissionCubit.monthlyMissionsList.elementAt(customMissionsIndex).missionTime,
                                              dateValue: dailyMissionCubit.dateValue?? dailyMissionCubit.monthlyMissionsList.elementAt(customMissionsIndex).missionDate,
                                              repeatValue:  dailyMissionCubit.monthlyMissionsList.elementAt(customMissionsIndex).missionRepeat??'custom',
                                              doneForEdit: true,
                                              locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionLocationName??'At Location',
                                              onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                              missionRecordUri: dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionRecordPath!,
                                              onSelectingLocation: (){
                                                context.read<DailyMissionsCubit>().onSetLocationTapped(
                                                    context: context,
                                                    index: customMissionsIndex,
                                                    googleMapsCubit:BlocProvider.of<GoogleMapsCubit>(context),
                                                    wichListCheck: context.read<DailyMissionsCubit>().monthlyMissionsList
                                                );
                                              },
                                              onSelectingTime: (){
                                                dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                              },
                                              onDeleteMission: (){
                                                dailyMissionCubit.deleteDataFromDatabase(
                                                    missionId: dailyMissionCubit.monthlyMissionsList[customMissionsIndex].repeatableMissionId!,
                                                    context: context
                                                );
                                              },
                                              onDoneTappedFunction: (){
                                                dailyMissionCubit.updateDataFromDatabase
                                                  (
                                                    missionId:dailyMissionCubit.monthlyMissionsList[customMissionsIndex].repeatableMissionId,
                                                    missionName: dailyMissionCubit.missionController!.text,
                                                    missionTime:  dailyMissionCubit.timeValue??dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionTime??'Set Time',
                                                    missionDate : dailyMissionCubit.timeValue??dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionDate??'Set Date ',
                                                    missionRepeat: dailyMissionCubit.repeatValue??dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionRepeat??'custom',
                                                    missionLocationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.monthlyMissionsList[customMissionsIndex].missionLocationName,
                                                    missionRecordPath: BlocProvider.of<TestRecordCubit>(context).recordUri,
                                                    missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId,
                                                    missionLocationLat:'${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}' ,
                                                    missionLocationLng: '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}',
                                                    missionDescription: ''
                                                );
                                                Navigator.pop(context);
                                                // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                              });
                                        }
                                    );
                                  });
                            },
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

@immutable
class YearlyMissionsView extends StatelessWidget {
  const YearlyMissionsView({Key? key}) : super(key: key);
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
                  if(context.read<DailyMissionsCubit>().yearlyMissionsList.isEmpty){
                    return const Center(child:  PublicNeumoText(text: 'no Yearly missions Add one',color: Colors.red,size: 17,));
                  }else{
                    return ListView.separated(
                      itemCount: dailyMissionCubit.yearlyMissionsList.length,
                      itemBuilder: (context,customMissionsIndex){
                        return
                          CustomDailyMissionViewItem(
                            missionViewModel:dailyMissionCubit.yearlyMissionsList.elementAt(customMissionsIndex) ,
                            onLongPress: (){
                              customMissionControlDialog(context: context,
                                  onArchiveTapped: (){
                                    dailyMissionCubit.addMissionToArchivedMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);
                                  },onDoneTapped: (){
                                    dailyMissionCubit.addMissionToDoneMissionsList(itemIndex: customMissionsIndex,wichList: dailyMissionCubit.customMissionsList);
                                    Navigator.pop(context);

                                  });
                            },                            onMissionTapped: (){
                              dailyMissionCubit.doneForEdit=true;
                              dailyMissionCubit.missionController!.text
                              =dailyMissionCubit.yearlyMissionsList.elementAt(customMissionsIndex).missionName!;
                              showBarModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  context: context,
                                  builder: (context){
                                    return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                        builder: (context, snapshot) {
                                          return DailyMissionBottomSheet(
                                              missionController: dailyMissionCubit.missionController,
                                              timeValue:context.read<DailyMissionsCubit>().timeValue?? dailyMissionCubit.yearlyMissionsList.elementAt(customMissionsIndex).missionTime,
                                              dateValue: dailyMissionCubit.dateValue?? dailyMissionCubit.yearlyMissionsList.elementAt(customMissionsIndex).missionDate,
                                              repeatValue:  dailyMissionCubit.yearlyMissionsList.elementAt(customMissionsIndex).missionRepeat??'custom',
                                              locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionLocationName??'At Location',
                                              doneForEdit: true,
                                              onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                              missionRecordUri: dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionRecordPath!,
                                              onSelectingLocation: (){
                                                context.read<DailyMissionsCubit>().onSetLocationTapped(
                                                    context: context,
                                                    index: customMissionsIndex,
                                                    googleMapsCubit:BlocProvider.of<GoogleMapsCubit>(context),
                                                    wichListCheck: context.read<DailyMissionsCubit>().yearlyMissionsList
                                                );

                                              },
                                              onSelectingTime: (){
                                                dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                              },
                                              onDeleteMission: (){
                                                dailyMissionCubit.deleteDataFromDatabase(
                                                    missionId: dailyMissionCubit.yearlyMissionsList[customMissionsIndex].repeatableMissionId!,
                                                    context: context
                                                );
                                              },
                                              onDoneTappedFunction: (){
                                                dailyMissionCubit.updateDataFromDatabase
                                                  (
                                                    missionId:dailyMissionCubit.yearlyMissionsList[customMissionsIndex].repeatableMissionId,
                                                    missionName: dailyMissionCubit.missionController!.text,
                                                    missionTime:  dailyMissionCubit.timeValue??dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionTime??'Set Time',
                                                    missionDate : dailyMissionCubit.timeValue??dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionDate??'Set Date ',
                                                    missionRepeat: dailyMissionCubit.repeatValue??dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionRepeat??'custom',
                                                    missionLocationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??dailyMissionCubit.yearlyMissionsList[customMissionsIndex].missionLocationName??'At location',
                                                    missionRecordPath: BlocProvider.of<TestRecordCubit>(context).recordUri,
                                                    missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId,
                                                    missionLocationLat:'${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}' ,
                                                    missionLocationLng: '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}',
                                                    missionDescription: ''
                                                );
                                                Navigator.pop(context);
                                                // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                              });
                                        }
                                    );
                                  });
                            },
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




