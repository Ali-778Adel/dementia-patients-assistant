import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/test-package/record-cubit.dart';
import 'package:untitled/ui-widgets/custom-build-text-widget.dart';
import '../constants/constants.dart';

class ExcuteRecordingProcess extends StatelessWidget {
  const ExcuteRecordingProcess({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestRecordCubit, TestRecordStates>(
        builder: (context, state) {
      TestRecordCubit testRecordCubit = TestRecordCubit.get(context);
      return Center(
        child: Container(
            height: 200,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BuildRecordText(
                     isRecording: testRecordCubit.isRecording,
                     minuteFormat: testRecordCubit.formatNumber(testRecordCubit.recordDuration ~/ 60),
                     secondFormat: testRecordCubit.formatNumber(testRecordCubit.recordDuration % 60)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<TestRecordCubit, TestRecordStates>(
                          builder: (context, snapshot) {
                        return InkWell(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: PublicNeumoIcon(
                                iconData: Icons.stop_circle,
                                size: 40,
                                iconColor: testRecordCubit.isRecording == false
                                    ? Colors.blue
                                    : scaffoldMainColor),
                          ),
                          onTap: () {
                            testRecordCubit.onStopRecording();
                          },
                        );
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: PublicNeumoIcon(
                              iconData: testRecordCubit.isRecording
                                  ? Icons.pause
                                  : Icons.mic,
                              iconColor: testRecordCubit.isRecording
                                  ? Colors.blue
                                  : Colors.grey,
                              size: 42,
                            ),
                          ),
                          onTap: () {
                            testRecordCubit.onStartRecoding();
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!testRecordCubit.isRecordPathEmpty)
                  Expanded(
                    child: ClayContainer(
                      color: scaffoldMainColor,
                      borderRadius: 35,
                      width: double.infinity,
                      height: 5,
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
                              iconColor: testRecordCubit.isPlaying
                                  ? Colors.blue
                                  : Colors.black,
                              iconData: testRecordCubit.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 32,
                            ),
                            onTap: () {
                              testRecordCubit.onPlayingAudio();
                            },
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Expanded(
                              flex: 10,
                              child: StreamBuilder<Duration>(
                                  stream: testRecordCubit.audioPlayerService
                                      .assetsAudioPlayer!.currentPosition,
                                  builder: (context, snapshot) {
                                    final Duration position = testRecordCubit
                                        .audioPlayerService
                                        .assetsAudioPlayer!
                                        .currentPosition
                                        .value;
                                    return Slider(
                                      min: 0.0,
                                      max: testRecordCubit.audioDuration
                                          .toDouble(),
                                      value: position.inSeconds.toDouble(),
                                      onChanged: (val) {
                                        testRecordCubit
                                            .onAudioSliderChanged(val);
                                      },
                                    );
                                  })),
                          const Spacer(),
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
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: InkWell(
                //         child: const Center(
                //           child: Text('Ok'),
                //         ),
                //         onTap: () {},
                //       )),
                //       Expanded(
                //           child: InkWell(
                //         child: const Center(
                //           child: Text('cancel'),
                //         ),
                //         onTap: () {
                //           testRecordCubit.onDispose();
                //         },
                //       )),
                //     ],
                //   ),
                // )
              ],
            )),
      );
    });
  }
}
