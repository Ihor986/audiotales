import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../services/sound_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../main_screen_block/main_screen_bloc.dart';
import 'record_widgets/record_draggable_widget.dart';
import 'record_widgets/record_screen_text.dart';
import 'sound_bloc/sound_bloc.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';
  static const RecordTitleText title = RecordTitleText();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    // final SoundService _sound = context.read<MainScreenBloc>().sound;
    return Scaffold(
      appBar: _RecordScreenAppBar(
        onAction: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SoundBloc>(create: (context) => SoundBloc()),
        ],
        child: Stack(
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
            const RecordDraggableWidget(),
          ],
        ),
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
      // title: RecordScreen.title,
      // centerTitle: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          RecordScreen.title,
        ],
      ),
      // titleSpacing: 0.00,
      // bottom: _ProfileScreenAppBar(),
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
