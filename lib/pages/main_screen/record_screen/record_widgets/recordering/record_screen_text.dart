import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/texts_consts.dart';
import '../../sound_bloc/sound_bloc.dart';

class RecordText extends StatelessWidget {
  const RecordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(TextsConst.record,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ));
  }
}

class PlayRecordText extends StatelessWidget {
  const PlayRecordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      TextsConst.save,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }
}

class AudioNameText extends StatelessWidget {
  const AudioNameText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int length = RepositoryProvider.of<TalesListRepository>(context)
        .getTalesListRepository()
        .fullTalesList
        .length;
    // .getActiveTalesList()
    final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    return Text(_soundBloc.sound.audioname + ' ${length + 1}',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ));
  }
}
