import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/audio.dart';
import '../../../models/tales_list.dart';
import '../../../pages/main_screen/main_screen_block/main_screen_bloc.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';

class AudioListText extends StatelessWidget {
  const AudioListText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        String text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $text',
                style: const TextStyle(
                  color: CustomColors.noTalesText,
                  fontFamily: 'TT Norms',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class AudioListNameText extends StatelessWidget {
  const AudioListNameText({
    Key? key,
    required this.audio,
  }) : super(key: key);
  final AudioTale audio;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      buildWhen: (previous, current) {
        return previous.readOnly != current.readOnly;
      },
      builder: (context, state) {
        final TalesList _talesListRep =
            context.read<TalesListRepository>().getTalesListRepository();
        Size screen = MediaQuery.of(context).size;
        final bool _readOnly =
            audio.id == state.chahgedAudioId ? state.readOnly : true;
        return _readOnly
            ? Text(audio.name)
            : SizedBox(
                height: screen.height * 0.03,
                width: 0.5 * screen.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: _readOnly ? InputBorder.none : null,
                  ),
                  initialValue: audio.name,
                  onChanged: (value) {
                    context.read<MainScreenBloc>().add(
                          EditingAudioNameEvent(value: value),
                        );
                  },
                  onEditingComplete: () {
                    context
                        .read<MainScreenBloc>()
                        .add(SaveChangedAudioNameEvent(
                          audio: audio,
                          fullTalesList: _talesListRep,
                        ));
                  },
                  readOnly: _readOnly,
                  style: const TextStyle(
                    color: CustomColors.black,
                    fontFamily: 'TT Norms',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                ),
              );
      },
    );
  }
}
