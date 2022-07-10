import 'package:audiotales/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ProgresWidget extends StatelessWidget {
  const ProgresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.boxShadow,
      body: Center(
        child: CircularProgressIndicator(color: CustomColors.blueSoso),
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class CircularProgressIndicatorPage {
//   const CircularProgressIndicatorPage._();

//   static const CircularProgressIndicatorPage instance =
//       CircularProgressIndicatorPage._();

//   showProgress({
//     required Size screen,
//     required BuildContext context,
//     // required String id,
//     // required TalesList talesList,
//   }) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return const AlertDialog(
//             content: CircularProgressIndicator(),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(30)),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
