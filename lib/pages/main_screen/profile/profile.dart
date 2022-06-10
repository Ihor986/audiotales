import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../data_base/data/local_data_base.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../services/image_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import 'bloc/profile_bloc.dart';
import 'profile_widgets/profile_text.dart';

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
    return
        //  Scaffold(
        //   extendBody: true,
        //   appBar: AppBar(
        //     backgroundColor: CustomColors.blueSoso,
        //     elevation: 0,
        //     title: title,
        //   ),
        // body:
        Stack(
      children: [
        ClipPath(
          clipper: OvalBC(),
          child: Container(
            height: screen.height * 0.22,
            color: CustomColors.blueSoso,
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.98),
          child: Container(
            // color: CustomColors.blueSoso,
            height: screen.height * 0.35,
            child: Column(
              children: [
                const _ProfilePhotoWidget(),
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
          child: _ProfilePhoneInput(),
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
          alignment: const Alignment(0, 0.3),
          child: TextButton(
            child: const SubscribeText(),
            onPressed: () {},
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.45),
          child: _CustomProgressIndicator(taleList: _taleList),
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
      // ),
      // drawer: const CustomDrawer(),
    );
  }
}

class _CustomProgressIndicator extends StatelessWidget {
  const _CustomProgressIndicator({
    Key? key,
    required this.taleList,
  }) : super(key: key);
  final TalesListRepository taleList;
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    const num _maxCloudSize = 500;
    final num _activeCloudSize =
        taleList.getTalesListRepository().getTalesListSize() / 1048576;
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
}

class _ProfilePhotoWidget extends StatefulWidget {
  const _ProfilePhotoWidget({Key? key}) : super(key: key);

  @override
  State<_ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<_ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.height * 0.25,
      height: screen.height * 0.25,
      decoration: BoxDecoration(
        image: _user.photoUrl != null
            ? DecorationImage(
                image: NetworkImage(_user.photoUrl!),
                fit: BoxFit.cover,
              )
            : null,
        boxShadow: const [
          BoxShadow(
            color: CustomColors.boxShadow,
            spreadRadius: 3,
            blurRadius: 10,
          )
        ],
        color: CustomColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: _user.photoUrl == null
          ? IconButton(
              onPressed: () async {
                await ImageServise().pickImage(_user);
                setState(() {});
              },
              icon: const ImageIcon(
                CustomIconsImg.emptyfoto,
                color: CustomColors.iconsColorPlayRecUpbar,
                size: 50,
              ),
            )
          : null,
    );
  }
}

class _ProfilePhoneInput extends StatefulWidget {
  const _ProfilePhoneInput({Key? key}) : super(key: key);

  @override
  State<_ProfilePhoneInput> createState() => _ProfilePhoneInputState();
}

class _ProfilePhoneInputState extends State<_ProfilePhoneInput> {
  final maskFormatter = MaskTextInputFormatter(
      initialText: '+38(0',
      mask: '+38 (###) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    // final AuthBlockBloc authBloc = context.read<AuthBlockBloc>();
    final AuthReposytory authReposytory =
        RepositoryProvider.of<AuthReposytory>(context);
    //  getUser(UserRepository _user) async {
    //   final user = await _user.localUser;
    //   return user;
    // }

    return Container(
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(41),
        ),
        width: 309,
        height: 59,
        child: TextFormField(
          initialValue: maskFormatter
              .maskText(_user.phone ?? '0000000000000'.substring(3)),
          readOnly: true,
          autofocus: true,
          onChanged: (value) {
            authReposytory.phoneNumberForVerification =
                '+380${maskFormatter.getUnmaskedText()}';
          },
          textAlign: TextAlign.center,
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(41.0)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(246, 246, 246, 1), width: 2.0)),
          ),
        ));
  }
}
