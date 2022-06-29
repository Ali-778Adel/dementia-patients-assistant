import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
@immutable
class CustomNeumoText extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomNeumoText({Key? key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      text!,
      textAlign: TextAlign.center,
      style: NeumorphicStyle(
          color: color,
          depth: 10,
          shape: NeumorphicShape.concave,
          shadowDarkColor: Colors.black,
          border: const NeumorphicBorder(color: Colors.grey, width: 1),
          boxShape: const NeumorphicBoxShape.circle()),
      textStyle: NeumorphicTextStyle(
        fontSize: 14,
      ),
    );
  }
}
@immutable
class PublicNeumoText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final TextAlign?align;
  const PublicNeumoText({Key? key, this.text, this.color, this.size,this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicText(
      text!,
      textAlign: align??TextAlign.center,
      style: NeumorphicStyle(
          color: color,
          depth: 8,
          shape: NeumorphicShape.concave,
          shadowDarkColor: Colors.black,
          border: NeumorphicBorder(color: color, width: 1),
          boxShape:const NeumorphicBoxShape.circle()),
      textStyle: NeumorphicTextStyle(
        fontSize: size!,
        letterSpacing: .5,
        // height: 2,
        fontWeight: FontWeight.w100,
      ),
    );
  }
}

