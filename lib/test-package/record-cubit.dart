import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/services/audio-player-service.dart';
import 'package:untitled/test-package/records-service.dart';

class TestRecordCubit extends Cubit<TestRecordStates> {
  TestRecordCubit() : super(TRSInitState());
  static TestRecordCubit get(context) => BlocProvider.of(context);
  final testRecordService = TestRecordService();
  final audioPlayerService = AudioPlayerService();
  bool isRecording = false;
  bool isPlaying = false;
  bool isRecordPathEmpty = true;
  bool isFromDatabase = false;
  String recordUri = 'com.example.aac';
  int recordDuration = 0;
  int audioDuration = 0;
  int playbackDuration = 0;
  Timer? playbackTimer;
  Timer? recordTimer;
  Duration? position;

  void onInit() {
    audioPlayerService.initAudioPlayer();
    testRecordService.init();
    emit(TRSInitState());
  }

  void onDispose() {
    testRecordService.dispose();
    audioPlayerService.dispose();
    isPlaying = false;
    isRecordPathEmpty = true;
    audioDuration = 0;
    deleteFile();
    emit(CloseState());
    onInit();
  }

  void onConfirm() {
    audioDuration = recordDuration;
    emit(OnConfirmState());
  }

  void startRecordTimer() {
    recordTimer?.cancel();
    recordTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      recordDuration++;
      emit(RecordTimerState());
    });
  }

  onStartRecoding() {
    if (isRecording) {
      recordTimer?.cancel();
      testRecordService.pauseRecording();
      isRecording = false;
    } else {
      if (recordDuration == 0) {
        onDispose();
        startRecordTimer();
        testRecordService.startRecording();
        isRecording = true;
      } else {
        startRecordTimer();
        isRecording = true;
        testRecordService.resumeRecording();
      }
      emit(ToggleResumePauseState());
    }
    emit(StartRecordingState());
  }

  onStopRecording() async {
    if (isRecording == false) {
      recordUri = (await testRecordService.soundRecorder?.stop())!;
      if (recordUri == 'com.example.m4a') {
        isRecordPathEmpty = true;
        emit(StopRecordingStateWithNullPath());
      } else {
        recordTimer?.cancel();
        isRecordPathEmpty = false;
        playbackDuration = recordDuration;
        audioDuration = recordDuration;
        recordDuration = 0;
        emit(StopRecordingStateWithoutNullPath());
      }
    }
  }

  void startPlaybackTimer() {
    if (!isFromDatabase) {
      playbackTimer?.cancel();
      playbackTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      playbackDuration--;
      if (playbackDuration == 0) {
        playbackTimer?.cancel();
        playbackDuration = audioDuration;
        isPlaying = false;
      }
      emit(PlaybackTimerState());
    });}
    if (isFromDatabase) {
      playbackTimer?.cancel();
      playbackTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        playbackDuration--;
            if (playbackDuration == 0) {
              playbackTimer?.cancel();
              playbackDuration=audioDuration;
              isPlaying = false;
            }
            emit(PlaybackTimerState());
          });

    }
  }

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  onPlayingAudio() async {
    if (audioPlayerService.assetsAudioPlayer!.currentPosition.value.inSeconds
            .toInt() ==
        0) {
      startPlaybackTimer();
      audioPlayerService.openAudioFile(recordUri);
      isPlaying = true;
      emit(AudioPlayerStartState());
    } else {
      if (isPlaying) {
        playbackTimer?.cancel();
        audioPlayerService.pauseAudio();
        isPlaying = false;
      } else {
        startPlaybackTimer();
        audioPlayerService.playAudio();
        isPlaying = true;
        emit(AudioPlayerResumeState());
      }
    }
    emit(PlayAudioState());
  }

  initAudioPlayer(String?path){

    audioPlayerService.initAudioPlayer();
    audioPlayerService.openAudioFile(path!);
    print('iam initing audio player ');
    
  }

  onPlayingDatabaseAudioPath({String? path}) {
    isFromDatabase = true;
    // initAudioPlayer(path!);
    if (audioPlayerService.assetsAudioPlayer!.currentPosition.value.inSeconds.toInt() == 0) {
      audioPlayerService.openAudioFile(path!).then((value) {
        isPlaying = true;
        audioDuration=audioPlayerService.assetsAudioPlayer!.current.value!.audio.duration.inSeconds;
        playbackDuration=audioDuration;
        startPlaybackTimer();
        emit(AudioPlayerStartState());
      });
    } else {
      if (isPlaying) {
        playbackTimer?.cancel();
        audioPlayerService.pauseAudio();
        isPlaying = false;
      } else {
        startPlaybackTimer();
        audioPlayerService.playAudio();
        isPlaying = true;
        emit(AudioPlayerResumeState());
      }
    }
    emit(PlayAudioState());
  }

  onAudioSliderChanged(double val) async {
    await audioPlayerService.assetsAudioPlayer!
        .seek(Duration(seconds: (val).toInt()));
    val = val;
    double v = audioDuration - val;
    playbackDuration = v.toInt();
    emit(AudioSliderChangeState());
  }

  Future<String> get localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    return File(recordUri);
  }

  Future<dynamic> deleteFile() async {
    try {
      final file = await localFile;
      await file.delete();
      throw ('path deleted successfully');
    } catch (e) {
      throw (Exception('error on deleting record path $e'));
    }
  }
}

class TestRecordStates {}

class TRSInitState extends TestRecordStates {}

class DisposeState extends TestRecordStates {}

class RecordTimerState extends TestRecordStates {}

class PlaybackTimerState extends TestRecordStates {}

class StartRecordingState extends TestRecordStates {}

class ToggleResumePauseState extends TestRecordStates {}

class StopRecordingStateWithoutNullPath extends TestRecordStates {}

class StopRecordingStateWithNullPath extends TestRecordStates {}

class PlayAudioState extends TestRecordStates {}

class AudioPlayerStartState extends TestRecordStates {}

class AudioPlayerPauseState extends TestRecordStates {}

class AudioPlayerResumeState extends TestRecordStates {}

class AudioSliderChangeState extends TestRecordStates {}

class OnConfirmState extends TestRecordStates {}

class CloseState extends TestRecordStates {}
