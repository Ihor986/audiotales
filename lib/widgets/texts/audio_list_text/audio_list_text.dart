import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/audio.dart';
import '../../../models/tales_list.dart';
import '../../../pages/main_screen/record_screen/sound_bloc/sound_bloc.dart';
import '../../../services/minuts_text_convert_service.dart';

class AudioListText extends StatelessWidget {
  const AudioListText({Key? key, required this.time}) : super(key: key);
  final num time;
  @override
  Widget build(BuildContext context) {
    String text = TimeTextConvertService.instance
        .getConvertedMinutesText(timeInMinutes: time);

    return Text(
      '${time.round()} $text',
      style: const TextStyle(
        color: CustomColors.noTalesText,
        fontFamily: 'TT Norms',
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      ),
    );
  }
}

class AudioListNameText extends StatelessWidget {
  const AudioListNameText({
    Key? key,
    required this.audio,
    required this.fullTalesList,
  }) : super(key: key);
  final AudioTale audio;
  final TalesList fullTalesList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundInitial>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final bool _readOnly =
            audio.id == state.chahgedAudioId ? state.readOnly : true;
        return SizedBox(
          height: screen.height * 0.03,
          width: 0.5 * screen.width,
          child: TextFormField(
            decoration: InputDecoration(
              border: _readOnly ? InputBorder.none : null,
            ),
            initialValue: audio.name,
            onChanged: (value) {
              context.read<SoundBloc>().add(
                    EditingAudioNameEvent(value: value),
                  );
            },
            onEditingComplete: () {
              context.read<SoundBloc>().add(SaveChangedAudioNameEvent(
                    audio: audio,
                    fullTalesList: fullTalesList,
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
