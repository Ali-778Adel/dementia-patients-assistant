// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:untitled/bloc/auth_cubit/auth_cubit.dart';
import 'package:untitled/components/neu-button.dart';
import 'package:untitled/constants/constants.dart';

import '../bloc/auth_cubit/auth-states.dart';

class VerifyingPhoneNumberScreen extends StatelessWidget {
  var numberTextController = TextEditingController();
  var verifyingOtpController = TextEditingController();
  VerifyingPhoneNumberScreen({Key? key}) : super(key: key);
  String? get errorTextForPhone {
    if (numberTextController.text.isEmpty) {
      return "phone number can't be null";
    } else {
      if (numberTextController.text.length != 11) {
        return 'not valid phone number ';
      }
      return null;
    }
  }

  String? get errorTextForOtp {
    if (verifyingOtpController.text.isEmpty) {
      return "otp number can't be null";
    } else {
      if (numberTextController.text.length != 6) {
        return 'it must be 6 numbers';
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: const Text('Verifying Phone Number'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthStates>(builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: numberTextController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'enter your phone number  ex:01023.....',
                      errorText: errorTextForPhone),
                  onChanged: (_) {
                    context
                        .read<AuthCubit>()
                        .emit(OnTextFieldValidationChange());
                  },
                ),
                Container(
                  child: context.read<AuthCubit>().state is VerifyingPhoneNumberLoadingState?
                    const Center(child: CircularProgressIndicator(),):
                  CustomNewMissionButton(
                    text: 'send message',
                    iconData: Icons.add,
                    width: 250,
                    function: () {
                      if (errorTextForPhone==null){
                        context
                            .read<AuthCubit>()
                            .verifyPhoneNumber(numberTextController.text).then((value) {
                          verifyingOtp(context: context,
                              widget: Container(
                                height: 150,
                                margin: const EdgeInsets.only(top:10),
                                padding: const EdgeInsets.all(10),
                                child: Center(child: TextFormField(
                                  controller:verifyingOtpController ,
                                  decoration: InputDecoration(
                                      hintText: 'enter the received message ',
                                      errorText:errorTextForOtp
                                  ),
                                  onChanged: (_){
                                    context.read<AuthCubit>().emit(OnTextFieldValidationChange());
                                  },
                                ),),
                              ),

                              onOkTapped: (){
                              context.read<AuthCubit>().verifyPhoneCode(verifyingOtpController.text, context);
                              }

                          );
                        });

                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
YYDialog verifyingOtp({
  required BuildContext context,
  required Widget widget,
  required Function()onOkTapped,
}){
  return YYDialog().build(context)
    ..height = 250
    ..width = MediaQuery.of(context).size.width * .85
    ..borderRadius = 25
    ..backgroundColor = Colors.white
    ..barrierDismissible=false
    ..widget(
      widget
    )..divider()..doubleButton(
      padding: const EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      text1: "add another number",
      color1: Colors.redAccent,
      fontSize1: 16.0,
      fontWeight1: FontWeight.normal,
      onTap1: () {
        Navigator.pop(context);
      },
      text2: "confirm",
      color2: Colors.redAccent,
      fontSize2: 16.0,
      fontWeight2: FontWeight.normal,
      onTap2:onOkTapped
    )..show(15.2,14.2);
}
