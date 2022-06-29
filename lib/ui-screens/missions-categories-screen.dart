// ignore_for_file: file_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/mission-category-bloc/mission-category-cubit.dart';
import 'package:untitled/bloc/mission-category-bloc/mission-category-state.dart';
import 'package:untitled/components/neu-icon.dart';
import 'package:untitled/constants/constants.dart';
import '../components/neu-text.dart';
import '../ui-widgets/custom-missions-category-item.dart';
class MissionsCategoriesScreen extends StatelessWidget {
  const MissionsCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const PublicNeumoText(
          text: 'Categories',
          color: Colors.black,
          size: 22,
        ),
        centerTitle: true,
        backgroundColor: baseColor,
        leading: Builder(
          builder: (context){
            return Center(
              child: InkWell(
                child: const PublicNeumoIcon(
                  iconData: Icons.arrow_back,
                  size: 22,
                  iconColor: Colors.grey,
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Container(
          margin:  const EdgeInsets.only(top: 60,bottom: 20,left: 10),
          child:const PublicNeumoText(
            text: 'My Lists',
            color: Colors.black,
            size: 20,
          ),
        ),
          Flexible(
            child: BlocBuilder<MissionCategoryCubit,MissionCategoryStates>(
              builder: (context, snapshot) {
                MissionCategoryCubit cubit=MissionCategoryCubit.get(context);
                return 
                  GridView.builder(
                    padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 100),
                    itemCount: cubit.missionCategoryItemsList.length,
                    itemBuilder: (context,index){
                  return CustomMissionCategoryItemButton(
                    missionCategoryItemModel: cubit.missionCategoryItemsList[index],
                  );
                    });
              }
            ),
          )

        ],
      ),
    );
  }
}
