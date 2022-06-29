// // ignore_for_file: file_names
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:clay_containers/clay_containers.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:untitled/components/neu-icon.dart';
// import 'package:untitled/components/neu-text.dart';
// import 'package:untitled/constants/constants.dart';
//
// class CustomAudioPlayerWidget extends StatelessWidget {
//   final String audioPath;
//   final bool isRecordPlaying;
//   final double value;
//   final Function() onPlayingIconTapped;
//   const CustomAudioPlayerWidget(
//       {Key? key,
//       required this.audioPath,
//       required this.value,
//       required this.onPlayingIconTapped,
//       required this.isRecordPlaying})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClayContainer(
//       color: scaffoldMainColor,
//       borderRadius: 15,
//       width: double.infinity,
//       height: 5,
//       depth: 16,
//       spread: 2,
//       child: AudioWidget.file(
//         path: audioPath,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             const Expanded(
//               child: SizedBox(
//                 width: 2,
//               ),
//             ),
//             InkWell(
//               child: PublicNeumoIcon(
//                 iconColor:isRecordPlaying? Colors.blue:Colors.black,
//                 iconData: isRecordPlaying ? Icons.pause : Icons.play_arrow,
//                 size: 20,
//               ),
//               onTap: onPlayingIconTapped,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             Expanded(
//               flex: 4,
//               child: LinearProgressIndicator(
//                 value: value,
//                 color: isRecordPlaying ? Colors.blue : Colors.black,
//               ),
//             ),
//             const SizedBox(
//               width: 2,
//             ),
//             Expanded(
//               child: PublicNeumoText(
//                 text: '$value',
//                 size: 12,
//                 color: isRecordPlaying ? Colors.blue : Colors.black,
//                 align: TextAlign.center,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
