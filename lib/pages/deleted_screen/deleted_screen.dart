// import 'package:audiotales/pages/outher/deleted_screen/widgets/deleted_screen_text.dart';
import 'package:audiotales/pages/deleted_screen/bloc/delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../widgets/alerts/deleted/delete_from_db_confirm.dart';
import '../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'widgets/deleted_screen_text.dart';

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({Key? key}) : super(key: key);
  static const routeName = '/deleted_screen.dart';
  static const DeletedScreenTitleText title = DeletedScreenTitleText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final DeleteBloc _deleteBloc = BlocProvider.of<DeleteBloc>(context);
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
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
            _deleteBloc.selectAudioToDeleteService.isChosen
                ? Align(
                    alignment: const Alignment(0.95, -0.9),
                    child: TextButton(
                      onPressed: () {
                        _deleteBloc.add(SelectDeletedAudioEvent());
                      },
                      child: const Text(
                        'Cansel',
                        style: TextStyle(
                          color: CustomColors.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
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
      },
    );
  }
}

class _DeletedTalesListWidget extends StatelessWidget {
  const _DeletedTalesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
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
                        _iconButton(id: talesList[i].id),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.white,
                      border: Border.all(color: CustomColors.audioBorder),
                      borderRadius: const BorderRadius.all(Radius.circular(41)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _iconButton extends StatelessWidget {
  const _iconButton({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final DeleteBloc _deleteBloc = BlocProvider.of<DeleteBloc>(context);
    Size screen = MediaQuery.of(context).size;
    List<String> _checkedList =
        _deleteBloc.selectAudioToDeleteService.checkedList;
    bool isChecked = _checkedList.contains(id);

    final bool isChosen = _deleteBloc.selectAudioToDeleteService.isChosen;
    return isChosen
        ? IconButton(
            onPressed: () {
              _deleteBloc.add(CheckEvent(isChecked: isChecked, id: id));
            },
            icon: isChecked
                ? const ImageIcon(CustomIconsImg.check)
                : const ImageIcon(CustomIconsImg.uncheck))
        : IconButton(
            onPressed: () {
              DeleteFromDBConfirm.instance
                  .deletedConfirm(screen: screen, context: context, id: id);
            },
            icon: SvgPicture.asset(
              CustomIconsImg.delete,
              color: CustomColors.black,
            ),
          );
  }
}