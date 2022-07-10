import 'package:bloc/bloc.dart';

import '../../../data_base/data_base.dart';
import '../../../models/tales_list.dart';
import '../../../services/change_audio_servise.dart';
import '../../../services/download_audio_service.dart';
import '../../../services/share_service.dart';
import '../../../services/sound_service.dart';
import '../../models/tale.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenState()) {
    on<ClickPlayEvent>(
      (event, emit) {
        final String? searchValue = state.searchValue;
        sound.play(event.audioList, indexAudio: event.indexAudio);
        emit(MainScreenState(searchValue: searchValue));
      },
    );

    on<NextTreckEvent>(
      (event, emit) {
        final String? searchValue = state.searchValue;
        sound.playNextTreck();
        emit(MainScreenState(searchValue: searchValue));
      },
    );

    on<Rewind15Event>(
      (event, emit) {
        sound.forwardPlayer(event.time);
        emit(MainScreenState());
      },
    );
    on<RemoveToDeleteAudioEvent>(
      (event, emit) async {
        final TalesList _talesList = event.talesList;
        _talesList.removeAudiosToDeleted(idList: event.idList);
        await DataBase.instance.saveAudioTales(_talesList);
        emit(MainScreenState());
      },
    );

    on<SearchAudioEvent>(
      (event, emit) {
        emit(MainScreenState(searchValue: event.value));
      },
    );

    on<DeleteUnsavedAudioEvent>(
      (event, emit) async {
        await sound.deleteUnsavedAudio();
      },
    );

    on<ChangeAudioNameEvent>(
      (event, emit) {
        changeAudioServise.dispose();
        changeAudioServise.name = event.audio.name;
        emit(MainScreenState(
          readOnly: false,
          chahgedAudioId: event.audio.id,
        ));
      },
    );

    on<SaveChangedAudioNameEvent>(
      (event, emit) async {
        await changeAudioServise.saveChangedAudioName(
          audio: event.audio,
          fullTalesList: event.fullTalesList,
        );
        emit(MainScreenState());
      },
    );

    on<SetState>(
      (event, emit) async {
        emit(MainScreenState());
      },
    );

    on<EditingAudioNameEvent>(
      (event, emit) {
        changeAudioServise.name = event.value;
      },
    );

    on<ShareAudioEvent>(
      (event, emit) async {
        shareAudioService.dispouse();
        shareAudioService.text = event.audio.name;
        await shareAudioService.shareFiles(talesList: [event.audio]);
        emit(MainScreenState());
      },
    );

    on<ShareAudiosEvent>(
      (event, emit) async {
        shareAudioService.dispouse();
        shareAudioService.text = event.name;
        await shareAudioService.shareFiles(
          talesList: event.audioList,
          idList: event.idList,
        );
        emit(MainScreenState());
      },
    );

    on<ShareUnsavedAudioEvent>(
      (event, emit) async {
        shareAudioService.dispouse();
        await shareAudioService.shareUnsavedAudio(path: event.path);
        emit(MainScreenState());
      },
    );

    on<DownloadAudioEvent>(
      (event, emit) {
        final String? searchValue = state.searchValue;
        downloadAudioService.downloadAudioToDevice(
            audioList: event.audioList, talesList: event.talesList);
        emit(MainScreenState(searchValue: searchValue));
      },
    );
  }
  final SoundService sound = SoundService.instance;
  final ChangeAudioServise changeAudioServise = ChangeAudioServise.instance;
  final ShareAudioService shareAudioService = ShareAudioService.instance;
  final DownloadAudioService downloadAudioService =
      DownloadAudioService.instance;
}
