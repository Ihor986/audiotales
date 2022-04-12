// import 'package:flutter/material.dart';

// import '../../utils/consts/colors.dart';
// import '../../widgets/buttons/continue_button_code.dart';
// import '../../widgets/inputs/registration_code_input.dart';
// import '../../widgets/texts/registration_text.dart';
// import '../../widgets/uncategorized/custom_clipper_widget.dart';

// class RegistrationPageCode extends StatelessWidget {
//   const RegistrationPageCode({Key? key}) : super(key: key);
//   static const routeName = '/new_user/registration_code.dart';

//   @override
//   Widget build(BuildContext context) {
//     // num screenWidth = MediaQuery.of(context).size.width;
//     num screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: blueSoso,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               ClipPath(
//                 clipper: OvalBC(),
//                 child: Container(
//                   height: screenHeight / 4.5,
//                   color: blueSoso,
//                   child: const RegistrationText(),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight / 20,
//               ),
//               const RegistrationText3(),
//               SizedBox(
//                 height: screenHeight / 50,
//               ),
//               const RegistrationCodeInput(),
//             ],
//           ),
//           const ContinueButtonCode(),
//         ],
//       ),
//     );
//   }
// }
