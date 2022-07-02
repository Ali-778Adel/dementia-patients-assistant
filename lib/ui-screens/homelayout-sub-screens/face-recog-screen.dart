import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaceRecogScreen extends StatelessWidget{
  const FaceRecogScreen({Key? key}) : super(key: key);



  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await  launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
  return Center(child: TextButton(child:Text('go ahead') ,onPressed: (){
    const url ='https://www.google.com/maps/dir/?api=1&origin=30.4322397,31.4535374&destination=30.4459651,31.4464248&&travelmode=driving&dir_action=navigate';
    _launchURL(url);
  },),);

  }

}