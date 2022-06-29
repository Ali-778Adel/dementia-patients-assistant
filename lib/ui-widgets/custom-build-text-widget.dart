import 'package:flutter/cupertino.dart';
import 'package:untitled/ui-widgets/custom-build-audio-timer.dart';

class BuildRecordText extends StatelessWidget{
  final bool isRecording;
  final String minuteFormat;
  final String secondFormat;
  const BuildRecordText({Key? key,required this.isRecording,required this.minuteFormat,required this.secondFormat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return BuildRecordTimer(isRecording: isRecording, minuteFormat: minuteFormat, secondFormat: secondFormat);
  }

}

class BuildAudioText extends StatelessWidget{
  final bool isPlaying;
  final String minuteFormat;
  final String secondFormat;
  const BuildAudioText({Key? key,required this.isPlaying,required this.minuteFormat,required this.secondFormat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildPlaybackTimer(isPlaying: isPlaying, minuteFormat: minuteFormat, secondFormat: secondFormat);
  }

}