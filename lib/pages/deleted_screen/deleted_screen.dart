import 'package:audiotales/pages/deleted_screen/bloc/delete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/audio.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../services/minuts_text_convert_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../models/tales_list.dart';
import '../../widgets/alerts/deleted/delete_from_db_confirm.dart';
import '../../../widgets/texts/audio_list_text/audio_list_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'widgets/deleted_screen_text.dart';

class DeletedScreen extends StatefulWidget {
  const DeletedScreen({Key? key}) : super(key: key);
  static const routeName = '/deleted_screen.dart';
  static const DeletedScreenTitleText title = DeletedScreenTitleText();

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
    final Size screen = MediaQuery.of(context).size;
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
                      height: screen.height * 0.3,
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
                    height: screen.height * 0.3,
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
    Size screen = MediaQuery.of(context).size;
    return Container(
      height: 0.18 * screen.height,
      color: CustomColors.audiotalesHeadColorBlue,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0.04 * screen.height,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DeletedScreenTitleText(),
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
                              height: 0.02 * screen.height,
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
                        width: 0.07 * screen.width,
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
    return BlocBuilder<DeleteBloc, DeleteState>(
      builder: (context, state) {
        final TalesList talesListRep =
            RepositoryProvider.of<TalesListRepository>(context)
                .getTalesListRepository();
        final List<AudioTale> talesList = talesListRep.getDelitedTalesList();
        Size screen = MediaQuery.of(context).size;

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
                              icon: SvgPicture.asset(
                                CustomIconsImg.playSVG,
                                height: screen.height * 0.04,
                                color: CustomColors.audiotalesHeadColorBlue,
                              ),
                              iconSize: screen.height * 0.05,
                            ),
                            SizedBox(
                              width: screen.width * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(talesList[i].name),
                                AudioListText(audio: talesList.elementAt(i)),
                              ],
                            ),
                          ],
                        ),
                        _IconButton(id: talesList[i].id),
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

class _IconButton extends StatelessWidget {
  const _IconButton({
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
                ? SvgPicture.asset(
                    CustomIconsImg.check,
                    height: screen.height * 0.055,
                    color: CustomColors.black,
                  )
                : SvgPicture.asset(
                    CustomIconsImg.uncheck,
                    height: screen.height * 0.055,
                    color: CustomColors.black,
                  ),
          )
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
