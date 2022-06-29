import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/components/neu-tadbar-container.dart';
import 'package:untitled/components/neu-text.dart';
import 'package:untitled/constants/constants.dart';

class CustomNeumorphicButton extends StatelessWidget {
  final String?iconAssetsPath;
  final String? text;
  final Color? buttonBackgroundColor;
  final Function()?function;
  const CustomNeumorphicButton(
      {Key? key, this.iconAssetsPath, this.text, this.buttonBackgroundColor,this.function}) :
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      width: MediaQuery.of(context).size.width*0.90,
      child: NeumorphicButton(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(
            color: buttonBackgroundColor,
            depth: 6,
            shape: NeumorphicShape.concave,
            shadowDarkColor: Colors.white60,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PublicNeumorContainer(
              height: 25,
              width: 25,
              child:Image.asset(iconAssetsPath!,fit: BoxFit.contain,) ,
            ),
            const SizedBox(
              width: 20,
            ),
            PublicNeumoText(
              text: text,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
        onPressed: function,
      ),
    );
  }
}

//public one
class PublicNeumorphicButton extends StatelessWidget {
  final IconData?iconData;
  final String? text;
  final Color? buttonBackgroundColor;
  final Function()?function;
  final Color?buttonTextColor;
  const PublicNeumorphicButton(
      {Key? key, this.iconData, this.text, this.buttonBackgroundColor,this.function,this.buttonTextColor}) :
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      width: MediaQuery.of(context).size.width*0.90,
      child: NeumorphicButton(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        style: NeumorphicStyle(
            color: buttonBackgroundColor,
            depth: 6,
            shape: NeumorphicShape.concave,
            shadowDarkColor: Colors.white60,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PublicNeumoIcon(
              iconData: iconData,
              iconColor: Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
            PublicNeumoText(
              text: text,
              size: 14,
              color: buttonTextColor,
            )
          ],
        ),
        onPressed: function,
      ),
    );
  }
}
class CustomNewMissionButton extends StatelessWidget {
 final IconData ?iconData;
 final String ?text;
 final  Function ()?function;
 final double?width;
 const CustomNewMissionButton({Key? key ,this.width,this.text,this.iconData,this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: NeumorphicButton(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        style:NeumorphicStyle(
            color: onBoardingTextColor,
            depth: 6,
            shape: NeumorphicShape.convex,
            shadowDarkColor: mainColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PublicNeumoIcon(
              iconData: iconData,
              iconColor: Colors.white,

            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              child: PublicNeumoText(
                text: text,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
        onPressed: function,
      ),
    );
  }
}
@immutable
class CustomBottomSheetButton extends StatelessWidget {
 // final IconData ?iconData;
 final String ?text;
 final  Function ()?function;
 final double?width;
 final Color?borderColor;
 final Color?textColor;
 final Color?shadowDarkColor;
 const CustomBottomSheetButton({
   Key? key ,
   this.width,
   this.textColor,
   this.borderColor,
   this.shadowDarkColor,
   this.text,
   this.function}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: NeumorphicButton(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        style:NeumorphicStyle(
            color: Colors.white,
            depth: 2,
            shape: NeumorphicShape.convex,
            shadowDarkColor: shadowDarkColor,
            border: NeumorphicBorder(
              color: borderColor,
              width: 1
            ),
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            PublicNeumoText(
              key: key,
              text: text,
              size: 16,
              color: textColor,
            )
          ],
        ),
        onPressed: function,
      ),
    );
  }
}

class CustomAttachBottomSheetButton extends StatelessWidget {
  final IconData ?iconData;
  final String ?text;
  final  Function ()?function;
  final double?width;
  final Color?borderColor;
  final Color?textColor;
  final Color?shadowDarkColor;
  final Widget?iconWidget;
  const CustomAttachBottomSheetButton({
    Key? key ,
    this.width,
    this.textColor,
    this.borderColor,
    this.shadowDarkColor,
    this.text,
    this.iconData,
    this.iconWidget,
    this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: NeumorphicButton(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        style:NeumorphicStyle(
            color: Colors.white,
            depth: 2,
            shape: NeumorphicShape.convex,
            shadowDarkColor: shadowDarkColor,
            border: NeumorphicBorder(
                color: borderColor,
                width: 1
            ),
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            iconWidget!,
            const SizedBox(
              width: 40,
            ),
            PublicNeumoText(
              text: text,
              size: 16,
              color: textColor,
            )
          ],
        ),
        onPressed: function,
      ),
    );
  }
}


