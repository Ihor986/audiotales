import 'package:audiotales/models/tales_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../models/selections.dart';
import '../../../../../repositorys/selections_repositiry.dart';
import '../../../../models/selection.dart';
import '../../../../repositorys/tales_list_repository.dart';
import '../../../../utils/custom_colors.dart';
import '../../../../utils/custom_icons.dart';
import '../../../../widgets/alerts/progres/show_circular_progress.dart';
import '../../main_screen_block/main_screen_bloc.dart';
import '../add_new_selection/add_new_selections_text.dart';
import '../bloc/selections_bloc.dart';
import '../selection_select_few_screen/selection_select_few_screen.dart';
import '../widgets/selection_screen_body.dart';

class SelectionScreenPageArguments {
  SelectionScreenPageArguments({
    required this.selection,
  });

  final Selection selection;
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({
    Key? key,
    required this.selection,
  }) : super(key: key);
  static const routeName = '/selection_screen.dart';
  final Selection selection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
      builder: (context, state) {
        final SelectionsBloc _selectionsBloc =
            BlocProvider.of<SelectionsBloc>(context);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: _appBar(context, _selectionsBloc, selection),
          body: Stack(
            children: [
              BodySelectionScreen(
                selection: selection,
                readOnly: _selectionsBloc.changeSelectionService.readOnly,
              ),
              if (state.isProgress) const ProgresWidget(),
            ],
          ),
        );
      },
    );
  }
}

AppBar _appBar(
    BuildContext context, SelectionsBloc selectionsBloc, Selection selection) {
  const _TitleSelectionScreen title = _TitleSelectionScreen();
  return AppBar(
    actions: <Widget>[
      _Action(
        selection: selection,
      ),
    ],
    backgroundColor: CustomColors.oliveSoso,
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      padding: const EdgeInsets.only(left: 16),
      icon: SvgPicture.asset(
        CustomIconsImg.arrowLeftCircle,
      ),
      onPressed: () {
        selectionsBloc.changeSelectionService.readOnly = true;
        Navigator.pop(context);
      },
    ),
    title: title,
  );
}

class _Action extends StatelessWidget {
  const _Action({Key? key, required this.selection}) : super(key: key);
  final Selection selection;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final SelectionsBloc _selectionsBloc = context.read<SelectionsBloc>();
    final SelectionsList _selectionsList =
        context.read<SelectionsListRepository>().getSelectionsListRepository();
    final TalesList talesList =
        context.read<TalesListRepository>().getTalesListRepository();
    if (_selectionsBloc.changeSelectionService.readOnly) {
      return Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: Column(
          children: [
            PopupMenuButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              icon: const Icon(Icons.more_horiz_rounded),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Редактировать'),
                  value: () {
                    _selectionsBloc.add(EditAllSelection(
                      selection: selection,
                    ));
                  },
                ),
                PopupMenuItem(
                  child: const Text('Выбрать несколько'),
                  value: () {
                    _selectionsBloc.changeSelectionService.dispouse();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionSelectFewScreen(
                          selection: selection,
                        ),
                      ),
                      (_) => true,
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text('Удалить подборку'),
                  value: () {
                    _selectionsBloc.add(DeleteSelectionEvent(
                      selection: selection,
                      selectionsList: _selectionsList,
                      talesList: talesList,
                    ));
                    Navigator.pop(context);
                  },
                ),
                PopupMenuItem(
                  child: const Text('Поделиться'),
                  value: () {
                    context.read<MainScreenBloc>().add(
                          ShareAudiosEvent(
                            audioList:
                                talesList.getCompilation(id: selection.id),
                            name: selection.name,
                          ),
                        );
                  },
                ),
              ],
              onSelected: (Function value) {
                value();
              },
            ),
            const SizedBox(),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: TextButton(
          child: const AddNewSelectionsTextReady(),
          onPressed: () {
            _selectionsBloc.add(
              SaveChangedSelectionEvent(
                selectionsList: _selectionsList,
                selection: selection,
              ),
            );
            // Navigator.pop(context);
          },
        ),
      );
    }
  }
}

class _TitleSelectionScreen extends StatelessWidget {
  const _TitleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}
