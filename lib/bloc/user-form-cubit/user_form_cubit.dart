
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/user-form-cubit/user_form_states.dart';

import '../../ui-widgets/form-widgets/contact_info.dart';
import '../../ui-widgets/form-widgets/health_profile.dart';
import '../../ui-widgets/form-widgets/location_info.dart';
import '../../ui-widgets/form-widgets/personal_info_widget.dart';
import '../../ui-widgets/form-widgets/user_education_profile.dart';

class UserFormCubit extends Cubit<UserFormStates> {
  UserFormCubit() : super(UFInitialState());
  static UserFormCubit get(context) => BlocProvider.of(context);
  var ageController = TextEditingController();
  String dropDownIntialVal = 'Choose number of children you have';
  List<String> deopDownItemsList = [
    'Choose number of children you have',
    '1',
    '2',
    '3',
    'more than 3 children'
  ];

  void ondropDownItemChanged(String? newValue) {
    dropDownIntialVal = newValue!;
    print(newValue);
    emit(onDropDownValueChangedState());
  }

//  bool valu = false;
//  int val=-1;
//  List<int> radioValues = [-1,-1];
//  List<Map<String, dynamic>> radioList = [];
//  void x({var value, int? index}) {
//    radioValues[index!]=value!;
//    print(radioValues[index]);
//    val = value;
//    print(this.val);
//    valu = true;
//    emit(onRadioListTleSelectedState());
//  }
//

//  int value=-1;
//  List<String>titles=['yes','no'];
//  void onRadioTapped({int ? radioValue}){
//    value=radioValue!;
//    emit(onRadioListTleSelectedState());
//
//  }
  int? groupValue;
  Map<String, dynamic> radioQuestion = {
    'row1': 'Do you have a wife',
    'row2': 'Do you have a sons',
    'row3': 'Do you have a daughters',
    'row4': 'Do you have a family',
    'row5': 'Do you have a partners',
    'row6': 'Do you have a friends',
    'row7': 'Do you have a girlfried',
    'row8': 'Do you have a anythingelse',
  };

  int value = -1;
  int? rowNumber = 1;
  List<int>? rowsv = [];
  String qText = 'Do you have a wife';
  List<String> titless = ['yes', 'no'];
  Map<dynamic, dynamic>? chosenRadio;
  List<int>? chosenRadioListTle;
  void onRadioTapped({int? radioValue}) {
    value = radioValue!;
    if (value == 1) {
      rowsv!.add(value);
    }

    emit(onRadioListTleSelectedState());
  }

  //newForm
  var pageViewController = PageController();
  static var personalInfoFormKey = GlobalKey<FormState>();
  static var userEducationFormKey = GlobalKey<FormState>();
  static var userContactInfoFormKey = GlobalKey<FormState>();
  static var userLocationInfoFormKey = GlobalKey<FormState>();
  static var userHealthProfileInfoFormKey = GlobalKey<FormState>();

  List<String> titles = [
    'Personal Information',
    'Education Profile',
    'Contact Information',
    'Location Information',
    'Health Profile',
    'activity Information',

  ];

  static Map<String, dynamic> formTextEditingController = {
    'personalInfoTextEditigController': [
      {
        'nameController': TextEditingController(),
        'ageController': TextEditingController(),
        'locationController': TextEditingController(),
        'phoneNumberController': TextEditingController(),
        'nationalPhoneNumberController': TextEditingController(),
      }
    ],
    'educationalProfileTEC': [
      {
        'collegeC': TextEditingController(),
        'graduationYearC': TextEditingController(),
        'educationalBackgroundC': TextEditingController(),
        'carrerInfoC': TextEditingController(),
      }
    ],
    'ContactInfoTEC': [
      {
        'mobileNumberC': TextEditingController(),
        'frequentlyCallMobileNumC': TextEditingController(),
      }
    ],
    'locationInfoTEC': [
      {
        'addressC': TextEditingController(),
        'frequentlyvisitedplaceC': TextEditingController(),
      }
    ],
    'healthProfileTEC': [
      {
        'chronicDiseasesC': TextEditingController(),
        'frequentlyvisitedplaceC': TextEditingController(),
      }
    ],
  };

  List<Widget> pageViewScreens = [
    const PersonalInfoWidget(),
    const UserEducationProfile(),
    const ContactInfo(),
    const LocationInfo(),
    const UserHealthProfile(),
    const Scaffold(),
  ];

  int currentIndex = 0;
  void onPagechanged({int? index}) {
    currentIndex = index!;
    emit(UFOnPageViewChanged());
  }

  int? nextIndex;
  void onSubmit({BuildContext ?context}) {
    if (currentIndex == 0) {
      if (personalInfoFormKey.currentState!.validate()) {
        pageViewController.nextPage(
            duration: const Duration(milliseconds: 1050),
            curve: Curves.easeOutBack);
      }
    } else if (currentIndex == 1) {
      if (userEducationFormKey.currentState!.validate()) {
        pageViewController.nextPage(
            duration: const Duration(milliseconds: 1050),
            curve: Curves.easeOutBack);
      }
    } else if (currentIndex == 2) {
      if (userContactInfoFormKey.currentState!.validate()) {
        pageViewController.nextPage(
            duration: const Duration(milliseconds: 1050),
            curve: Curves.easeOutBack);
      }
    } else if (currentIndex == 3) {
      if (userLocationInfoFormKey.currentState!.validate()) {
        pageViewController.nextPage(
            duration: const Duration(milliseconds: 1050),
            curve: Curves.easeOutBack);
      }
    } else if (currentIndex == 4) {
      if (userHealthProfileInfoFormKey.currentState!.validate()) {
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
            {
              'userName':'${formTextEditingController['personalInfoTextEditigController']['nameController']}',
            }
        );
      }

    }
    emit(UFOnSubmitState());
  }
}
