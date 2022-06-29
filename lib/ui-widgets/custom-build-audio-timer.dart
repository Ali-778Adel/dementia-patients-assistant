
import 'package:flutter/cupertino.dart';

class BuildRecordTimer extends StatelessWidget{
  final bool isRecording;
  final String minuteFormat;
  final String secondFormat;

  const BuildRecordTimer({Key? key,required this.isRecording,required this.minuteFormat,required this.secondFormat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isRecording) {
      return Text('$minuteFormat:$secondFormat');
    }
    return const Text('00:00');
  }

}
class BuildPlaybackTimer extends StatelessWidget{
  final bool isPlaying;
  final String minuteFormat;
  final String secondFormat;

  const BuildPlaybackTimer({Key? key,required this.isPlaying,required this.minuteFormat,required this.secondFormat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isPlaying) {
      return Text('$minuteFormat:$secondFormat');
    }
    return const Text('00:00');
  }

}