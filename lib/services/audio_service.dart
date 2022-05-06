// import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data_base/local_data_base.dart';
import '../models/audio.dart';
import '../models/tales_list.dart';
import '../utils/consts/custom_icons_img.dart';

// enum SaveMetod {
//   firestore,
//   localDB
// }

class SoundService {
  SoundService();

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  String? id;
  bool isRecoderReady = false;
  int limit = 0;
  int soundIndex = 0;
  Uint8List? url;
  String? path;
  String? pathUrl;
  String audioname = 'Аудиозапись';
  String recorderTime = '00:00:00';
  double recorderPower = 0;
  int sliderPosition = 0;
  int endOfSliderPosition = 1;
  String sliderPositionText = '00:00:00';
  String endOfSliderPositionText = '00:00:01';

  saveAudioTale(TalesList fullTalesList) async {
    if (url == null) {
      return;
    }

    try {
      final storageRef = FirebaseStorage.instance.ref().child(id!);
      final audiofile = File(path!);
      await storageRef.putFile(audiofile);
      pathUrl = await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print('$e ');
    }

    AudioTale audioTale = AudioTale(
        id: id ?? '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
        path: '',
        pathUrl: pathUrl ?? '',
        time: endOfSliderPosition / 60000,
        name:
            '$audioname ${fullTalesList.fullTalesList.where((element) => element.isDeleted != true).length + 1}');
    fullTalesList.addNewAudio(audioTale);
    LocalDB.instance.saveAudioTales(fullTalesList);
  }

  clickRecorder() async {
    if (!recorder.isRecording && url == null && !audioPlayer.isPlaying) {
      await _startRecord();
    } else if (recorder.isRecording) {
      await stopRecorder();
      await _startLocalPlayer(
        path ?? '',
      );
      _showPlayerProgres();
    } else if (!recorder.isRecording && url != null && !audioPlayer.isPlaying) {
      await _startLocalPlayer(
        path ?? '',
      );
      _showPlayerProgres();
    } else if (!recorder.isRecording && audioPlayer.isPlaying) {
      audioPlayer.stopPlayer();
    }
  }

  clickPlayer(path) async {
    if (!audioPlayer.isPlaying) {
      await _initPlayer();
      _startPlayer(path);
      _showPlayerProgres();
    } else if (audioPlayer.isPlaying) {
      audioPlayer.stopPlayer();
    }
  }

  // disposeRecorder() {
  //   if (recorder.isRecording) {
  //     _stopRecorder();
  //   }
  //   if (audioPlayer.isPlaying || audioPlayer.isPaused) {
  //     audioPlayer.stopPlayer();
  //   }

  //   recorder.closeRecorder();
  //   audioPlayer.closePlayer();
  // }

  _startRecord() async {
    await _record();
    _startTimer();
    soundIndex = 1;
  }

  _initPlayer() async {
    if (!isRecoderReady) {
      await audioPlayer.openPlayer().then((value) {
        isRecoderReady = true;
      });
      await audioPlayer
          .setSubscriptionDuration(const Duration(milliseconds: 1000));
    }
  }

  initRecorder() async {
    if (!isRecoderReady) {
      await audioPlayer.openPlayer().then((value) {
        isRecoderReady = true;
      });
      await audioPlayer
          .setSubscriptionDuration(const Duration(milliseconds: 1000));
    }
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(const Duration(seconds: 1));
    if (audioPlayer.isPlaying) {
      await audioPlayer.stopPlayer();
      await _startRecord();
    } else {
      await _startRecord();
    }
  }

  _record() async {
    if (!isRecoderReady) return;
    id = '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4';
    await recorder.startRecorder(toFile: id, codec: Codec.defaultCodec);
  }

  _startTimer() {
    recorder.onProgress!.listen(
      (e) {
        int vol = e.decibels!.toInt();
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        limit = e.duration.inSeconds;
        endOfSliderPosition = e.duration.inMilliseconds;
        // audioDuration = e.duration.inMinutes;
        String txt = '$date';
        recorderTime = txt.substring(11, 19);
        recorderPower = vol / 10;
      },
    );
  }

  stopRecorder() async {
    if (!isRecoderReady) return;
    path = await recorder.stopRecorder();
    // final audiofile = File(
    //     '/Users/iya/Library/Developer/CoreSimulator/Devices/BDB56019-77E1-49EC-BE1C-F9FEAEEAECF9/data/Containers/Data/Application/411BFBB0-4E40-43E2-8095-2178066F26C2/tmp/1651586582427.mp4');
    final audiofile = File(path!);
    url = audiofile.readAsBytesSync();
    recorder.onProgress!.listen((event) {}).cancel();
    recorder.closeRecorder();
    limit = 0;
    recorder.onProgress!.listen((event) {}).cancel();
    recorderTime = '00:00:00';
  }

  _startPlayer(AudioTale path) async {
    // print('${path.path} && ${path.pathUrl}');
    try {
      if (path.path != '') {
        final audiofile = File(path.path);
        url = audiofile.readAsBytesSync();
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
        );
      }

      if (path.pathUrl != '' && path.path == '') {
        await audioPlayer.startPlayer(
          fromURI: path.pathUrl,
          codec: Codec.defaultCodec,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  _startLocalPlayer(String path) async {
    try {
      if (path != '') {
        final audiofile = File(path);
        url = audiofile.readAsBytesSync();
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  _showPlayerProgres() {
    audioPlayer.onProgress!.listen(
      (event) {
        endOfSliderPosition = event.duration.abs().inMilliseconds;
        // audioDuration = event.duration.abs().inMinutes;
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
      },
    );
  }

  getNavImg() {
    AssetImage mic;
    if (soundIndex == 0) {
      mic = CustomIconsImg.mic2;
    } else {
      mic = CustomIconsImg.mic3;
    }
    return mic;
  }

  forwardPlayer(int i) {
    if (i > 0) {
      if (audioPlayer.isPlaying || audioPlayer.isPaused) {
        audioPlayer.seekToPlayer(Duration(
            milliseconds: endOfSliderPosition > sliderPosition + 16000
                ? sliderPosition + 15000
                : endOfSliderPosition - 1000));
      }
    } else {
      if (audioPlayer.isPlaying || audioPlayer.isPaused) {
        audioPlayer.seekToPlayer(Duration(
            milliseconds: sliderPosition > 16000 ? sliderPosition - 15000 : 0));
      }
    }
  }

  forwardPlayerWithSlider(num d) {
    sliderPosition = d.floor();
    if (audioPlayer.isPlaying || audioPlayer.isPaused) {
      audioPlayer.seekToPlayer(Duration(milliseconds: d.floor()));
    }
  }
}
