import 'package:audiotales/pages/outher/deleted_screen/deleted_screen_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../main_screen/selections_screen/bloc/selections_bloc.dart';

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({Key? key}) : super(key: key);
  static const routeName = '/deleted_screen.dart';
  static const DeletedScreenTitleText title = DeletedScreenTitleText();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // print('${RepositoryProvider.of<UserRepository>(context).localUser.id}');

    return Scaffold(
      extendBody: true,
      appBar: _appBar(screen, title, context),
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBC(),
                child: Container(
                  height: screen.height / 4.5,
                  color: CustomColors.oliveSoso,
                ),
              ),
            ],
          ),
          // const Align(
          //     alignment: Alignment(0, -0.6), child: _WrapSelectionsList()),
        ],
      ),
    );
  }
}

AppBar _appBar(screen, title, context) {
  final SelectionsBloc _selectionsBloc =
      BlocProvider.of<SelectionsBloc>(context);
  return AppBar(
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: screen.width * 0.04),
        child: Column(
          children: [
            IconButton(
              icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
              // tooltip: 'Open shopping cart',
              onPressed: () {},
            ),
            const SizedBox(),
          ],
        ),
      ),
    ],
    backgroundColor: CustomColors.oliveSoso,
    centerTitle: true,
    elevation: 0,
    title: title,
    leading: Padding(
      padding: EdgeInsets.only(
        left: screen.width * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: ImageIcon(
              CustomIconsImg.plusPlus,
              color: CustomColors.white,
              size: screen.width * 0.06,
            ),
            onPressed: () {},
          ),
          const SizedBox(),
        ],
      ),
    ),
  );
}
