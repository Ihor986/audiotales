import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundService {
  SoundService();

  final recorder = FlutterSoundRecorder();
  final audioPlayer = FlutterSoundPlayer();
  bool isRecoderReady = false;
  String recordLengthLimitStart =
      DateTime.now().millisecondsSinceEpoch.toString();
  String recordLengthLimitControl =
      DateTime.now().millisecondsSinceEpoch.toString();
  int soundIndex = 0;
  String path = '';
  Uint8List? url;

  _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
  }

  _record() async {
    if (!isRecoderReady) return;
    await recorder.startRecorder(
        toFile: '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
        codec: Codec.defaultCodec);
    recordLengthLimitStart = DateTime.now().millisecondsSinceEpoch.toString();
    recordLengthLimitControl = recordLengthLimitStart;
  }

  _stopRecorder() async {
    if (!isRecoderReady) return;
    final path = await recorder.stopRecorder();
    final audiofile = File(path!);
    url = audiofile.readAsBytesSync();
    recordLengthLimitControl = DateTime.now().millisecondsSinceEpoch.toString();
    print(audiofile);
  }

  disposeRecorder() {
    recorder.closeRecorder();
    audioPlayer.stopPlayer();
    audioPlayer.closePlayer();
  }

  clickRecorder() async {
    if (recorder.isRecording && soundIndex < 2) {
      soundIndex = 2;
      await _stopRecorder();
      // ------------------------------
      soundIndex = 3;
      await audioPlayer.startPlayer(
        fromDataBuffer: url,
        codec: Codec.defaultCodec,
      );
      // ------------------------------
      // } else if (!recorder.isRecording && soundIndex == 2) {
      //   soundIndex = 3;
      //   await audioPlayer.startPlayer(
      //     fromDataBuffer: url,
      //     codec: Codec.defaultCodec,
      //   );
    } else if (!recorder.isRecording && soundIndex == 3) {
      if (!audioPlayer.isPlaying) {
        soundIndex = 3;
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
        );
        return;
      }
      await audioPlayer.stopPlayer();
      soundIndex = 2;
    } else if (!recorder.isRecording && soundIndex == 0) {
      _initRecorder();
      audioPlayer.openPlayer().then((value) {
        isRecoderReady = true;
        _record();
        soundIndex = 1;
      });
    }
  }
}
