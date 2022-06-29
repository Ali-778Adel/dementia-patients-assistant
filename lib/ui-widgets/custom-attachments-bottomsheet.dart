import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/home-page-bloc/test_cubit.dart';
import 'package:untitled/components/cutom-add-audio-record-dialog.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/test-package/record-cubit.dart';
import 'package:untitled/ui-widgets/custom-build-text-widget.dart';
import '../components/neu-button.dart';
import '../constants/constants.dart';
import '../test-package/runscreen.dart';

class CustomAttachmentsBottomSheet extends StatelessWidget {
  const CustomAttachmentsBottomSheet({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<TestRecordCubit, TestRecordStates>(
              builder: (context, state) {
            TestRecordCubit recordCubit = TestRecordCubit.get(context);
                return Column(
                  children: [
                    CustomAttachBottomSheetButton(
                      width: MediaQuery.of(context).size.width * .95,
                      textColor: Colors.black,
                      borderColor: Colors.black,
                      iconWidget: const PublicNeumoIcon(
                        iconData: Icons.mic_rounded,
                        size: 20,
                      ),
                      text: 'Add Voice Note',
                      shadowDarkColor: Colors.black,
                      function: () {
                        customAddingAudioRecordDialog1(
                            context: context,
                            dialogBuildWidget:
                                BlocBuilder<TestRecordCubit, TestRecordStates>(
                                    builder: (context, snapshot) {
                              return const ExcuteRecordingProcess();
                            }),
                            onOkTapped: () {
                              Navigator.pop(context);
                            },
                            onCancelTapped: () {
                              context.read<TestRecordCubit>().onDispose();
                            });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (context.read<TestRecordCubit>().audioDuration != 0)
                      ClayContainer(
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
                                context.read<TestRecordCubit>().onPlayingAudio();
                              },
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Expanded(
                                flex: 8,
                                child: StreamBuilder<Duration>(
                                  stream: recordCubit.audioPlayerService
                                      .assetsAudioPlayer!.currentPosition,
                                  builder: (context, snapshot) {
                                    final Duration position = recordCubit
                                        .audioPlayerService
                                        .assetsAudioPlayer!
                                        .currentPosition
                                        .value;
                                    return Slider(
                                        min: 0.0,
                                        max: recordCubit.audioDuration.toDouble(),
                                        value: position.inSeconds.toDouble(),
                                        onChanged: (val) {
                                          recordCubit.onAudioSliderChanged(val);
                                        });
                                  },
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                                flex: 4,
                                child: BuildAudioText(
                                    isPlaying: recordCubit.isPlaying,
                                    minuteFormat: recordCubit.formatNumber(
                                        recordCubit.playbackDuration ~/ 60),
                                    secondFormat: recordCubit.formatNumber(
                                        recordCubit.playbackDuration % 60)))
                          ],
                        ),
                      ),
                  ],
                );
          }),
          const SizedBox(
            height: 20,
          ),
          // Flexible(
          //   child: BlocBuilder<TestCubit, TestStates>(
          //       builder: (context, snapshot) {
          //     TestCubit testCubit = TestCubit.get(context);
          //     if (testCubit.images == null) {
          //       return CustomAttachBottomSheetButton(
          //         width: MediaQuery.of(context).size.width * .95,
          //         textColor: Colors.black,
          //         borderColor: Colors.black,
          //         iconWidget: const PublicNeumoIcon(
          //           iconData: Icons.photo,
          //           size: 20,
          //         ),
          //         text: 'Add Picture',
          //         shadowDarkColor: Colors.black,
          //         function: () {
          //           testCubit.onAddPhotoButtonTapped();
          //         },
          //       );
          //     } else {
          //       return Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           CustomAttachBottomSheetButton(
          //             width: MediaQuery.of(context).size.width * .95,
          //             textColor: Colors.black,
          //             borderColor: Colors.black,
          //             iconWidget: const PublicNeumoIcon(
          //               iconData: Icons.photo,
          //               size: 20,
          //             ),
          //             text: 'Add Picture',
          //             shadowDarkColor: Colors.black,
          //             function: () {
          //               testCubit.onAddPhotoButtonTapped();
          //             },
          //           ),
          //           SizedBox(
          //             height: 80,
          //             child: GridView.builder(
          //                 gridDelegate:
          //                     const SliverGridDelegateWithFixedCrossAxisCount(
          //                         crossAxisCount: 6,
          //                         crossAxisSpacing: 5.0,
          //                         mainAxisSpacing: 5.0),
          //                 itemCount: testCubit.images!.length,
          //                 itemBuilder: (context, index) {
          //                   return SizedBox(
          //                       height: 40,
          //                       width: 40,
          //                       child: Image.file(
          //                         File(testCubit.images![index].path),
          //                         fit: BoxFit.contain,
          //                       ));
          //                 }),
          //           )
          //         ],
          //       );
          //     }
          //   }),
          // ),
        ],
      ),
    );
  }
}
