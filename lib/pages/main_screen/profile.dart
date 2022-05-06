import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_bloc/auth_block_bloc.dart';
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
    FirebaseAuth auth = FirebaseAuth.instance;
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
                    auth.signOut();
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
