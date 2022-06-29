import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';


class TestRecordService {
  Record? soundRecorder;
  bool isMicPermissionGranted = false;
  String recordUri='com.example.m4a';



  Future init() async {
    soundRecorder = Record();
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw (Exception('microphone permission has denied'));
    }
    isMicPermissionGranted = true;
  }

  void dispose() {
    soundRecorder?.dispose();
  }

  Future startRecording() async {
    if(!isMicPermissionGranted)return;
   await soundRecorder?.start();
  }

  Future stopRecording() async {
    if(!isMicPermissionGranted)return;
 final path=  await soundRecorder?.stop().catchError((error){
     throw(Exception('error on stop record and extract audio record path ${error.toString()}'));
   });
   recordUri=path!;

  }
  Future resumeRecording() async {
    if(!isMicPermissionGranted)return;
    await soundRecorder?.resume();
  }
  Future pauseRecording() async {
    if(!isMicPermissionGranted)return;
    await soundRecorder?.pause();

  }




  Future toggleResumePauseRecording(bool isRecording)async{
    if( isRecording){
      isRecording=false;
      pauseRecording();
    }else{
      isRecording=true;
      resumeRecording();
    }
  }


}
