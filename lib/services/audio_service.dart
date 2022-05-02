// import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundService {
  SoundService();

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  bool isRecoderReady = false;
  int limit = 0;
  String recordLengthLimitStart =
      DateTime.now().millisecondsSinceEpoch.toString();
  String recordLengthLimitControl =
      DateTime.now().millisecondsSinceEpoch.toString();
  int soundIndex = 0;
  Uint8List? url;
  String recorderTime = '00:00:00';
  double recorderPower = 0;
  int sliderPosition = 0;
  int endOfSliderPosition = 1;

  String sliderPositionText = '00:00:00';
  String endOfSliderPositionText = '00:00:01';

  clickRecorder() async {
    if (!recorder.isRecording && soundIndex == 0) {
      _startRecord();
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
      _showPlayerProgres();
      // ------------------------------
    } else if (!recorder.isRecording && soundIndex == 2) {
      soundIndex = 3;
      await audioPlayer.startPlayer(
        fromDataBuffer: url,
        codec: Codec.defaultCodec,
      );
      _showPlayerProgres();
    } else if (!recorder.isRecording && soundIndex == 3) {
      if (!audioPlayer.isPlaying) {
        soundIndex = 3;
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
        );
        _showPlayerProgres();
        return;
      }
      audioPlayer.stopPlayer();
      soundIndex = 2;
    }
  }

  _startRecord() {
    _initRecorder();
    _record();
    _startTimer();
    soundIndex = 1;
  }

  _initRecorder() async {
    await audioPlayer.openPlayer().then((value) {
      isRecoderReady = true;
    });
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(const Duration(seconds: 1));
    await audioPlayer
        .setSubscriptionDuration(const Duration(milliseconds: 1000));
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
      int vol = e.decibels!.toInt();
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);
      limit = e.duration.inSeconds;
      endOfSliderPosition = e.duration.inSeconds;
      String txt = '$date';
      recorderTime = txt.substring(11, 19);
      recorderPower = vol / 10;
    });
  }

  _stopRecorder() async {
    if (!isRecoderReady) return;
    final path = await recorder.stopRecorder();
    final audiofile = File(path!);
    url = audiofile.readAsBytesSync();
    recordLengthLimitControl = DateTime.now().millisecondsSinceEpoch.toString();
    // print(audiofile);
    recorder.onProgress!.listen((event) {}).cancel();
    recorder.closeRecorder();
    limit = 0;
  }

  _showPlayerProgres() {
    audioPlayer.onProgress!.listen((event) {
      endOfSliderPosition = event.duration.abs().inMilliseconds;
      sliderPosition = event.position.inMilliseconds;
      endOfSliderPositionText = DateTime.fromMillisecondsSinceEpoch(
              event.duration.abs().inMilliseconds - 1000,
              isUtc: true)
          .toString()
          .substring(11, 19);
      sliderPositionText = DateTime.fromMillisecondsSinceEpoch(
              event.position.inMilliseconds,
              isUtc: true)
          .toString()
          .substring(11, 19);
    });
  }

  disposeRecorder() {
    if (recorder.isRecording) {
      _stopRecorder();
      //  recorder.closeRecorder();
    }

    // audioPlayer.stopPlayer();
    audioPlayer.closePlayer();
  }
}
