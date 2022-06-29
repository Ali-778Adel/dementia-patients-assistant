import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
 String?userName;
 String?userEmail;
 String?userPhone;
 String?userId;
 String?friends;
 String?deviceToken;

 UserModel({this.userName,this.userEmail,this.userPhone,this.userId,this.friends,this.deviceToken});
 UserModel.fromJson(Map<String,dynamic>json){
   userName=json['userName'];
   userEmail=json['userEmail'];
   userPhone=json['userPhone'];
   userId=json['userId'];
   deviceToken=json['deviceToken'];
 }

 Map<String,dynamic>toMap(){
return {
  'userName':userName,
  'userEmail':userEmail,
  'userPhone':userPhone,
  'userId':userId,
  'deviceToken':'deviceToken'
};
 }

 List<UserModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
   return querySnapshot.docs.map((snapshot) {
     final Map<String, dynamic> dataMap =
     snapshot.data() as Map<String, dynamic>;
     return UserModel(
         userName: dataMap['userName'],
         userEmail: dataMap['userEmail'],
         userId: dataMap['userId'],
         userPhone: dataMap['userPhone'],
       deviceToken: dataMap['deviceToken']

     );
   }).toList();
 }
}