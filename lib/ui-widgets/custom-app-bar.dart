// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/components/neu-tadbar-container.dart';
import 'package:untitled/components/neu-text.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final Widget? bottom;
  final Function()? onDrawerIconTapped;
  final Function()? onperonIconTapped;
  final Function()? ongridIconTapped;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.fontSize,
      this.bottom,
      this.onDrawerIconTapped,
      this.ongridIconTapped,
      this.onperonIconTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomNeumoroTabBarContainer(
      child: AppBar(
        backgroundColor: scaffoldMainColor,
        title: PublicNeumoText(
          text: title,
          size: 22,
          color: Colors.black,
        ),
        leading: Builder(
          builder: (cxt) {
            return Center(
              child: InkWell(
                child: const PublicNeumoIcon(
                  size: 32,
                  iconColor: Colors.grey,
                  iconData: Icons.menu,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
          Center(
            child: InkWell(
              child: const PublicNeumoIcon(
                size: 32,
                iconColor: Colors.grey,
                iconData: CupertinoIcons.square_grid_4x3_fill,
              ),
              onTap: ongridIconTapped,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Center(
            child: InkWell(
              child: const PublicNeumoIcon(
                size: 32,
                iconColor: Colors.grey,
                iconData: Icons.person_outline,
              ),
              onTap: () {},
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: bottom!,
        ),
      ),
    );
  }
}

class CustomNewAppBar extends StatelessWidget {
  final String? appBarTitle;
  const CustomNewAppBar({Key? key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: scaffoldMainColor,
      title: PublicNeumoText(
        text: appBarTitle,
        size: 22,
        color: Colors.black,
      ),

      centerTitle: true,
    );
  }
}
