

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/bloc/auth_cubit/auth-states.dart';
import 'package:untitled/models/user-model.dart';
import 'package:untitled/ui-screens/home-screen-demo.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitState());

  AuthCubit get(context)=>BlocProvider.of(context);

  final googleSignIn =GoogleSignIn();

  GoogleSignInAccount?_user;

  GoogleSignInAccount get user =>_user!;

  Future googleLogin()async{
    final googleUser=await GoogleSignIn().signIn();
    if(googleUser==null)return;
    _user=googleUser;

    final googleAuth=await googleUser.authentication;

    final credential=GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.id);
    print(user.displayName);
    print(user.email);

    emit(LoginState());
  }
   String ?otpcode;
  Future verifyPhoneNumber(String?phoneNumber) async {
    emit(VerifyingPhoneNumberLoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
        // either this occurs or the user needs to manually enter the SMS code
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(VerifyingPhoneNumberErrorState());
        print('error on verification>>>>>>>>>>>>> ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        otpcode = verificationId;
        emit(VerifyingPhoneNumberSuccessState());

      },
      codeAutoRetrievalTimeout: (String verificationId) {
          otpcode = verificationId;
      },

    ).then((value){

    }).catchError((error){
    });
  }

  String?deviceToken;
getDeviceToken()async{
    await FirebaseMessaging.instance.getToken().then((value) {
      deviceToken=value;
    });
}

 Future verifyPhoneCode(String verificationmsg,BuildContext context) async {
    final user=FirebaseAuth.instance.currentUser;
    emit(VerifyingCodeLoadingState());
    final AuthCredential credential =
    PhoneAuthProvider.credential(
      verificationId: otpcode!,
      smsCode: verificationmsg,
    );

    FirebaseAuth.instance.currentUser!
        .linkWithCredential(credential).then((value) {
          createUserCollection(
              userId: value.user!.uid,
              userName:value.user!.email,
              userEmail: value.user!.email,
              userPhone: value.user!.phoneNumber,
              deviceToken:deviceToken
          );

      emit(VerifyingCodeSuccessState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreenDemo()), (route) => false);
    }).catchError((error){
      print('otp is wrong +++++++++++++++++++++${error.toString()}');
      emit(VerifyingCodeErrorState());
    });

  }

  
  createUserCollection({String?userName,String?userEmail,String?userPhone,String?userId,String?friends,String?deviceToken})async{
   UserModel userModel=UserModel(userName: userName,userEmail: userEmail,userPhone: userPhone,userId: userId,friends:friends,deviceToken: deviceToken);
emit(CreateUserCollectionLoadingState());
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .set(userModel.toMap()).then((value) {
      emit(CreateUserCollectionSuccessState());

    }).catchError((error){
      emit(CreateUserCollectionFailureState());

      print('error on creating userCollection ${error.toString()}');
    });
  }

  // String?userId;
  // bool isFriendListEmpty=true;
  // var element ;
  // var targetUid;
  // getTargetUserData({String?phoneNumber})async{
  //   emit(GetUserByPhoneNumberLoadingState());
  //     await FirebaseFirestore
  //         .instance
  //         .collection('users')
  //         .where('userPhone',isEqualTo: '+2$phoneNumber')
  //         .get().then((value) {
  //       var b= value.docs.map((snashot) async{
  //            if(snashot.data().isEmpty){
  //              print('wrong phonenumber');
  //            }else{
  //              print(snashot.data()['userPhone']);
  //            await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
  //                  .update({'friends':snashot.data()['userPhone']});
  //            isFriendListEmpty=false;
  //            element=snashot.data()['userEmail'];
  //            targetUid=snashot.data()['userId'];
  //
  //            }
  //            emit(GetUserByPhoneNumberSuccessState());
  //            // print(b.first);
  //            print(element);
  //           });
  //       print(b.first);
  //
  //
  //     }).catchError((error){
  //       print('error ${error.toString()}');
  //       emit(GetUserByPhoneNumberSuccessState());
  //     });
  //
  //
  //
  //
  // }


  writeMissionsForOtherUsers()async{

  }

  Future logoutGoogleAccount()async{
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
emit(LogoutState());
  }

}