import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/constants/constants.dart';

var lightTheme=const NeumorphicThemeData(
baseColor:baseColor ,
  appBarTheme: NeumorphicAppBarThemeData(
    color: unSelectedColor,
    centerTitle: true,
    buttonStyle: NeumorphicStyle(
      color: unSelectedColor,
      depth: 20,
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.circle()
    ),
    iconTheme: IconThemeData(
      color: Colors.grey,
      size: 22,

    )
    // iconTheme: IconThemeData(color: Colors.black54),
    // // buttonPadding:  EdgeInsets.all(10),
    // icons: NeumorphicAppBarIcons(menuIcon: Icon(Icons.menu)
    // ),
    //


  ),

  textTheme:TextTheme(
   displayMedium:TextStyle(

   )
  )

);
//FlexColor.materialLightScaffoldBackground