import 'package:audiotales/utils/consts/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../repositorys/tales_list_repository.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../sound_bloc/sound_bloc.dart';
import '../recordering/record_screen_text.dart';

class PlayRecordUpbarButtons extends StatelessWidget {
  const PlayRecordUpbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: SizedBox(
            width: screen.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    CustomIconsImg.share,
                    size: 25,
                    color: CustomColors.iconsColorPlayRecUpbar,
                  ),
                ),
                IconButton(
                  onPressed: () async {},
                  icon: const ImageIcon(
                    CustomIconsImg.download,
                    size: 25,
                    color: CustomColors.iconsColorPlayRecUpbar,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    CustomIconsImg.delete,
                    size: 25,
                    color: CustomColors.iconsColorPlayRecUpbar,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: TextButton(
              onPressed: () {
                context.read<SoundBloc>().add(SaveRecordEvent(
                    RepositoryProvider.of<TalesListRepository>(context)
                        .getTalesListRepository()));
              },
              child: const PlayRecordText()),
        )
      ],
    );
  }
}
