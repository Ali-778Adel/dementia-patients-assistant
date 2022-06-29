import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../ui-widgets/custom-yydialog.dart';

YYDialog CustomRepeatDialog(BuildContext context) {
  return YYDialog().build(context)
    ..height = 250
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..widget(const CustomYYRepeatDialogDialog())
    ..widget(const SizedBox(
      height: 40,
    ))
    ..divider()
    ..doubleButton(
      padding: const EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      text1: "cancel",
      color1: Colors.redAccent,
      fontSize1: 18.0,
      fontWeight1: FontWeight.bold,
      onTap1: () {
        print("ok");
      },
      text2: "ok",
      color2: Colors.redAccent,
      fontSize2: 18.0,
      fontWeight2: FontWeight.bold,
      onTap2: () {
        print("ok");
      },
    )
    ..show();
}
