import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerService {
  AssetsAudioPlayer? assetsAudioPlayer;

  Future initAudioPlayer() async {
    assetsAudioPlayer = AssetsAudioPlayer();
    // if(assetsAudioPlayer.)
  }
  void dispose(){
    assetsAudioPlayer?.dispose();
  }

  Future playAudio() async {
    await assetsAudioPlayer?.play();
  }

  Future pauseAudio() async {
    await assetsAudioPlayer?.pause();
  }

  Future openAudioFile(String audioPath) async {
    await assetsAudioPlayer?.open(Audio.file(audioPath), autoStart: true).
    catchError((error){
      throw(Exception('error on opening  audio record path ${error.toString()}'));
    });
  }

  Future stopAudio() async {
    await assetsAudioPlayer?.stop();
  }
  // get currentPosition=>assetsAudioPlayer?.currentPosition;

  Future onAudioSliderChanged({required double value,required int recordDuration,required int playbackDuration})async{
    await assetsAudioPlayer!.seek(Duration(seconds: (value).toInt()));
    value = value;
    double v = recordDuration - value;
    playbackDuration = v.toInt();
  }

}
