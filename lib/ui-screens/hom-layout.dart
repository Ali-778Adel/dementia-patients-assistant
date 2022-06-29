// ignore_for_file: file_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../bloc/home-layout-bloc.dart';
import '../ui-widgets/custom-app-bar.dart';
import '../ui-widgets/custom-darwer.dart';
import '../ui-widgets/custom-tab-bar.dart';
import 'missions-categories-screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController? tabController;
    return Stack(
      children: [
        const CustomDrawer(),
        BlocBuilder<HomeLayoutCubit, HomeLayoutCubitStates>(
            builder: (context, state) {
          HomeLayoutCubit homLayoutCubit = HomeLayoutCubit.get(context);
          return DefaultTabController(
              initialIndex: homLayoutCubit.tbCurrentIndex,
              length: homLayoutCubit.relatedTabBarWidgets.length,
              child: Scaffold(
                key: homLayoutCubit.scaffoldKey,
                appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 120),
                  child: CustomAppBar(
                    title: 'Mission Man ',
                    ongridIconTapped: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return const MissionsCategoriesScreen();
                          }));
                    },
                    bottom: CustomTabBar(
                      tabController: tabController,
                      function: (int? index) =>
                          homLayoutCubit.onTabBarItemTapped(index: index),
                    ),
                  ),
                ),
                body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children:
                        context.read<HomeLayoutCubit>().relatedTabBarWidgets),
                drawer:const CustomDrawer()
              ));
        }),
      ],
    );
  }
}
// TabBarView(children: context.read<HomeLayoutCubit>().relatedTabBarWidgets);
// PreferredSize(
// preferredSize:const Size(double.infinity,160),
// child: CustomAppBar(title: 'Dementia',
// bottom: BlocBuilder<HomeLayoutCubit,HomeLayoutCubitStates>(
// builder: (context, state) {
// return CustomTabBar(
// tabController: tabController,
// function: (index)=>context.read<HomeLayoutCubit>().onTabBarItemTapped(index: index,context: context,tabController: tabController),
// );
// }
// ),
// ),
//
// ),
