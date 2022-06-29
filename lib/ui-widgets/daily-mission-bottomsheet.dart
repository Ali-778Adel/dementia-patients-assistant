// ignore_for_file: file_names
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-cubit.dart';
import 'package:untitled/bloc/daily-mission-bloc/daily-missions-states.dart';
import '../components/custom-yyrepeat-dialog.dart';
import '../components/mission-add-notes-dialog.dart';
import '../components/neu-button.dart';
import '../components/neu-icon.dart';
import '../components/neu-text.dart';
import '../components/show_modal_bottomsheet.dart';
import '../constants/constants.dart';
import '../test-package/record-cubit.dart';
import '../ui-screens/google-maps-screen.dart';
import 'custom-attachments-bottomsheet.dart';
import 'custom-barmodal-top-controll.dart';
import 'custom-build-text-widget.dart';

class DailyMissionBottomSheet extends StatelessWidget {

  final TextEditingController? missionController;
  final TextEditingController ?noteTextController;
  final String?timeValue;
  final String?dateValue;
  final String?repeatValue;
  final String?locationName;
  final String?missionRecordUri;
  final bool?doneForEdit;
  final Function()?onSelectingTime;
  final Function()?onSelectingDate;
  final Function()?onSelectingRepeatMethod;
  final Function()?onSelectingLocation;
  final Function()?onDeleteMission;
  final Function()?onDoneTappedFunction;

 const DailyMissionBottomSheet(
      {Key? key,
        this.missionController,
        this.noteTextController,
        this.timeValue,
        this.dateValue,
        this.repeatValue,
        this.missionRecordUri,
        this.locationName,
        this.doneForEdit,
        this.onSelectingTime,
        this.onSelectingDate,
        this.onSelectingRepeatMethod,
        this.onDeleteMission,
        this.onSelectingLocation,

       this.onDoneTappedFunction})
      : super(key: key);

  final int? _value = 1;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.839,
          width: MediaQuery.of(context).size.width * 0.99,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 10,),
                Container(
                  child: const Center(child: CustomBarModalControl()),
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                ),
                TextFormField(
                  controller: missionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      hintText: ' I Want to .....',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 22)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: const Text(
                    'Remind me about this ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 140,
                    margin: const EdgeInsets.all(1),
                    width: MediaQuery.of(context).size.width * .95,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: CustomNewMissionButton(
                                text:timeValue?? 'Set Time',
                                iconData: Icons.watch_later_outlined,
                                function: onSelectingTime!,
                              ),
                            ),
                            Expanded(
                              child: CustomNewMissionButton(
                                text:repeatValue?? 'Repeat',
                                iconData: Icons.repeat,
                                function: (){
                                  if(doneForEdit == false){
                                    CustomRepeatDialog(context);
                                  }else
                                  {
                                    customMissionAlertDialog(
                                        context: context,
                                        alertText: "this mission is custom repeat mission \n,you can't edit it ",
                                        onOkTapped: (){},
                                        onCancelTapped: (){}
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: CustomNewMissionButton(
                                text:dateValue?? 'Set Date',
                                iconData: Icons.calendar_today_sharp,
                                function: onSelectingDate,
                              ),
                            ),
                            Expanded(
                              child: CustomNewMissionButton(
                                text:locationName?? 'At location',
                                iconData: Icons.location_on,
                                function:onSelectingLocation
                              ),
                            ),
                          ],
                        )),
                      ],
                    )
                    ),
                // const SizedBox(height: 0,),
                // Container(
                //   margin: const EdgeInsets.only(left: 15),
                //   child: const PublicNeumoText(
                //     text: 'Lists',
                //     color: Colors.black,
                //     size: 14,
                //   ),
                // ),
                // Container(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: DropdownButton(
                //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                //       value: _value,
                //       items: const [
                //         DropdownMenuItem(
                //           child: PublicNeumoText(
                //             text: "personal",
                //             size: 14,
                //             color: Colors.black,
                //           ),
                //           value: 1,
                //         ),
                //         DropdownMenuItem(
                //           child: PublicNeumoText(
                //             text: "work",
                //             size: 14,
                //             color: Colors.black,
                //           ),
                //           value: 2,
                //         )
                //       ],
                //       onChanged: (int? value) {
                //         // _value = value;
                //       },
                //       hint: const Text("Select item")),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const PublicNeumoText(
                    text: 'Add Notes',
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                AddMissionNotes(),
                const SizedBox(
                  height: 20,
                ),

                AddMissionAttachements(
                 missionRecordUri: missionRecordUri,
                ),                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const PublicNeumoText(
                    text: 'Delete this mission ',
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                CustomBottomSheetButton(
                  width: MediaQuery.of(context).size.width * .95,
                  textColor: Colors.red,
                  borderColor: Colors.red,
                  text: 'Delete Mission',
                  shadowDarkColor: Colors.red,
                  function: onDeleteMission!,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 60,
          child: CustomNewMissionButton(
            width: double.infinity,
            text: 'Done',
            iconData: Icons.check_circle_outline_rounded,
            function: onDoneTappedFunction!,
          ),
        )
      ],
    );
  }
}

@immutable
class AddMissionNotes extends StatelessWidget {
   TextEditingController missionNoteController=TextEditingController()  ;
   AddMissionNotes({
    Key? key,
   })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBottomSheetButton(
                width: MediaQuery.of(context).size.width * .95,
                textColor: Colors.black,
                borderColor: Colors.black,
                text: 'Add Notes',
                shadowDarkColor: Colors.black,
                function: () {
                  customMissionAddNotesDialog(
                      context: context,
                      notesController: missionNoteController,
                      onOkTapped: () {
                        BlocProvider.of<DailyMissionsCubit>(context).missionNotes=missionNoteController.text;
                        BlocProvider.of<DailyMissionsCubit>(context).emit(UpdateMissionNoteController());

                        },
                      onCancelTapped: () {
                        missionNoteController.clear();
                      });
                },
              ),
              if (BlocProvider.of<DailyMissionsCubit>(context).missionNotes!=null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: .5),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Text.rich(
                    TextSpan(
                        text: 'mission description :\n',
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        children: [
                          TextSpan(
                              text:
                              BlocProvider.of<DailyMissionsCubit>(context).missionNotes,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))
                        ]),
                  ),
                )
            ],
          );

  }
}

@immutable
class AddMissionAttachements extends StatelessWidget {
  final Function()? onAddAttachmentsTapped;
  final String? missionRecordUri;
  const AddMissionAttachements(
      {Key? key, this.missionRecordUri, this.onAddAttachmentsTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const PublicNeumoText(
            text: 'Add Attachments',
            color: Colors.black,
            size: 14,
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        CustomBottomSheetButton(
          width: MediaQuery.of(context).size.width * .95,
          textColor: Colors.black,
          borderColor: Colors.black,
          text: 'Add Attachments',
          shadowDarkColor: Colors.black,
          function: (){
            showCustomModalBottomsheet(
                context: context,
                widget:const CustomAttachmentsBottomSheet(
                ));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        if (missionRecordUri != 'com.example.aac')
          Container(
            margin: const EdgeInsets.all(10),
            height: 20,
            width: double.infinity,
            child: BlocBuilder<TestRecordCubit, TestRecordStates>(
              builder: (context, states) {
                TestRecordCubit testRecordCubit = TestRecordCubit.get(context);

                String getCorrectUri() {
                  if (testRecordCubit.recordUri == 'com.example.aac') {
                    return missionRecordUri!;
                  } else {
                    return testRecordCubit.recordUri;
                  }
                }

                return ClayContainer(
                  color: scaffoldMainColor,
                  borderRadius: 15,
                  height: 35,
                  width: double.infinity,
                  depth: 16,
                  spread: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        child: SizedBox(
                          width: 2,
                        ),
                      ),
                      InkWell(
                        child: PublicNeumoIcon(
                          iconColor: context.read<TestRecordCubit>().isPlaying
                              ? Colors.blue
                              : Colors.black,
                          iconData: context.read<TestRecordCubit>().isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 22,
                        ),
                        onTap: () {
                          context
                              .read<TestRecordCubit>()
                              .onPlayingDatabaseAudioPath(
                              path: getCorrectUri());
                        },
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Expanded(
                          flex: 8,
                          child: StreamBuilder<Duration>(
                            stream: testRecordCubit.audioPlayerService
                                .assetsAudioPlayer!.currentPosition,
                            builder: (context, snapshot) {
                              return Slider(
                                  min: 0.0,
                                  max: snapshot.hasData
                                      ? testRecordCubit.audioDuration.toDouble()
                                      : 0.0,
                                  value: snapshot.hasData
                                      ? snapshot.data!.inSeconds.toDouble()
                                      : 0.0,
                                  onChanged: (val) {
                                    testRecordCubit.onAudioSliderChanged(val);
                                  });
                            },
                          )),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                          flex: 4,
                          child: BuildAudioText(
                              isPlaying: testRecordCubit.isPlaying,
                              minuteFormat: testRecordCubit.formatNumber(
                                  testRecordCubit.playbackDuration ~/ 60),
                              secondFormat: testRecordCubit.formatNumber(
                                  testRecordCubit.playbackDuration % 60)))
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

