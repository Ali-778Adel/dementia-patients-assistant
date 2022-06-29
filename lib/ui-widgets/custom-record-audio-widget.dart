// // ignore_for_file: file_names
//
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:clay_containers/widgets/clay_container.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// import '../components/neu-icon.dart';
// import '../constants/constants.dart';
//
// class CustomRecordAudioWidget extends StatelessWidget {
//   final bool isRecording;
//   final bool isPaused;
//   final bool isRecordPathEmpty;
//   final bool isRecordPlaying;
//   final bool inRecordingProcess;
//   final bool isPlaybackActive;
//   final String timerText;
//   final String minuteFormat;
//   final String secondFormat;
//   final String playbackMinutesFormat;
//   final String playbackSecondsFormat;
//    late String recordPath;
//   final int value;
//   final Widget seekWidget;
//   final Function() onStopTapped;
//   final Function() onPauseResumeButtonTapped;
//   final Function() onPlayingIconTapped;
//   // final Function() onOkTapped;
//   // final Function() onCancelTaped;
//   // final Function(double val) onSeekChange;
//    CustomRecordAudioWidget(
//       {Key? key,
//       required this.isRecording,
//       required this.isPaused,
//       required this.isRecordPathEmpty,
//       required this.inRecordingProcess,
//       required this.isPlaybackActive,
//       required this.timerText,
//       required this.minuteFormat,
//       required this.secondFormat,
//       required this.playbackMinutesFormat,
//       required this.playbackSecondsFormat,
//        required this.recordPath,
//       required this.isRecordPlaying,
//       required this.value,
//       required this.seekWidget,
//       required this.onStopTapped,
//       required this.onPauseResumeButtonTapped,
//       required this.onPlayingIconTapped,
//         // required this.onOkTapped,
//         // required this.onCancelTaped,
//       // required this.onSeekChange
//       })
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     Widget buildRecordTimer(){
//       if(inRecordingProcess){
//         return Text('$minuteFormat:$secondFormat');
//       }
//       return const Text('00:00');
//     }
//     Widget buildRecordText(){
//       return buildRecordTimer();
//     }
//     Widget buildPlaybackTimer(){
//       if(isPlaybackActive){
//         return Text('$playbackMinutesFormat:$playbackSecondsFormat');
//       }
//       return const Text('00:00');
//     }
//
//     Widget buildPlaybackText(){
//       return buildPlaybackTimer();
//     }
//     return Container(
//         height: 200,
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child:
//               buildRecordText(
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     child: SizedBox(
//                       height: 40,
//                       width: 40,
//                       child: PublicNeumoIcon(
//                           iconData: Icons.stop_circle,
//                           size: 40,
//                           iconColor: isRecording == false
//                               ? Colors.blue
//                               : scaffoldMainColor),
//                     ),
//                     onTap: onStopTapped,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   InkWell(
//                       child: SizedBox(
//                         height: 40,
//                         width: 40,
//                         child: PublicNeumoIcon(
//                           iconData: isRecording ? Icons.pause : Icons.mic,
//                           iconColor: isRecording ? Colors.blue : Colors.grey,
//                           size: 42,
//                         ),
//                       ),
//                       onTap: onPauseResumeButtonTapped),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             if (isRecordPathEmpty == false)
//               Expanded(
//                 child: ClayContainer(
//                   color: scaffoldMainColor,
//                   borderRadius: 35,
//                   width: double.infinity,
//                   height: 5,
//                   depth: 16,
//                   spread: 2,
//                   child: AudioWidget.file(
//                     path: recordPath,
//                     play: false,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         const Expanded(
//                           child: SizedBox(
//                             width: 2,
//                           ),
//                         ),
//                         InkWell(
//                           child: PublicNeumoIcon(
//                             iconColor:
//                                 isRecordPlaying ? Colors.blue : Colors.black,
//                             iconData: isRecordPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             size: 32,
//                           ),
//                           onTap: onPlayingIconTapped,
//                         ),
//                         const SizedBox(
//                           width: 1,
//                         ),
//                         Expanded(flex: 8, child: seekWidget),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: buildPlaybackText(
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             // SizedBox(height: 20,),
//             //  Expanded(
//             //    child: Row(
//             //     children: [
//             //       Expanded(child: InkWell(child:const Center(child:  Text('Ok'),),onTap:onOkTapped ,)),
//             //       Expanded(child: InkWell(child:const Center(child:  Text('Ok'),),onTap:onCancelTaped,)),
//             //     ],
//             // ),
//             //  )
//           ],
//         ));
//   }
//
// }
