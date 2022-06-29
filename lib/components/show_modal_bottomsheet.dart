import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showBarModalBottomsheet(
    {required BuildContext context, required Widget widget,Function()?onDismissed}) {
  return showBarModalBottomSheet(
      expand: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      context: context,
      builder: (context) {
        return widget;
      });
}
Future showMapModalBottomSheet({required BuildContext context,required Widget mapWidget }){
  return showBarModalBottomSheet(
      expand: true,
      isDismissible: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      context: context,
      builder: (context) {
        return mapWidget;
      });
}

Future showCustomModalBottomsheet(
    {required BuildContext context, required Widget widget}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      constraints:const BoxConstraints(
        minHeight: 220,
        maxHeight: 820
      ),
      context: context,
      builder: (context) {
        return widget;
      });
}
