import 'dart:io';

import 'package:audiotales/pages/main_screen/selections_screen/selection_screen/selection_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/main_screen_block/main_screen_bloc.dart';
import '../../../models/selection.dart';
import '../../../models/tales_list.dart';
import '../../../repositories/selections_repositiry.dart';
import '../../../repositories/tales_list_repository.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/custom_icons.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../../widgets/uncategorized/player_widget.dart';
import '../record_screen/record_bloc/record_bloc.dart';
import 'add_new_selection/add_new_selection_screen.dart';
import 'bloc/selections_bloc.dart';
import 'widgets/selections_text.dart';

class SelectionsScreen extends StatefulWidget {
  const SelectionsScreen({Key? key}) : super(key: key);
  static const routeName = '/selections_screen.dart';

  @override
  State<SelectionsScreen> createState() => _SelectionsScreenState();
}

class _SelectionsScreenState extends State<SelectionsScreen> {
  SelectionsBloc? bloc;
  @override
  void initState() {
    bloc = context.read<SelectionsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
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
                      height: _screen.height / 5,
                      color: CustomColors.oliveSoso,
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment(0, -0.6),
                child: _WrapSelectionsList(),
              ),
              const PlayerWidget(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    bloc?.add(DisposeEvent());
    super.dispose();
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
    final RecordBloc _soundbloc = context.read<RecordBloc>();
    final TalesList _talesListRep =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    final Size _screen = MediaQuery.of(context).size;
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: _screen.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              readOnly
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        _selectionsBloc.add(
                          SaveAudioWithSelectionsListEvent(
                              talesList: _talesListRep),
                        );
                        _soundbloc.add(SetStateEvent());
                        context.read<MainScreenBloc>().add(SetState());
                        Navigator.pop(context);
                      },
                      child: const SelectSelectionTextAdd()),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.oliveSoso,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(),
          SelectionsText(
            readOnly: readOnly,
          ),
        ],
      ),
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16, bottom: 10),
        icon: SvgPicture.asset(
          CustomIconsImg.plusPlus,
        ),
        onPressed: () {
          _selectionsBloc.add(CreateNewSelectonEvent());
          Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
        },
      ),
    );
  }
}

class _WrapSelectionsList extends StatelessWidget {
  const _WrapSelectionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final List<Selection> _selectionsList = context
            .read<SelectionsListRepository>()
            .getSelectionsListRepository()
            .selectionsList;

        List<Widget> selections = [
          ...List.generate(
            _selectionsList.length,
            (index) => _Selection(
              selection: _selectionsList.elementAt(index),
              readOnly: state.readOnly,
            ),
          )
        ];

        return SizedBox(
          height: _screen.height * 0.75,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              children: selections,
            ),
          ),
        );
      },
    );
  }
}

class _Selection extends StatefulWidget {
  const _Selection({
    Key? key,
    required this.selection,
    required this.readOnly,
  }) : super(key: key);
  final bool readOnly;
  final Selection selection;

  @override
  State<_Selection> createState() => _SelectionState();
}

class _SelectionState extends State<_Selection> {
  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc = context.read<SelectionsBloc>();
    final bool _isCheked = _selectionsBloc
        .selectSelectionsService.selectionsIdList
        .contains(widget.selection.id);

    DecorationImage? decorationImage() {
      if (widget.selection.photo != null) {
        try {
          return DecorationImage(
              image: MemoryImage(
                  File(widget.selection.photo ?? '').readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (_) {}
      }

      if (widget.selection.photoUrl != null) {
        try {
          return DecorationImage(
            image: CachedNetworkImageProvider(widget.selection.photoUrl!),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    return GestureDetector(
      onTap: () {
        if (widget.readOnly) {
          _selectionsBloc.changeSelectionService.readOnly = true;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SelectionScreen(
                selection: widget.selection,
              ),
            ),
            (_) => true,
          );
        } else {
          _selectionsBloc.add(CheckSelectionEvent(id: widget.selection.id));
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: decorationImage(),
                borderRadius: BorderRadius.circular(15),
                color: CustomColors.iconsColorBNB,
              ),
              width: _screen.width * 0.45,
              height: _screen.height * 0.27,
              child: Padding(
                padding: EdgeInsets.all(_screen.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WrapSelectionsListTextName(selection: widget.selection),
                    WrapSelectionsListTextData(selection: widget.selection),
                  ],
                ),
              ),
            ),
            widget.readOnly
                ? const SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: CustomColors.disactive,
                    ),
                    width: _screen.width * 0.45,
                    height: _screen.height * 0.27,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: _screen.width * 0.15,
                        right: _screen.width * 0.15,
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
      ),
    );
  }
}
