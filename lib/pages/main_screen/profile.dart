import 'package:flutter/material.dart';
import '../../data_base/local_data_base.dart';
import '../../utils/consts/custom_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/test.dart';

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // num screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.blueSoso,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    LocalDB.instance.deleteUser();
                  },
                  child: const Text('delete'))),
        ],
        // children: [
        // Column(
        //   children: [
        //     const Text('test'),
        //   ],
        // ),
        // ],
      ),
    );
  }
}
