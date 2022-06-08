import 'package:audiotales/pages/outher/deleted_screen/deleted_screen_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../widgets/uncategorized/tales_list_widget.dart';
import '../../main_screen/main_screen_block/main_screen_bloc.dart';
import '../../main_screen/selections_screen/bloc/selections_bloc.dart';

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({Key? key}) : super(key: key);
  static const routeName = '/deleted_screen.dart';
  static const DeletedScreenTitleText title = DeletedScreenTitleText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return
        // Scaffold(
        // extendBody: true,
        // appBar: _appBar(screen, title, context),
        // body:
        Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: OvalBC(),
              child: Container(
                height: screen.height / 7,
                color: CustomColors.audiotalesHeadColorBlue,
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: screen.height * 0.15,
            ),
            const Expanded(
              child: _DeletedTalesListWidget(),
            ),
          ],
        ),
      ],
      // ),
    );
  }
}

class _DeletedTalesListWidget extends StatelessWidget {
  const _DeletedTalesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getDelitedTalesList();
    Size screen = MediaQuery.of(context).size;
    // final MainScreenBloc _mainScreenBloc =
    //     BlocProvider.of<MainScreenBloc>(context);

    return ListView.builder(
      itemCount: talesList.length,
      itemBuilder: (_, i) {
        String lastText = TimeTextConvertService.instance.dayMonthYear(i > 0
            ? talesList[i - 1].getDeleteDate()
            : talesList[i].getDeleteDate());

        String text = TimeTextConvertService.instance
            .dayMonthYear(talesList[i].getDeleteDate());
        bool isSameDate = text == lastText && i != 0;
        return Padding(
          padding: EdgeInsets.all(screen.height * 0.005),
          child: Column(
            children: [
              isSameDate
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DeletedDateText(text: text),
                    ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // _mainScreenBloc.add(ClickPlayEvent(talesList[i]));
                          },
                          icon: ImageIcon(
                            CustomIconsImg.playBlueSolo,
                            color: CustomColors.audiotalesHeadColorBlue,
                            size: screen.height,
                          ),
                        ),
                        SizedBox(
                          width: screen.width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(talesList[i].name),
                            AudioListText(time: talesList[i].time),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        CustomIconsImg.delete,
                        color: CustomColors.black,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  border: Border.all(color: CustomColors.audioBorder),
                  borderRadius: const BorderRadius.all(Radius.circular(41)),
                ),
                // foregroundDecoration: isDisactive == true
                //     ? BoxDecoration(
                //         color: CustomColors.disactive,
                //         border: Border.all(color: CustomColors.audioBorder),
                //         borderRadius: const BorderRadius.all(Radius.circular(41)),
                //       )
                //     : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
