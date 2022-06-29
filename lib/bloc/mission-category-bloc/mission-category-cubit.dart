// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/mission-category-bloc/mission-category-state.dart';
import 'package:untitled/models/missio-category-item-model.dart';

class MissionCategoryCubit extends Cubit<MissionCategoryStates>{
  MissionCategoryCubit ():super(MCSInitState());
  static MissionCategoryCubit get(context)=>BlocProvider.of(context);
  List<MissionCategoryItemModel>missionCategoryItemsList=[];

  onCategoryScreenLaunch(){
    missionCategoryItemsList.insert(0, MissionCategoryItemModel(catId: 0,catName: 'personal',function: (){}));
    missionCategoryItemsList.insert(1, MissionCategoryItemModel(catId: 0,catName: '+',function: (){
      onPlusItemTapped();
    }));
    emit(OnCategoryScreenLaunch());
  }
    onPlusItemTapped(){
      missionCategoryItemsList.insert(missionCategoryItemsList.length - 1,
            MissionCategoryItemModel(catName: 'sports',function: (){}));
      emit(OnPlusItemTappedState());
  }

}