import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/custom_icons.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'record_widgets/record_draggable_widget.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);
  static const routeName = '/record_screen.dart';

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                  height: screen.height / 4.5,
                  color: CustomColors.blueSoso,
                ),
              ),
            ],
          ),
          const RecordDraggableWidget(),
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
