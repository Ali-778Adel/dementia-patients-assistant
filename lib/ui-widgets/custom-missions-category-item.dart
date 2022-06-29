// ignore_for_file: file_names
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/components/neu-text.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/models/missio-category-item-model.dart';
  class CustomMissionCategoryItem extends StatelessWidget {
  final MissionCategoryItemModel? missionCategoryItemModel;
  final Function()?function;
  final String?name;
  // ignore: use_key_in_widget_constructors
  const CustomMissionCategoryItem({this.missionCategoryItemModel,this.name,this.function}) ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NeumorphicButton(
          child: ClayContainer(
            height: 100,
            width: MediaQuery.of(context).size.width*45,
            color: baseColor,
            depth: 80,
            spread: 2,
            borderRadius: 7.5,
            child: Center(
              child: PublicNeumoText(
                text: missionCategoryItemModel!.catName,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          onPressed:missionCategoryItemModel!.function,
        ),
        const Positioned(
          top:- 5,
          child: PublicNeumoText(
            text: '0',
            color: Colors.black,
            size: 56,
          ),
        )
      ],
    );
  }
}
class CustomMissionCategoryItemButton extends StatelessWidget {
  final MissionCategoryItemModel? missionCategoryItemModel;
  const CustomMissionCategoryItemButton({Key? key,this.missionCategoryItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        NeumorphicButton(
          style: NeumorphicStyle(
            color: baseColor,
            depth: 6,
            shadowDarkColor: Colors.grey,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8))
          ),
          child: Center(
            child: PublicNeumoText(
              text: missionCategoryItemModel!.catName,
              size: 18,
              color: Colors.black,
            ),
          ),
          onPressed:missionCategoryItemModel!.function,

        ),
        const Positioned(
          top:5 ,
          right: 5,
          child: PublicNeumoText(
            text: '1',
            color: Colors.redAccent,
            size:12,
          ),
        )
      ],
    );
  }
}

