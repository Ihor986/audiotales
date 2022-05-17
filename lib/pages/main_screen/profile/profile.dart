import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data_base/data/local_data_base.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'bloc/profile_bloc.dart';
import 'profile_phone_input.dart';
import 'profile_photo_widget.dart';
import 'profile_text.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/test.dart';
  static const ProfileText title = ProfileText();

  @override
  Widget build(BuildContext context) {
    final TalesListRepository _taleList =
        RepositoryProvider.of<TalesListRepository>(context);
    Size screen = MediaQuery.of(context).size;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBC(),
          child: Container(
            height: screen.height / 4.5,
            color: CustomColors.blueSoso,
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.9),
          child: SizedBox(
            height: screen.width * 0.7,
            child: Column(
              children: [
                const ProfilePhotoWidget(),
                Padding(
                  padding: EdgeInsets.all(screen.width * 0.03),
                  child: const NameText(),
                ),
              ],
            ),
          ),
        ),
        const Align(
          alignment: Alignment(0, -0.2),
          child: ProfilePhoneInput(),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: TextButton(
            child: const EditeText(),
            onPressed: () {
              context.read<ProfileBloc>().add(ProfileEditingEvent());
            },
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.2),
          child: TextButton(
            child: const SubscribeText(),
            onPressed: () {},
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.35),
          child: _customProgressIndicutor(screen, _taleList),
        ),
        Align(
          alignment: const Alignment(0, 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  child: const LogoutText()),
              TextButton(
                  onPressed: () {
                    LocalDB.instance.deleteUser();
                    auth.signOut();
                  },
                  child: const DeleteAccountText()),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _customProgressIndicutor(Size screen, TalesListRepository taleList) {
  const num _maxCloudSize = 500;
  final num _activeCloudSize =
      taleList.getTalesListRepository().getTalesListSize() /
          1048576; // if > 500
  // 1024;
  double _customProgressIndicutorVisualLength = screen.width *
      0.9 *
      (_activeCloudSize <= 500 ? _activeCloudSize : 500) /
      _maxCloudSize;
  return SizedBox(
    height: screen.height * 0.05,
    child: Column(
      children: [
        Container(
          width: screen.width * 0.91,
          child: Row(
            children: [
              Container(
                foregroundDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  color: CustomColors.rose,
                ),
                height: screen.height * 0.02,
                width: _customProgressIndicutorVisualLength < 5
                    ? 5
                    : _customProgressIndicutorVisualLength,
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.black),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
        ),
        SizedBox(
          height: screen.height * 0.01,
        ),
        Text(
          '${_activeCloudSize.floor() + 1}/$_maxCloudSize mb',
          style: TextStyle(height: screen.height * 0.001),
        ),
      ],
    ),
  );
}
