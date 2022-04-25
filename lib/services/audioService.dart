import 'dart:async';
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
  String recorderTime = '00:00:00';
  // StreamSubscription _recorderSubscription = recorder.onProgress!.listen((event) { }) ;

  _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(Duration(seconds: 1));
  }

  // i() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw 'Microphone permission not granted';
  //   }
  //   await recorder.openRecorder();
  //   await recorder.setSubscriptionDuration(Duration(milliseconds: 10));
  //   audioPlayer.openPlayer().then((value) async {
  //     isRecoderReady = true;
  //     if (!isRecoderReady) return;
  //     await recorder.startRecorder(
  //         toFile: '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
  //         codec: Codec.defaultCodec);
  //     recordLengthLimitStart = DateTime.now().millisecondsSinceEpoch.toString();
  //     recordLengthLimitControl = recordLengthLimitStart;
  //     recorder.onProgress!.listen((e) {
  //       DateTime date = DateTime.fromMillisecondsSinceEpoch(
  //           e.duration.inMilliseconds,
  //           isUtc: true);
  //       String txt = '$date';
  //       recorderTime = txt.substring(11, 19);
  //       print(recorderTime);
  //     });
  //     soundIndex = 1;
  //   });
  // }

  _startRecord() {
    _initRecorder();
    audioPlayer.openPlayer().then((value) {
      isRecoderReady = true;
      _record();
      // _startTimer();
      soundIndex = 1;
    });
  }

  _record() async {
    if (!isRecoderReady) return;
    await recorder.startRecorder(
        toFile: '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
        codec: Codec.defaultCodec);
    recordLengthLimitStart = DateTime.now().millisecondsSinceEpoch.toString();
    recordLengthLimitControl = recordLengthLimitStart;
  }

  _startTimer() {
    recorder.onProgress!.listen((e) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);
      String txt = '$date';
      recorderTime = txt.substring(11, 19);
      print(recorderTime);
    });
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
    if (!recorder.isRecording && soundIndex == 0) {
      _startRecord();
      // i();
    } else if (recorder.isRecording && soundIndex < 2) {
      soundIndex = 2;
      await _stopRecorder();
      recorder.onProgress!.listen((event) {}).cancel();
      // ------------------------------
      soundIndex = 3;
      await audioPlayer.startPlayer(
        fromDataBuffer: url,
        codec: Codec.defaultCodec,
      );
      // ------------------------------
    } else if (!recorder.isRecording && soundIndex == 3) {
      if (!audioPlayer.isPlaying) {
        soundIndex = 3;
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
        );
        return;
      }
      await disposeRecorder();
      soundIndex = 2;
    }
  }
}
