import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/selections.dart';
import '../../../models/tales_list.dart';
import '../../../repositorys/selections_repositiry.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'add_new_selection/add_new_selection_screen.dart';
import 'bloc/selections_bloc.dart';
import 'selection_screen.dart/selection_screen.dart';
import 'selections_text.dart';

class SelectionsScreen extends StatelessWidget {
  const SelectionsScreen({Key? key}) : super(key: key);
  static const routeName = '/selections_screen.dart';
  static const SelectionsText title = SelectionsText();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        // print('${RepositoryProvider.of<UserRepository>(context).localUser.id}');

        return Scaffold(
          extendBody: true,
          appBar: _SelectionsScreenAppBar(
            readOnly: state.readOnly,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: OvalBC(),
                    child: Container(
                      height: screen.height / 5,
                      color: CustomColors.oliveSoso,
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: const Alignment(0, -0.6),
                  child: _WrapSelectionsList(
                    readOnly: state.readOnly,
                  )),
            ],
          ),
        );
      },
    );
  }
}

class _SelectionsScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _SelectionsScreenAppBar({
    Key? key,
    required this.readOnly,
  }) : super(key: key);
  final bool readOnly;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc = context.read<SelectionsBloc>();
    final TalesList _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              readOnly
                  ? const SizedBox()
                  // IconButton(
                  //     icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
                  //     onPressed: () {},
                  //   )
                  : TextButton(
                      onPressed: () {
                        _selectionsBloc.add(
                          SaveAudioWithSelectionsListEvent(
                              talesList: _talesListRep),
                        );
                      },
                      child: Text('Add')),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.oliveSoso,

      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          SizedBox(),
          SelectionsScreen.title,
          // SizedBox(),
        ],
      ),

      // title: SelectionsScreen.title,
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: ImageIcon(
                CustomIconsImg.plusPlus,
                color: CustomColors.white,
                size: screen.width * 0.06,
              ),
              onPressed: () {
                _selectionsBloc.add(CreateNewSelectonEvent());
                Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WrapSelectionsList extends StatelessWidget {
  const _WrapSelectionsList({
    Key? key,
    required this.readOnly,
  }) : super(key: key);
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        Size screen = MediaQuery.of(context).size;
        final List<Selection> _selectionsList =
            RepositoryProvider.of<SelectionsListRepository>(context)
                .getSelectionsListRepository()
                .selectionsList;

        List<Widget> selections = [];

        for (var selection in _selectionsList) {
          selections.add(
            _Selection(
              selection: selection,
              readOnly: readOnly,
            ),
          );
        }

        return SizedBox(
          height: screen.height * 0.75,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                for (var selection in selections)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selection,
                  )
              ],
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
    required this.readOnly,
  }) : super(key: key);
  final bool readOnly;
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    // SelectionsBloc
    // final SoundService _sound = context.read<MainScreenBloc>().sound;
    final SelectionsBloc _selectionsBloc = context.read<SelectionsBloc>();
    bool _isCheked = _selectionsBloc.selectSelectionsService.selectionsIdList
        .contains(selection.id);
    Size screen = MediaQuery.of(context).size;
    DecorationImage? decorationImage() {
      if (selection.photo != null) {
        try {
          // print(selection.photo);
          return DecorationImage(
              image: MemoryImage(File(selection.photo ?? '').readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (e) {
          // print(e);
        }
      }

      if (selection.photoUrl != null) {
        try {
          return DecorationImage(
            image: NetworkImage(selection.photoUrl ?? ''), // cash network image
            fit: BoxFit.cover,
          );
        } catch (e) {
          return null;
        }
      }
      return null;
    }

    return GestureDetector(
      onTap: () {
        if (readOnly) {
          _selectionsBloc.changeSelectionService.readOnly = true;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SelectionScreen(
                selection: selection,
              ),
            ),
            (_) => true,
          );
        } else {
          _selectionsBloc.add(CheckSelectionEvent(id: selection.id));
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: decorationImage(),
              borderRadius: BorderRadius.circular(15),
              color: CustomColors.iconsColorBNB,
            ),
            width: screen.width * 0.45,
            height: screen.height * 0.27,
            child: Padding(
              padding: EdgeInsets.all(screen.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WrapSelectionsListTextName(selection: selection),
                  WrapSelectionsListTextData(selection: selection),
                ],
              ),
            ),
          ),
          readOnly
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors.disactive,
                  ),
                  width: screen.width * 0.45,
                  height: screen.height * 0.27,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screen.width * 0.15,
                      right: screen.width * 0.15,
                    ),
                    child: _isCheked
                        ? SvgPicture.asset(
                            CustomIconsImg.check,
                            color: CustomColors.white,
                          )
                        : SvgPicture.asset(
                            CustomIconsImg.uncheck,
                            color: CustomColors.white,
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}
