import 'package:audiotales/utils/consts/colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.66,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
                left: Radius.zero, right: Radius.circular(50)),
            color: white),

        // child: ColoredBox(
        //   color: white,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 16.0,
        //     ).copyWith(
        //       top: 24.0,
        //       bottom: 42.0,
        //     ),
        //     child: Container(
        //         decoration:
        //             BoxDecoration(borderRadius: BorderRadius.circular(50))),
        //   ),
        // ),
      ),
    );
  }
}
