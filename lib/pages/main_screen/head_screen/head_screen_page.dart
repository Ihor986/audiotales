import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../models/audio.dart';
import '../../../models/selections.dart';
import '../../../repositorys/selections_repositiry.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/texts/main_screen_text.dart';
import '../../../widgets/uncategorized/active_tales_list_widget.dart';
import '../../../widgets/uncategorized/player_widget.dart';
import '../selections_screen/add_new_selection/add_new_selection_screen.dart';
import '../selections_screen/bloc/selections_bloc.dart';
// import '../selections_screen/selection_screen.dart/selection_screen.dart';
import '../selections_screen/selection_screen/selection_screen.dart';
import '../selections_screen/selections_text.dart';
import 'head_screen_widgets/head_screen_text.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';

class HeadScreen extends StatelessWidget {
  const HeadScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  static const HeadText title = HeadText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      appBar: _HaedScreenAppBar(
        onAction: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screen.height / 4.5,
                  color: CustomColors.blueSoso,
                ),
              ),
            ],
          ),
          const _SelectionButtons(),
          const _TalesSelectionWidget(),
          const _AudioDraggableWidget(),
          const PlayerWidget(),
        ],
      ),
    );
  }
}

class _HaedScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HaedScreenAppBar({
    Key? key,
    this.onAction,
  }) : super(key: key);
  final void Function()? onAction;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          HeadScreen.title,
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: onAction,
            ),
            const SizedBox(),
          ],
        ),
      ),
      elevation: 0,
    );
  }
}

class _SelectionButtons extends StatelessWidget {
  const _SelectionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        color: CustomColors.blueSoso,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SelectionText1(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                TextButton(
                    onPressed: () {
                      context
                          .read<NavigationBloc>()
                          .add(ChangeCurrentIndexEvent(currentIndex: 1));
                    },
                    child: const SelectionText2()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TalesSelectionWidget extends StatelessWidget {
  const _TalesSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final List<Selection> _selectionsList =
            RepositoryProvider.of<SelectionsListRepository>(context)
                .getSelectionsListRepository()
                .selectionsList;
        bool _isMoreThenTwo = _selectionsList.length > 2;
        bool _isMoreThenOne = _selectionsList.length > 1;
        bool _isNotEmpty = _selectionsList.isNotEmpty;
        int _selectionNumber(int value) {
          if (_isMoreThenTwo && value == 1) {
            return 0;
          }
          if (_isMoreThenOne && _selectionsList.length == 2 && value == 2) {
            return 0;
          } else if (_isMoreThenOne &&
              _selectionsList.length > 2 &&
              value == 2) {
            return 1;
          }
          if (_isNotEmpty && _selectionsList.length == 1 && value == 3) {
            return 0;
          } else if (_isNotEmpty && _selectionsList.length == 2 && value == 3) {
            return 1;
          } else if (_isNotEmpty && _selectionsList.length > 2 && value == 3) {
            return 2;
          }
          return 0;
        }

        return Padding(
          padding: const EdgeInsets.only(top: 47),
          child: SizedBox(
            width: screen.width,
            height: screen.height * 0.25,
            child: Row(
              children: [
                _isMoreThenTwo
                    ? _Selection(
                        selection: _selectionsList[_selectionNumber(1)],
                        width: 0.45,
                        height: 0.27,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColors.oliveSosoOp,
                        ),
                        width: screen.width * 0.45,
                        height: screen.height * 0.27,
                        child: Column(
                          children: const [
                            SelectionText3(),
                            _AddSelectionButton(),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                Column(
                  children: [
                    _isMoreThenOne
                        ? _Selection(
                            selection: _selectionsList[_selectionNumber(2)],
                            width: 0.45,
                            height: 0.115,
                          )
                        : Container(
                            width: screen.width * 0.45,
                            height: screen.height * 0.115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(241, 180, 136, 0.85),
                            ),
                            child: const SelectionText4(),
                          ),
                    _isNotEmpty
                        ? _Selection(
                            selection: _selectionsList[_selectionNumber(3)],
                            width: 0.45,
                            height: 0.115,
                          )
                        : Container(
                            width: screen.width * 0.45,
                            height: screen.height * 0.115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(103, 139, 210, 0.85),
                            ),
                            child: const SelectionText5(),
                          ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        );
      },
    );
  }
}

class _Selection extends StatelessWidget {
  const _Selection({
    Key? key,
    required this.selection,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Selection selection;
  final double width;
  final double height;

  DecorationImage? decorationImage() {
    if (selection.photo != null) {
      try {
        return DecorationImage(
            image: MemoryImage(
              File(selection.photo ?? '').readAsBytesSync(),
            ),
            fit: BoxFit.cover);
      } catch (_) {}
    }

    if (selection.photoUrl != null) {
      try {
        return DecorationImage(
          image: CachedNetworkImageProvider(selection.photoUrl ?? ''),
          fit: BoxFit.cover,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.read<SelectionsBloc>().changeSelectionService.readOnly = true;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SelectionScreen(
              selection: selection,
            ),
          ),
          (_) => true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: decorationImage(),
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.iconsColorBNB,
        ),
        width: screen.width * width,
        height: screen.height * height,
        child: Padding(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              WrapSelectionsListTextName(selection: selection),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: WrapSelectionsListTextData(selection: selection),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddSelectionButton extends StatelessWidget {
  const _AddSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return TextButton(
        onPressed: () {
          _selectionsBloc.add(CreateNewSelectonEvent());
          Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
        },
        child: const SelectionText6());
  }
}

class _AudioDraggableWidget extends StatelessWidget {
  const _AudioDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<AudioTale> talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository()
            .getActiveTalesList();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: DraggableScrollableSheet(
          initialChildSize: 0.57,
          maxChildSize: 0.57,
          minChildSize: 0.57,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        spreadRadius: 3,
                        blurRadius: 10)
                  ],
                  color: Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Stack(
                children: [
                  const _SelectionButtonsAudio(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: talesList.isNotEmpty
                        ? const ActiveTalesListWidget(
                            color: CustomColors.blueSoso,
                          )
                        : const SelectionText9(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SelectionButtonsAudio extends StatelessWidget {
  const _SelectionButtonsAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextButton(onPressed: () {}, child:
            const SelectionText7(),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                TextButton(
                    onPressed: () {
                      context
                          .read<NavigationBloc>()
                          .add(ChangeCurrentIndexEvent(currentIndex: 3));
                    },
                    child: const SelectionText8()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
