import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'neu-button.dart';

 YYDialog customMissionAddNotesDialog(
{
  required BuildContext context,
  required TextEditingController notesController,
  required Function() onOkTapped,
  required Function () onCancelTapped,
}
     ){
   return YYDialog().build(context)
     ..width = MediaQuery.of(context).size.width * .85
     ..borderRadius = 25
     ..backgroundColor = Colors.white
     ..widget( Container(
       margin: const EdgeInsets.all(10),
       child: TextField(
         controller:notesController,
         enableIMEPersonalizedLearning: true,
         decoration:const InputDecoration(
           hintText: 'Add mission description',
           hintStyle: TextStyle(
             color: Colors.grey,
             fontSize: 18,
             fontWeight: FontWeight.w400
           )
         ),
         style:const TextStyle(
           color: Colors.black,
           fontSize: 18,
           fontWeight: FontWeight.w400,

         ),
         maxLines: 10,),
     ))
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

YYDialog customMissionAlertDialog(
    {
      required BuildContext context,
      required String?alertText,
      required Function() onOkTapped,
      required Function () onCancelTapped,
    }
    ){
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..widget( Container(
      margin: const EdgeInsets.all(10),
      child: Center(child: Text('$alertText',style:const TextStyle(color: Colors.red,fontSize: 18,),))
    ))
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


YYDialog customMissionControlDialog(
    {
      required BuildContext context,
      required Function() onDoneTapped,
      required Function () onArchiveTapped,
    }
    ){
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white.withOpacity(.01)
    ..widget( Container(
        color: Colors.transparent.withOpacity(.01),
      padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Center(child: Row(
          children: [
            Expanded(child: CustomBottomSheetButton(text: 'mark as done',textColor: Colors.black,borderColor: Colors.black,function:onDoneTapped ,)),
            Expanded(child: CustomBottomSheetButton(text: 'mark as archived',textColor: Colors.black,borderColor: Colors.black,function:onArchiveTapped ,)),
          ],

        ))
    )
   )..show();
}