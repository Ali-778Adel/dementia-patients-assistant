
import 'dart:io';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSaveAudio = 'com.example.AAC';

class SoundRecorderService {
  FlutterSoundRecorder? flutterSoundRecorder;
  FlutterSoundPlayer ?flutterSoundPlayer;
  bool isRecordingInitialized=false;
  Directory?tempdir;
  String?recordPath;
  bool get isRecording =>flutterSoundRecorder!.isRecording;

  Future init() async {
  flutterSoundRecorder=FlutterSoundRecorder();
  final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw (RecordingPermissionException('Microphone access is denied'));
    }
    await flutterSoundRecorder!.openAudioSession();
    isRecordingInitialized=true;

  }
  void dispose(){
    if(!isRecordingInitialized)return;
   flutterSoundRecorder!.closeAudioSession();
   flutterSoundRecorder=null;
   isRecordingInitialized=false;
  }

  Future record() async {
    if(!isRecordingInitialized)return;
    tempdir = await getTemporaryDirectory();
    recordPath = '${tempdir?.path}/flutter_sound.aac';
    await flutterSoundRecorder!.startRecorder(toFile: recordPath, codec: Codec.aacADTS);
    print(recordPath);
  }

  Future stop() async {
    if(!isRecordingInitialized)return;
   String? url= await flutterSoundRecorder!.stopRecorder();
    print(url);
    await flutterSoundPlayer?.startPlayer(fromURI: url,codec: Codec.aacADTS);
  }
  Future toggleRecording() async {
    if (flutterSoundRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}
