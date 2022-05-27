import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/texts/main_screen_text.dart';
import '../../../selections_screen/add_new_selection/add_new_selection_screen.dart';
import '../../../selections_screen/bloc/selections_bloc.dart';

class AddSelectionButton extends StatelessWidget {
  const AddSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectionsBloc _selectionsBloc =
        BlocProvider.of<SelectionsBloc>(context);
    return TextButton(
        onPressed: () {
          // context
          //     .read<NavigationBloc>()
          //     .add(ChangeCurrentIndexEvent(currentIndex: 1));

          _selectionsBloc.add(CreateNewSelectonEvent());
          Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
          // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          //   AddNewSelectionScreen.routeName,
          //   (_) => true,
          // );
        },
        child: const SelectionText6());
  }
}
