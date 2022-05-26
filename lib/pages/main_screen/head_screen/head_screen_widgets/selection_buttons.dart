import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../../utils/consts/custom_colors.dart';
import '../../../../widgets/texts/main_screen_text.dart';

class SelectionButtons extends StatelessWidget {
  const SelectionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        color: CustomColors.blueSoso,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  context
                      .read<NavigationBloc>()
                      .add(ChangeCurrentIndexEvent(currentIndex: 1));
                },
                child: const SelectionText1()),
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
                    child: const SelectionText2()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
