import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundService {
  SoundService();

  final recorder = FlutterSoundRecorder();
  final audioPlayer = FlutterSoundPlayer();
  bool isRecoderReady = false;
  bool isPlaying = false;
  String path = '';
  Uint8List? url;

  stopRecorder() async {
    if (!isRecoderReady) return;
    final path = await recorder.stopRecorder();

    final audiofile = File(path!);
    url = audiofile.readAsBytesSync();
    // toString();
    print(audiofile);
  }

  record() async {
    if (!isRecoderReady) return;
    await recorder.startRecorder(
        toFile: '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
        codec: Codec.defaultCodec);
  }

  initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    // isRecoderReady = true;
  }

  clickRecorder() async {
    if (recorder.isRecording) {
      await stopRecorder();
    } else {
      await record();
    }
  }
}
