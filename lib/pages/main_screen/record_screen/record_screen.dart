import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/custom_colors.dart';
import '../../../utils/custom_icons.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'record_bloc/record_bloc.dart';
import 'record_widgets/play_record/play_record.dart';
import 'record_widgets/recordering/recordering.dart';
import 'record_widgets/save_record/save_record.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';

  @override
  Widget build(BuildContext context) {
    final Size _screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _RecordScreenAppBar(
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
                  height: _screen.height / 4.5,
                  color: CustomColors.blueSoso,
                ),
              ),
            ],
          ),
          const _RecordDraggableWidget(),
        ],
      ),
    );
  }
}

class _RecordScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _RecordScreenAppBar({
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
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          Text(''),
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
    );
  }
}

class _RecordDraggableWidget extends StatelessWidget {
  const _RecordDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecordBloc _soundBloc = BlocProvider.of<RecordBloc>(context);
    final List<Widget> pages = [
      const Recordering(),
      const PlayRecord(),
      const SaveRecord(),
    ];
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (context, state) {
        return pages.elementAt(_soundBloc.sound.soundIndex);
      },
    );
  }
}
