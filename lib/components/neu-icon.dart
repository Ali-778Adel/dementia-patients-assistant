import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/constants/constants.dart';

class CustomNeumoIcon extends StatelessWidget {
  final IconData? iconData;
  const CustomNeumoIcon({Key? key, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicIcon(iconData!,
        size:20,
        style: const NeumorphicStyle(
          color:Colors.white60,
            depth:4,
            shape: NeumorphicShape.concave,
            shadowDarkColor:Colors.white60,
            border: NeumorphicBorder(
              color: Colors.grey,
              width: 1
            ),

            boxShape: NeumorphicBoxShape.circle()));
  }
}
class PublicNeumoIcon extends StatelessWidget {
  final IconData? iconData;
  final Color?iconColor;
  final double ?size;
  const PublicNeumoIcon({Key? key, this.iconData,this.iconColor,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicIcon(iconData!,
        size:size??20,
        style:  NeumorphicStyle(
            color:Colors.white60,
            depth:8,
            shape: NeumorphicShape.convex,
            shadowDarkColor:baseColor,
            border: NeumorphicBorder(
                color: iconColor,
                width: 1
            ),
            boxShape: const NeumorphicBoxShape.circle()));
  }
}

