import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


YYDialog customAddingAudioRecordDialog({
  required BuildContext context,
  TextEditingController? notesController,
  Color? iconsColor,
  bool? isRecordPathEmpty,
  Widget? recordWidget,
  required Widget textWidget,
  required Widget stopWidget,
  required Widget pauseResumeWidget,
  required Function() onOkTapped,
  required Function() onCancelTapped,
}) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..widget(Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textWidget,
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                stopWidget,
                const SizedBox(
                  width: 10,
                ),
                pauseResumeWidget,
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (isRecordPathEmpty == false) recordWidget!,
          ],
        )))
    ..widget(const SizedBox(
      height: 40,
    ))
    ..divider()
    ..doubleButton(
      padding: const EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      text1: "ok",
      color1: Colors.redAccent,
      fontSize1: 18.0,
      fontWeight1: FontWeight.bold,
      onTap1: onOkTapped,
      text2: "cancel",
      color2: Colors.redAccent,
      fontSize2: 18.0,
      fontWeight2: FontWeight.bold,
      onTap2: onCancelTapped,
    )
    ..show();
}

Widget buildTimer(String minuteFormat, String secondFormat, Color timerColor) {
  final String minutes = minuteFormat;
  final String seconds = secondFormat;
  return Text(
    '$minutes : $seconds',
    style: TextStyle(color: timerColor),
  );
}

Widget buildText(bool isRecording, bool isPaused, String timerText,
    String minuteFormat, String secondFormat, Color timerColor) {
  if (isRecording || isPaused) {
    return buildTimer(minuteFormat, secondFormat, timerColor);
  }
  return Text(timerText);
}

Future<YYDialog> customAddingAudioRecordDialog1({
  required BuildContext context,

  required Widget dialogBuildWidget,
  required Function() onOkTapped,
  required Function() onCancelTapped,
}) async {
  return   YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..widget(
        dialogBuildWidget
    )
    ..widget(const SizedBox(
      height: 10,
    ))
    ..divider()
    ..doubleButton(
      padding: const EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      text1: "ok",
      color1: Colors.redAccent,
      fontSize1: 18.0,
      fontWeight1: FontWeight.bold,
      onTap1: onOkTapped,
      text2: "cancel",
      color2: Colors.redAccent,
      fontSize2: 18.0,
      fontWeight2: FontWeight.bold,
      onTap2: onCancelTapped,
    )
    ..show();
}
