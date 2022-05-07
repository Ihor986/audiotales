import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data_base/local_data_base.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'profile_phone_input.dart';
import 'profile_photo_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/test.dart';
  static const String title = 'Profile';

//   @override
//   State<Profile> createState() => _Profile();
// }

// class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final UserRepository _user = RepositoryProvider.of<UserRepository>(context);
    Size screen = MediaQuery.of(context).size;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBC(),
          child: Container(
            height: screen.height / 4.5,
            color: CustomColors.blueSoso,
            // child: const TalesSelectionWidget(),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.9),
          child: SizedBox(
            height: screen.width * 0.7,
            child: Column(
              children: [
                ProfilePhotoWidget(),
                Padding(
                  padding: EdgeInsets.all(screen.width * 0.03),
                  child: Text(_user.localUser.name == ''
                      ? 'name'
                      : _user.localUser.name),
                ),
              ],
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment(0, -0.25),
        //   child:
        //       Text(_user.localUser.name == '' ? 'name' : _user.localUser.name),
        // ),
        const Align(
          alignment: Alignment(0, -0.2),
          child: ProfilePhoneInput(),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: TextButton(
            child: const Text('Edite'),
            onPressed: () {},
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.2),
          child: TextButton(
            child: const Text('Subscribe'),
            onPressed: () {},
          ),
        ),
        // const Align(
        //   alignment: Alignment(0, 0.3),
        //   child: ProgressIndicator(
        //     backgroundColor: CustomColors.white,
        //     color: CustomColors.rose,
        //     // valueColor: CustomColors.rose,
        //     value: 0.5,
        //   ),
        // ),
        Align(
            alignment: const Alignment(0, 0.6),
            child: ElevatedButton(
                onPressed: () {
                  LocalDB.instance.deleteUser();
                  auth.signOut();
                },
                child: const Text('delete'))),
      ],
    );
  }
}
