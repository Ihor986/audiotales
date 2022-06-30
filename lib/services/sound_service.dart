import 'dart:io';
import 'dart:typed_data';
import 'package:audiotales/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import '../data_base/data/local_data_base.dart';
import '../data_base/data_base.dart';
import '../models/audio.dart';
import '../models/tales_list.dart';
import '../utils/consts/custom_icons_img.dart';

class SoundService extends ChangeNotifier {
  SoundService._();
  static final SoundService instance = SoundService._();

  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
  String? idPlayingList;
  bool? isPlayingList;
  String? idPlaying;
  String? id;
  bool isRecoderReady = false;
  int limit = 0;
  int soundIndex = 0;
  Uint8List? url;
  String? path;
  String? pathUrl;
  String audioname = 'Запись №';
  String recorderTime = '00:00:00';
  double recorderPower = 0;
  int sliderPosition = 0;
  int endOfSliderPosition = 1;
  String sliderPositionText = '00:00:00';
  String endOfSliderPositionText = '00:00:01';
  num? size;
  AudioTale? audioTale;
  bool isRepeatAllList = false;
  List<AudioTale> audioList =
      DataBase.instance.getAudioTales().getActiveTalesList();
  int listIndex = 0;

  Future<void> saveAudioTale({
    required TalesList fullTalesList,
    required LocalUser localUser,
    required bool? isAutosaveLocal,
  }) async {
    if (url == null) {
      return;
    }
    if (localUser.isUserRegistered == true) {
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('${LocalDB.instance.getUser().id}/audio/')
            .child(id!);
        final audiofile = File(path!);
        await storageRef.putFile(audiofile);
        pathUrl = await storageRef.getDownloadURL();
        FullMetadata sizeFromMD = await storageRef.getMetadata();
        size = sizeFromMD.size;
        if (isAutosaveLocal != true) {
          File(path!).delete();
          path = null;
        }
      } on FirebaseException catch (e) {
        print(e);
      }
    }

    audioTale = AudioTale(
        id: id ?? '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4',
        path: path,
        pathUrl: pathUrl,
        time: endOfSliderPosition / 60000,
        size: size ?? 0,
        name: '$audioname ${fullTalesList.fullTalesList.length + 1}',
        compilationsId: []);
    fullTalesList.addNewAudio(audioTale!);
    await DataBase.instance.saveAudioTales(fullTalesList);
  }

  Future<void> clickRecorder() async {
    bool isRedyStartRecord = !recorder.isRecording &&
        url == null &&
        !audioPlayer.isPlaying &&
        soundIndex == 0;
    bool isReadyStartPlayer =
        !recorder.isRecording && url != null && !audioPlayer.isPlaying;
    bool isReadyStopPlayer = !recorder.isRecording && audioPlayer.isPlaying;

    if (isRedyStartRecord) {
      try {
        await _startRecord();
        isRepeatAllList = false;
      } catch (_) {}
    } else if (recorder.isRecording) {
      soundIndex = 1;
      await stopRecorder();
      await _startLocalPlayer(
        path ?? '',
      );

      _showPlayerProgres();
    } else if (isReadyStartPlayer) {
      soundIndex = 1;
      await _startLocalPlayer(
        path ?? '',
      );
      _showPlayerProgres();
    } else if (isReadyStopPlayer) {
      soundIndex = 1;
      audioPlayer.stopPlayer();
    }
  }

  Future<void> playNextTreck() async {
    listIndex++;
    if (isPlayingList == true) {
      await audioPlayer.stopPlayer();
      await _startAllAudioPlayer(audioList, listIndex);
      isPlayingList = true;
    } else {
      await audioPlayer.stopPlayer();
      _startPlayer(audioList.elementAt(listIndex));
      isPlayingList = null;
    }
  }

  Future<void> play(List<AudioTale> _audioList,
      {required int indexAudio}) async {
    if (_audioList.isEmpty) {
      return;
    }
    if (audioPlayer.isPlaying) {
      await audioPlayer.stopPlayer();
      idPlaying = null;
      idPlayingList = null;
      isPlayingList = null;
      isRepeatAllList = false;
      notifyListeners();
      return;
    }
    if (isPlayingList == true) {
      _playAllPlayer(_audioList, indexAudio: indexAudio);
    } else {
      _clickPlayer(_audioList, indexAudio: indexAudio);
    }
  }

  Future<void> _clickPlayer(List<AudioTale> _audioList,
      {required int indexAudio}) async {
    listIndex = indexAudio;
    audioList = _audioList;
    await _initPlayer();
    _startPlayer(_audioList.elementAt(indexAudio));
    isPlayingList = null;
    _showPlayerProgres();
  }

  Future<void> _playAllPlayer(List<AudioTale> _audioList,
      {int? indexAudio}) async {
    audioList = _audioList;
    await _initPlayer();
    await _startAllAudioPlayer(_audioList, 0);
    _showPlayerProgres();
    isPlayingList = true;
  }

  Future<void> _startRecord() async {
    await _record();
    _startTimer();
    soundIndex = 1;
  }

  Future<void> _initPlayer() async {
    if (!isRecoderReady) {
      await audioPlayer.openPlayer().then((value) {
        isRecoderReady = true;
      });
      await audioPlayer
          .setSubscriptionDuration(const Duration(milliseconds: 1000));
    }
  }

  Future<void> initRecorder() async {
    if (!isRecoderReady) {
      await audioPlayer.openPlayer().then((value) {
        isRecoderReady = true;
      });
      await audioPlayer
          .setSubscriptionDuration(const Duration(milliseconds: 1000));
    }
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // openAppSettings();
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

  Future<void> _record() async {
    if (!isRecoderReady) return;
    id = '${DateTime.now().millisecondsSinceEpoch.toString()}.mp4';
    await recorder.startRecorder(toFile: id, codec: Codec.defaultCodec);
  }

  void _startTimer() {
    recorder.onProgress!.listen(
      (e) {
        int vol = e.decibels!.toInt();
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            e.duration.inMilliseconds,
            isUtc: true);
        limit = e.duration.inSeconds;
        endOfSliderPosition = e.duration.inMilliseconds + 1000;
        // audioDuration = e.duration.inMinutes;
        String txt = '$date';
        recorderTime = txt.substring(11, 19);
        recorderPower = vol / 10;
      },
    );
  }

  Future<void> stopRecorder() async {
    if (!isRecoderReady) return;
    path = await recorder.stopRecorder();
    // final audiofile = File(
    //     '/Users/iya/Library/Developer/CoreSimulator/Devices/BDB56019-77E1-49EC-BE1C-F9FEAEEAECF9/data/Containers/Data/Application/411BFBB0-4E40-43E2-8095-2178066F26C2/tmp/1651586582427.mp4');
    final audiofile = File(path!);
    url = audiofile.readAsBytesSync();
    recorder.onProgress!.listen((event) {}).cancel();
    recorder.closeRecorder();
    limit = 0;
    // recorder.onProgress!.listen((event) {}).cancel();
    recorderTime = '00:00:00';
  }

  deleteUnsavedAudio() {
    if (path == null) {
      return;
    }
    if (audioPlayer.isPlaying) {
      audioPlayer.closePlayer();
    }
    File(path!).delete();
    url = null;
    path = null;
  }

  Future<void> _startPlayer(AudioTale audio) async {
    final bool auth = FirebaseAuth.instance.currentUser == null;
    // print('${path.path} && ${path.pathUrl}');
    try {
      if (audio.path != null) {
        final audiofile = File(audio.path!);
        url = audiofile.readAsBytesSync();
        await audioPlayer.startPlayer(
          fromDataBuffer: url,
          codec: Codec.defaultCodec,
          whenFinished: () {
            idPlaying = null;
            idPlayingList = null;
            isPlayingList = null;
            notifyListeners();
          },
        );
      }

      if (audio.pathUrl != null && audio.path == null && !auth) {
        await audioPlayer.startPlayer(
          fromURI: audio.pathUrl,
          codec: Codec.defaultCodec,
          whenFinished: () {
            idPlaying = null;
            idPlayingList = null;
            isPlayingList = null;
            notifyListeners();
          },
        );
      }
    } catch (e) {
      print(e);
    }
    idPlaying = audio.id;
    print(idPlaying);
    notifyListeners();
  }

  Future<void> _startLocalPlayer(String path) async {
    try {
      final audiofile = File(path);
      url = audiofile.readAsBytesSync();
      await audioPlayer.startPlayer(
        fromDataBuffer: url,
        codec: Codec.defaultCodec,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _startAllAudioPlayer(
      List<AudioTale> audioList, int index) async {
    final bool auth = FirebaseAuth.instance.currentUser != null;
    final int length = audioList.length;
    listIndex = index;
    final audio = audioList[listIndex];

    try {
      if (audio.path != null) {
        final audiofile = File(audio.path!);
        url = audiofile.readAsBytesSync();
        await audioPlayer.startPlayer(
            fromDataBuffer: url,
            codec: Codec.defaultCodec,
            whenFinished: () {
              idPlaying = null;
              notifyListeners();
              listIndex++;
              if (listIndex < length) {
                _startAllAudioPlayer(audioList, listIndex);
              } else if (listIndex == length && isRepeatAllList) {
                listIndex = 0;
                _startAllAudioPlayer(audioList, listIndex);
              } else {
                idPlayingList = null;
                isPlayingList = null;
                notifyListeners();
              }
            });
      }

      if (audio.pathUrl != null && audio.path == null && auth) {
        await audioPlayer.startPlayer(
            fromURI: audio.pathUrl,
            codec: Codec.defaultCodec,
            whenFinished: () {
              idPlaying = null;
              notifyListeners();
              listIndex++;
              if (listIndex < length) {
                _startAllAudioPlayer(audioList, listIndex);
              } else if (listIndex == length && isRepeatAllList) {
                listIndex = 0;
                _startAllAudioPlayer(audioList, listIndex);
              } else {
                idPlayingList = null;
                isPlayingList = null;
                notifyListeners();
              }
            });
      }
    } catch (e) {
      listIndex++;
      _startAllAudioPlayer(audioList, listIndex);
      print(audio.name); // alert
    }
    idPlaying = audio.id;
    notifyListeners();
  }

  void _showPlayerProgres() {
    audioPlayer.onProgress?.listen(
      (event) {
        endOfSliderPosition = event.duration.inMilliseconds;
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

  AssetImage getNavImg() {
    AssetImage mic;
    if (soundIndex == 0) {
      mic = CustomIconsImg.mic2;
    } else {
      mic = CustomIconsImg.mic3;
    }
    return mic;
  }

  void forwardPlayer(int i) {
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

  Future<void> forwardPlayerWithSlider(num d) async {
    sliderPosition = d.floor();
    if (audioPlayer.isPlaying || audioPlayer.isPaused) {
      await audioPlayer.seekToPlayer(Duration(milliseconds: d.floor()));
      if (audioPlayer.isStopped || audioPlayer.isPaused) {
        await clickRecorder();
      }
    }
  }

  void dispouse() {
    // idPlayingList = null;
    // isPlayingList = null;
    // idPlaying = null;
    id = null;
    isRecoderReady = false;
    limit = 0;
    soundIndex = 0;
    url = null;
    path = null;
    pathUrl = null;
    audioname = 'Запись №';
    recorderTime = '00:00:00';
    recorderPower = 0;
    sliderPosition = 0;
    endOfSliderPosition = 1;
    sliderPositionText = '00:00:00';
    endOfSliderPositionText = '00:00:01';
    size = null;
    audioTale = null;
    isRepeatAllList = false;
  }
}
