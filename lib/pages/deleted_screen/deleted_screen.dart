import 'package:audiotales/pages/deleted_screen/bloc/delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../models/tale.dart';
import '../../models/tales_list.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_icons.dart';
import '../../utils/texts_consts.dart';
import '../../widgets/toasts/deleted/delete_from_db_confirm.dart';

class DeletedScreen extends StatefulWidget {
  const DeletedScreen({Key? key}) : super(key: key);
  static const routeName = '/deleted_screen.dart';
  static const _DeletedScreenTitleText title = _DeletedScreenTitleText();

  @override
  State<DeletedScreen> createState() => _DeletedScreenState();
}

class _DeletedScreenState extends State<DeletedScreen> {
  @override
  void initState() {
    context.read<DeleteBloc>().selectAudioToDeleteService.dispouse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final DeleteBloc _deleteBloc = context.read<DeleteBloc>();
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: OvalBC(),
                    child: Container(
                      alignment: const Alignment(0, -0.8),
                      height: _screen.height * 0.3,
                      color: CustomColors.audiotalesHeadColorBlue,
                      child: _DeletedScreenAppBar(
                        isChosen:
                            _deleteBloc.selectAudioToDeleteService.isChosen,
                        onAction: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              _deleteBloc.selectAudioToDeleteService.isChosen
                  ? Align(
                      alignment: const Alignment(0.95, -0.6),
                      child: TextButton(
                        onPressed: () {
                          _deleteBloc.add(SelectDeletedAudioEvent());
                        },
                        child: const Text(
                          'Отменить',
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
                    height: _screen.height * 0.3,
                  ),
                  const Expanded(
                    child: _DeletedTalesListWidget(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeletedScreenAppBar extends StatelessWidget {
  const _DeletedScreenAppBar({
    Key? key,
    required this.onAction,
    required this.isChosen,
  }) : super(key: key);
  final void Function() onAction;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    final DeleteBloc _deleteBloc = BlocProvider.of<DeleteBloc>(context);
    final TalesList _talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    final Size _screen = MediaQuery.of(context).size;
    return Container(
      height: 0.2 * _screen.height,
      color: CustomColors.audiotalesHeadColorBlue,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0.04 * _screen.height,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: _DeletedScreenTitleText(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isChosen
                        ? const SizedBox()
                        : IconButton(
                            icon: SvgPicture.asset(
                              CustomIconsImg.drawer,
                              height: 0.02 * _screen.height,
                              color: CustomColors.white,
                            ),
                            padding: const EdgeInsets.all(0),
                            onPressed: onAction,
                          ),
                    PopupMenuButton(
                      padding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      icon: SvgPicture.asset(
                        CustomIconsImg.moreHorizontRounded,
                        width: 0.07 * _screen.width,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text(
                            'Выбрать несколько',
                            style: TextStyle(
                              color: CustomColors.black,
                            ),
                          ),
                          value: () {
                            if (_deleteBloc
                                .selectAudioToDeleteService.isChosen) {
                              return;
                            }
                            _deleteBloc.add(SelectDeletedAudioEvent());
                          },
                        ),
                        PopupMenuItem(
                          child: const Text(
                            'Удалить все',
                            style: TextStyle(
                              color: CustomColors.black,
                            ),
                          ),
                          value: () {
                            _deleteBloc.add(DeleteSelectedAudioEvent(
                                talesList: _talesList));
                          },
                        ),
                        PopupMenuItem(
                          child: const Text(
                            'Восстановить все',
                            style: TextStyle(
                              color: CustomColors.black,
                            ),
                          ),
                          value: () {
                            _deleteBloc.add(RestoreSelectedAudioEvent(
                                talesList: _talesList));
                          },
                        ),
                      ],
                      onSelected: (Function value) {
                        value();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeletedTalesListWidget extends StatelessWidget {
  const _DeletedTalesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
        final List<AudioTale> _talesList = context
            .read<TalesListRepository>()
            .getTalesListRepository()
            .getDelitedTalesList();

        return ListView.builder(
          itemCount: _talesList.length,
          itemBuilder: (_, i) {
            String lastText = TimeTextConvertService.instance.dayMonthYear(
              i > 0
                  ? _talesList.elementAt(i - 1).getDeleteDate()
                  : _talesList.elementAt(i).getDeleteDate(),
            );

            String text = TimeTextConvertService.instance.dayMonthYear(
              _talesList.elementAt(i).getDeleteDate(),
            );
            bool isSameDate = text == lastText && i != 0;
            return Padding(
              padding: EdgeInsets.all(_screen.height * 0.005),
              child: Column(
                children: [
                  isSameDate
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: _DeletedDateText(text: text),
                        ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                CustomIconsImg.playSVG,
                                height: _screen.height * 0.04,
                                color: CustomColors.audiotalesHeadColorBlue,
                              ),
                              iconSize: _screen.height * 0.05,
                            ),
                            SizedBox(
                              width: _screen.width * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_talesList.elementAt(i).name),
                                _AudioListText(audio: _talesList.elementAt(i)),
                              ],
                            ),
                          ],
                        ),
                        _IconButton(id: _talesList.elementAt(i).id),
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

class _AudioListText extends StatelessWidget {
  const _AudioListText({
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
        final String _text = TimeTextConvertService.instance
            .getConvertedMinutesText(timeInMinutes: audio.time);

        return audio.id != state.chahgedAudioId
            ? Text(
                '${audio.time.round()} $_text',
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

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final DeleteBloc _deleteBloc = BlocProvider.of<DeleteBloc>(context);
    final Size _screen = MediaQuery.of(context).size;
    final List<String> _checkedList =
        _deleteBloc.selectAudioToDeleteService.checkedList;
    final bool isChecked = _checkedList.contains(id);

    final bool isChosen = _deleteBloc.selectAudioToDeleteService.isChosen;
    return isChosen
        ? IconButton(
            onPressed: () {
              _deleteBloc.add(CheckEvent(isChecked: isChecked, id: id));
            },
            icon: isChecked
                ? SvgPicture.asset(
                    CustomIconsImg.check,
                    height: _screen.height * 0.055,
                    color: CustomColors.black,
                  )
                : SvgPicture.asset(
                    CustomIconsImg.uncheck,
                    height: _screen.height * 0.055,
                    color: CustomColors.black,
                  ),
          )
        : IconButton(
            onPressed: () {
              DeleteFromDBConfirm.instance
                  .deletedConfirm(screen: _screen, context: context, id: id);
            },
            icon: SvgPicture.asset(
              CustomIconsImg.delete,
              color: CustomColors.black,
            ),
          );
  }
}

class _DeletedScreenTitleText extends StatelessWidget {
  const _DeletedScreenTitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          TextsConst.deletedTitleFirst,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: _screen.width * 0.07),
        ),
        Text(
          TextsConst.deletedTitleSecond,
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: _screen.width * 0.07),
        ),
      ],
    );
  }
}

class _DeletedDateText extends StatelessWidget {
  const _DeletedDateText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        color: CustomColors.noTalesText,
        fontSize: _screen.width * 0.035,
      ),
    );
  }
}
