import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/ui-screens/google-maps-screen.dart';
import 'package:untitled/ui-screens/homelayout-sub-screens/daily-missions-screen.dart';
import 'package:untitled/ui-screens/homelayout-sub-screens/weekdays-screen.dart';
import 'package:untitled/ui-screens/test-screen.dart';
import 'package:untitled/ui-widgets/custom-app-bar.dart';
import 'package:untitled/ui-widgets/home-gridniew-item.dart';

import '../face-detection/face-detector-page.dart';
import '../tflite/ui/home_view.dart';
import '../ui-widgets/custom-darwer.dart';
import 'homelayout-sub-screens/face-recog-screen.dart';
import 'homelayout-sub-screens/your-network-screen.dart';



class HomeScreenDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(child:CustomNewAppBar(appBarTitle: 'Home',) ,preferredSize: Size(double.infinity,60),)
      ,drawer: Drawer(child:const CustomDrawer() ,width: MediaQuery.of(context).size.width*.60,),
    body: GridView(
      physics:const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          mainAxisExtent: 300,

        ),
       children: [
         GridviewItem(imagePath: 'assets/home-screen-images/yourrReminder.png',widgetText: 'schedule your moments',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const DailyMissionScreen())),),
         GridviewItem(imagePath: 'assets/home-screen-images/weekdaysScheduling.png',widgetText: 'shcdule your weekdays',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> WeekdaysMissionScreen()))),
         GridviewItem(imagePath: 'assets/home-screen-images/networkContacts.png',widgetText: 'your communications',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> UserNetworkScreen()))),
         GridviewItem(imagePath: 'assets/home-screen-images/whereIAm.png',widgetText: 'where i am now',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMapsScreen()))),
         GridviewItem(imagePath: 'assets/home-screen-images/faceRecognition.png',widgetText:'who is this? ',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView()))),
         GridviewItem(imagePath: 'assets/home-screen-images/faceDetection.png',widgetText:'?discover things ',onItemTapped: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const FaceDetectorPage()))),
       ],
        ),
    );

  }

}