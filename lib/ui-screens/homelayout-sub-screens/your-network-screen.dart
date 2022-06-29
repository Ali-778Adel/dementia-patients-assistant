// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:untitled/bloc/network-cubit/network-cubit.dart';
import 'package:untitled/bloc/network-cubit/network-states.dart';
import 'package:untitled/components/neu-button.dart';
import 'package:untitled/ui-widgets/custom-app-bar.dart';
import '../../bloc/auth_cubit/auth-states.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../bloc/daily-mission-bloc/daily-missions-cubit.dart';
import '../../bloc/daily-mission-bloc/daily-missions-states.dart';
import '../../bloc/google-maps-cubit/google-maps-cubit.dart';
import '../../bloc/google-maps-cubit/google-maps-states.dart';
import '../../components/mission-add-notes-dialog.dart';
import '../../components/neu-text.dart';
import '../../components/show_modal_bottomsheet.dart';
import '../../test-package/record-cubit.dart';
import '../../ui-widgets/cusom-network-mission-view-item.dart';
import '../../ui-widgets/custom-darwer.dart';
import '../../ui-widgets/daily-mission-bottomsheet.dart';
import '../google-maps-screen.dart';

class UserNetworkScreen extends StatelessWidget{
  UserNetworkScreen({Key? key}) : super(key: key);
  final numberTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(child: CustomNewAppBar(appBarTitle: 'NetWork',),preferredSize: Size(double.infinity,60),),
      drawer: Drawer(child:const CustomDrawer(),width: MediaQuery.of(context).size.width*.60,),
      body: BlocBuilder<NetworkCubit,NetworkStates>(
        builder: (context, state) {
          NetworkCubit networkCubit=NetworkCubit.get(context);
          if (networkCubit.currentUserInfo.isEmpty){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            if(networkCubit.currentUserInfo['friends']==null){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PublicNeumoText(text: 'Write Mission For Your Collaborate by entering his phone Number ',color: Colors.black,size: 16,align: TextAlign.center,),
                    TextFormField(
                      controller: numberTextController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          icon:const Icon( Icons.phone),
                          hintText: 'enter your follower number',
                          errorText: context.read<NetworkCubit>().getTextFieldErrorText,
                          errorStyle: TextStyle(leadingDistribution: TextLeadingDistribution.proportional)
                      ),
                      onChanged: (_){
                        context.read<NetworkCubit>().text=numberTextController.text;
                        context.read<NetworkCubit>().emit(TextFieldChangeState());},
                    ),
                    const SizedBox(height: 20,),
                    BlocBuilder<NetworkCubit,NetworkStates>(
                        builder: (context, state) {
                          if (state is GetUserByPhoneNumberLoadingState ){
                            return const Center (child: CircularProgressIndicator(),);
                          }else{
                            return CustomNewMissionButton(
                              text: 'ok',
                              iconData: Icons.add,
                              width: 150,
                              function:(){
                                context.read<NetworkCubit>().getTargetUserData(
                                    phoneNumber: numberTextController.text
                                ).then((value) {
                                  if (networkCubit.errormsg==''){
                                    checkState(context: context,onOkTapped: (){});
                                  }
                                });

                              },
                            );
                          }

                        }
                    )
                  ],
                ),
              );              }
            else{
              return  NetworkDataClass(networkCubit: networkCubit
                ,dailyMissionCubit: BlocProvider.of<DailyMissionsCubit>(context),);
            }
          }
        }
    ),
    );
  }
}


class NetworkDataClass extends StatelessWidget{
  final NetworkCubit?networkCubit;
  final  DailyMissionsCubit dailyMissionCubit;
  const  NetworkDataClass({Key? key,this.networkCubit,required this.dailyMissionCubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<NetworkCubit,NetworkStates>(
            builder: (context, snapshot) {
              return  StreamBuilder(
                  stream:context.read<NetworkCubit>().userStream1.stream,
                  builder: (context,AsyncSnapshot<List<QueryDocumentSnapshot<Map<String,dynamic>>>>user) {
                    if (!user.hasData){
                      if(networkCubit!.isConnected==false){
                        return const Center(child:Text('check your internet '));
                      }else if (networkCubit!.isConnected==true&& networkCubit!.lists.length==0){
                        return const Center(child:Text('no missions yat add one '));
                      }else{
                        return  const Center(child:CircularProgressIndicator());
                      }
                    }else if(user.hasError){
                      return  Center(child: Text ('${user.error}'),);
                    }
                    else if (user.hasData){
                      return ListView.builder(
                          itemCount: user.data!.length,
                          itemExtent: 220,
                          shrinkWrap: false,
                          itemBuilder: (context,index){
                            // if(context.read<NetworkCubit>().lists[index]!=null){
                            return NetworkMissionViewItem(
                              onLongPress: (){},
                              onMissionTapped: (){
                                dailyMissionCubit.doneForEdit=true;
                                dailyMissionCubit.missionController!.text
                                =user.data![index]['missionName'];
                                showBarModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    context: context,
                                    builder: (context){
                                      return BlocBuilder<DailyMissionsCubit,DailyMissionsStates>(
                                          builder: (context, snapshot) {
                                            DailyMissionsCubit dailyMissionCubit=DailyMissionsCubit.get(context);
                                            return DailyMissionBottomSheet(
                                                missionController: dailyMissionCubit.missionController,
                                                noteTextController: dailyMissionCubit.missionController,
                                                timeValue:dailyMissionCubit.timeValue?? user.data![index]['missionTime']??"",
                                                dateValue: dailyMissionCubit.dateValue?? user.data![index]['missionDate']??"",
                                                repeatValue:user.data![index]['missionRepeat']??'custom',
                                                locationName: BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??user.data![index]['missionLocationName']??'At Location',
                                                doneForEdit: true,
                                                onSelectingDate: (){dailyMissionCubit.onsetDateButtonTapped(context: context);},
                                                missionRecordUri:'com.example.aac',
                                                onSelectingLocation: (){
                                                  if (user.data![index]['missionLocationId'] != 'null') {
                                                    showMapModalBottomSheet(
                                                        context: context,
                                                        mapWidget: GoogleMapsScreen());

                                                    BlocProvider.of<GoogleMapsCubit>(context)
                                                        .setSelectedLocation(
                                                        user.data![index]['missionLocationId']
                                                    );
                                                    BlocProvider.of<GoogleMapsCubit>(context).emit(SetSelectedLocationState());
                                                    BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic==null?  BlocProvider.of<GoogleMapsCubit>(context)
                                                        .initCameraPositionTarget =
                                                        LatLng(
                                                          double.parse(user.data![index]['missionLocationLat']),
                                                          double.parse(user.data![index]['missionLocationLng']),)
                                                        :
                                                    BlocProvider.of<GoogleMapsCubit>(context)
                                                        .initCameraPositionTarget =
                                                        LatLng(
                                                          BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!,
                                                          BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng!,
                                                        );
                                                    if(BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem==null){
                                                      BlocProvider.of<GoogleMapsCubit>(context).goToMissionPlace();
                                                    }
                                                    BlocProvider.of<GoogleMapsCubit>(context).addPolyLine();
                                                  }
                                                  else{
                                                    print('i am in else condition ');
                                                    showMapModalBottomSheet(
                                                        context: context,
                                                        mapWidget: GoogleMapsScreen());
                                                  }
                                                  dailyMissionCubit.emit(OnLocationButtonTappedState());

                                                },
                                                onSelectingTime: (){
                                                  dailyMissionCubit.onsetTimeButtonTapped(context: context);
                                                },
                                                onDeleteMission: (){
                                                  networkCubit!.deleteDocFromFireStore(user.data![index]['docPath']);
                                                  Navigator.pop(context);

                                                },
                                                onDoneTappedFunction: (){
                                                  networkCubit!.updateFireStoreDoc
                                                    (
                                                      dailyMissionsCubit: dailyMissionCubit,
                                                      docPath: index+1,
                                                      missionRepeat: user.data![index]['missionRepeat'],
                                                      missionTime: user.data![index]['missionTime'],
                                                      missionDate: user.data![index]['missionDate']
                                                  );
                                                  Navigator.pop(context);
                                                  // dailyMissionCubit.disposeDailyMissionsCubit(context);
                                                });
                                          }
                                      );
                                    });
                              },
                              missionName:user.data![index]['missionName']??'no name for this mission',
                              missionTime:user.data![index]['missionTime']?? 'missionTime',
                              missionDate:user.data![index]['missionDate']??'missionDate',
                              missionRepeat: user.data![index]['missionRepeat']??'daily',
                              missionLocationName: user.data![index]['missionLocationName'],
                            );

                            // }else{
                            //   return const Center (child:  CircularProgressIndicator(),);
                            // }

                          });
                    }else{
                      return const Center (child: Text('wait .....'),);
                    }
                  }
              );
            }
        ),
        if(networkCubit!.currentUserInfo['state']=='writer')
          Positioned(
            bottom: 20,
            right: 10,
            child:
            CustomNewMissionButton(
              width: MediaQuery.of(context).size.width*.80,
              text: 'Add new mission for ${context.read<NetworkCubit>().currentUserInfo['friends']}',
              iconData:Icons.add ,
              function: (){
                dailyMissionCubit.doneForEdit=false;
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
                                  context.read<NetworkCubit>().sendMissionsToDementian(
                                      targetUserId: context.read<NetworkCubit>().currentUserInfo['userId'],
                                      dailyMissionsCubit:dailyMissionsCubit,
                                      googleMapsCubit: BlocProvider.of<GoogleMapsCubit>(context)
                                  );
                                  // dailyMissionsCubit.insertDatabaseMissions(
                                  //   missionRecordUri:BlocProvider.of<TestRecordCubit>(context).recordUri,
                                  //   missionLocationName:BlocProvider.of<GoogleMapsCubit>(context).searchResultSelectedItem??'null',
                                  //   missionLocationId: BlocProvider.of<GoogleMapsCubit>(context).selectedPlaceId??'null',
                                  //   missionLocationLng:BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic !=null
                                  //       ?
                                  //   '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng!}':'null',
                                  //   missionLocationLat:BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic !=null
                                  //       ?
                                  //   '${BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!}':'null',
                                  // );
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
          ),
        if(networkCubit!.currentUserInfo['state']=='reader')
          Positioned(bottom: 20,
            right: 10,
            child: Text('you receive task from your collaborate ${networkCubit!.currentUserInfo['userEmail']}'
              ,style:const TextStyle(fontSize: 14,color: Colors.grey,) ,),)
      ],
    );
  }
}

YYDialog checkState({
  required BuildContext context,
  required Function()onOkTapped,
}){
  return YYDialog().build(context)
    ..height = 200
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..barrierDismissible=false
    ..widget(
        BlocBuilder<NetworkCubit,NetworkStates>(builder: (context,state){
          return  Container(
            height: 120,
            margin: const EdgeInsets.only(top: 20),
            child:const Center(
              child: Text(' you  want to read mission from ,or write to him'),
            ),
          );
        })
    )..divider()..doubleButton(
        padding: const EdgeInsets.only(top: 10.0),
        gravity: Gravity.center,
        withDivider: true,
        text1: "write",
        color1: Colors.redAccent,
        fontSize1: 16.0,
        fontWeight1: FontWeight.normal,
        onTap1: () async{
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'state':'writer'}).then((value)async {
            await FirebaseFirestore.instance.collection('users').doc(context.read<NetworkCubit>().targetUserInfo['userId']).update({'state':'reader'}).then((value){
              context.read<NetworkCubit>().getCurrentUserInfo();
              context.read<NetworkCubit>().emit(SetHostDataLoadingState());
            });
          });
        },
        text2: "read",
        color2: Colors.redAccent,
        fontSize2: 16.0,
        fontWeight2: FontWeight.normal,
        onTap2:()async{
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'state':'reader'}).then((value)async {
            await FirebaseFirestore.instance.collection('users').doc(context.read<NetworkCubit>().targetUserInfo['userId']).update({'state':'writer'}).then((value){
              context.read<NetworkCubit>().getCurrentUserInfo();
              context.read<NetworkCubit>().emit(SetGuestDataLoadingState());

            });
          });
        }
    )..show(15.2,14.2);
}