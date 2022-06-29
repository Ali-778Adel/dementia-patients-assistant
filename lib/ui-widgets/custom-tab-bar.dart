import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/components/neu-text.dart';

class CustomTabBar extends StatelessWidget {
  TabController? tabController;
  Function(int?)? function;
  CustomTabBar({Key? key, this.tabController, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        physics: const BouncingScrollPhysics(),
        indicatorColor: Colors.black,
        controller: tabController,
        onTap: function,
        tabs:  const [
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.home,),
            child:CustomNeumoText(text:'home' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.clipboardList,),
            child:CustomNeumoText(text:'daily mission' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.checkCircle,),
            child:CustomNeumoText(text:'done missions' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.archive,),
            child:CustomNeumoText(text:'archeived missions' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.archive,),
            child:CustomNeumoText(text:'your network' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.archive,),
            child:CustomNeumoText(text:'remind locations' ,),
          ),
          Tab(
            icon: CustomNeumoIcon(iconData: FontAwesomeIcons.map,),
            child:CustomNeumoText(text:'loacted missions' ,),
          ),        ]);
  }
}
