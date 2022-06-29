import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/bloc/google-maps-cubit/google-maps-cubit.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-cubit.dart';
import 'package:untitled/bloc/home-page-bloc/weekdays-missions-states.dart';
import 'package:untitled/test-package/record-cubit.dart';
import 'package:untitled/ui-widgets/custom-attachments-bottomsheet.dart';
import '../components/mission-add-notes-dialog.dart';
import '../components/neu-button.dart';
import '../components/neu-icon.dart';
import '../components/neu-text.dart';
import '../components/show_modal_bottomsheet.dart';
import '../constants/constants.dart';
import '../constants/weekdays-list.dart';
import '../ui-screens/google-maps-screen.dart';
import '../ui-widgets/custom-barmodal-top-controll.dart';
import 'custom-build-text-widget.dart';
@immutable
class CustomWeekdaysMissionsBottomSheet extends StatelessWidget {
  final TextEditingController? weekDayMissionController;
  final String? headerText;
  final String? missionRecordUri;
  final int? index;
  final int? missionId;
  final int? missionsListVewIndex;
  final Function()? onAddLocationTapped;
  final Function()? onAddAttachmentsTapped;
  final Function()? onDeleteButtonTapped;
  final Function()? onDoneBottomTapped;

  const CustomWeekdaysMissionsBottomSheet(
      {Key? key,
        this.weekDayMissionController,
        this.headerText,
        this.index,
        this.missionId,
        this.missionsListVewIndex,
        this.missionRecordUri,
        this.onAddLocationTapped,
        this.onDeleteButtonTapped,
        this.onAddAttachmentsTapped,
        this.onDoneBottomTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
          margin: const EdgeInsets.all(10),
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
                    Container(
                      child: const Center(child: CustomBarModalControl()),
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Text.rich(TextSpan(
                        text: 'Add missions for  ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                        children: [
                          TextSpan(
                            text: headerText,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.redAccent),
                          )
                        ],
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: BlocBuilder<WeekdaysMissionsCubit,
                          WeekdaysMissionStates>(builder: (context, snapshot) {
                        return TextFormField(
                          style: const TextStyle(
                              fontSize: 20,
                              wordSpacing: 5,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          controller: context
                              .read<WeekdaysMissionsCubit>()
                              .missionNameController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              hintText: ' I Want to .....',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 22)),
                        );
                      }),
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
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<WeekdaysMissionsCubit,
                              WeekdaysMissionStates>(builder: (context, state) {
                            return CustomNewMissionButton(
                              text: context
                                  .read<WeekdaysMissionsCubit>()
                                  .timeValue ??
                                  'Set Time',
                              iconData: Icons.watch_later_outlined,
                              function: () {
                                context
                                    .read<WeekdaysMissionsCubit>()
                                    .setMissionTime(context: context);
                              },
                            );
                          }),
                        ),
                        Expanded(
                          child: CustomNewMissionButton(
                            text: BlocProvider.of<GoogleMapsCubit>(context)
                                .searchResultSelectedItem ??
                                'select location',
                            iconData: Icons.location_on,
                            function: () {
                              if (context
                                  .read<WeekdaysMissionsCubit>()
                                  .doneForEdit && context
                                  .read<WeekdaysMissionsCubit>()
                                  .weekdaysMissionsList
                              [daysOfWeek[index!]]![missionsListVewIndex!]
                                  .missionLocationId != 'null') {
                                showMapModalBottomSheet(
                                    context: context,
                                    mapWidget: GoogleMapsScreen());
                                BlocProvider.of<GoogleMapsCubit>(context)
                                    .setSelectedLocation(context
                                    .read<WeekdaysMissionsCubit>()
                                    .weekdaysMissionsList[daysOfWeek[
                                index!]]![missionsListVewIndex!]
                                    .missionLocationId!);
                                BlocProvider.of<GoogleMapsCubit>(context)
                                    .initCameraPositionTarget =
                                    LatLng(
                                      BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lat!,
                                      BlocProvider.of<GoogleMapsCubit>(context).selectedLocationStatic!.geometry!.location!.lng!,);

                                BlocProvider.of<GoogleMapsCubit>(context).addPolyLine();
                              }else{
                                showMapModalBottomSheet(
                                    context: context,
                                    mapWidget: GoogleMapsScreen());
                              }

                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const PublicNeumoText(
                        text: 'Add mission Notes ',
                        color: Colors.black,
                        size: 14,
                      ),
                    ),
                    const AddMissionNotes(),
                    const SizedBox(
                      height: 20,
                    ),
                    AddMissionAttachements(
                      missionRecordUri: missionRecordUri,
                      onAddAttachmentsTapped: () {
                        showCustomModalBottomsheet(
                            context: context,
                            widget:const CustomAttachmentsBottomSheet(
                            ));
                      },
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
                      function: onDeleteButtonTapped,
                    ),
                  ]))),
      const Spacer(),
      SizedBox(
        height: 60,
        child: BlocBuilder<WeekdaysMissionsCubit, WeekdaysMissionStates>(
            builder: (ctx, snapshot) {
              return BlocBuilder<TestRecordCubit, TestRecordStates>(
                  builder: (context, snapshot) {
                    var googleMapsCubit = BlocProvider.of<GoogleMapsCubit>(context);
                    return CustomNewMissionButton(
                      width: double.infinity,
                      text: 'Done',
                      iconData: Icons.check_circle_outline_rounded,
                      function: () {
                        if (ctx.read<WeekdaysMissionsCubit>().doneForEdit) {
                          ctx
                              .read<WeekdaysMissionsCubit>()
                              .updateWeekdaysMissionQueries(
                            missionId: missionId,
                            missionRecordPath:
                            context.read<TestRecordCubit>().recordUri,
                            missionLocationName:
                            googleMapsCubit.searchResultSelectedItem ?? 'null',
                            locationId: googleMapsCubit.selectedPlaceId,
                            missionLocationLat: googleMapsCubit
                                .selectedLocationStatic !=
                                null
                                ? '${googleMapsCubit.selectedLocationStatic!.geometry!.location!.lat}'
                                : '',
                            missionLocationLng: googleMapsCubit
                                .selectedLocationStatic !=
                                null
                                ? '${googleMapsCubit.selectedLocationStatic!.geometry!.location!.lng}'
                                : '',
                          );
                          context.read<WeekdaysMissionsCubit>().onDispose(context: ctx);
                        } else {
                          context.read<WeekdaysMissionsCubit>().onDoneButtonTapped(
                            index: index!,
                            missionRecordPath:
                            ctx.read<TestRecordCubit>().recordUri,
                            locationId: googleMapsCubit.selectedPlaceId,
                            missionLocationName:
                            googleMapsCubit.searchResultSelectedItem ?? 'null',
                            missionWeekdayName: daysOfWeek[index!],
                            missionLocationLat: googleMapsCubit
                                .selectedLocationStatic !=
                                null
                                ? '${googleMapsCubit.selectedLocationStatic!.geometry!.location!.lat}'
                                : '',
                            missionLocationLng: googleMapsCubit
                                .selectedLocationStatic !=
                                null
                                ? '${googleMapsCubit.selectedLocationStatic!.geometry!.location!.lng}'
                                : '',
                          );
                          context.read<WeekdaysMissionsCubit>().onDispose(context: ctx);
                        }
                      },
                    );
                  });
            }),
      )
    ]);
  }
}

@immutable
class AddMissionNotes extends StatelessWidget {
  final Function()? onAddNotesButtonTapped;
  const AddMissionNotes({Key? key, this.onAddNotesButtonTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekdaysMissionsCubit, WeekdaysMissionStates>(
        builder: (context, state) {
          WeekdaysMissionsCubit weekdaysMissionsCubit =
          WeekdaysMissionsCubit.get(context);
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
                      notesController: context
                          .read<WeekdaysMissionsCubit>()
                          .missionNoteController,
                      onOkTapped: () {},
                      onCancelTapped: () {
                        context
                            .read<WeekdaysMissionsCubit>()
                            .missionNoteController
                            .clear();
                      });
                },
              ),
              if (weekdaysMissionsCubit.missionNoteController.text.isNotEmpty)
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
                              weekdaysMissionsCubit.missionNoteController.text,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))
                        ]),
                  ),
                )
            ],
          );
        });
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
          function: onAddAttachmentsTapped,
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
                  if (testRecordCubit.recordUri == 'com.example') {
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
