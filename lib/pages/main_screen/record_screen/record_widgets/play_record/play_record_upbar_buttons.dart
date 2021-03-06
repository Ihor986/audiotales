import 'package:audiotales/models/tales_list.dart';
import 'package:audiotales/models/user.dart';
import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../../../repositories/tales_list_repository.dart';
import '../../../../../repositories/user_reposytory.dart';
import '../../../../../utils/custom_icons.dart';
import '../../../../../widgets/toasts/deleted/delete_unsaved_audio.dart';
import '../../record_bloc/record_bloc.dart';
import '../recordering/record_screen_text.dart';

class PlayRecordUpbarButtons extends StatelessWidget {
  const PlayRecordUpbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TalesList _fullTalesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    final LocalUser _localUser =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    final Size _screen = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(_screen.width * 0.04),
          child: SizedBox(
            width: _screen.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    final String? _path = context.read<RecordBloc>().sound.path;
                    if (_path == null) return;
                    context.read<MainScreenBloc>().add(
                          ShareUnsavedAudioEvent(
                            path: _path,
                          ),
                        );
                  },
                  icon: SvgPicture.asset(
                    CustomIconsImg.share,
                    color: CustomColors.iconsColorPlayRecUpbar,
                    height: 25,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    context.read<RecordBloc>().add(
                          SaveRecordEvent(
                            talesListRep: _fullTalesList,
                            localUser: _localUser,
                            isAutosaveLocal: true,
                          ),
                        );
                  },
                  icon: SvgPicture.asset(
                    CustomIconsImg.downloadIcon,
                    height: 25,
                    color: CustomColors.iconsColorPlayRecUpbar,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    DeleteUnsavedConfirm.instance.deletedConfirm(
                      screen: _screen,
                      context: context,
                    );
                  },
                  icon: SvgPicture.asset(
                    CustomIconsImg.delete,
                    height: 25,
                    color: CustomColors.iconsColorPlayRecUpbar,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            onPressed: () {
              context.read<RecordBloc>().add(
                    SaveRecordEvent(
                      talesListRep: _fullTalesList,
                      localUser: _localUser,
                      isAutosaveLocal: false,
                    ),
                  );
            },
            child: const PlayRecordText(),
          ),
        )
      ],
    );
  }
}
