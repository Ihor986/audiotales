import 'dart:io';

import 'package:audiotales/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';
import '../../../repositorys/user_reposytory.dart';

class ProfilePhotoWidget extends StatefulWidget {
  const ProfilePhotoWidget({Key? key}) : super(key: key);

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    // final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    final UserRepository _user = RepositoryProvider.of<UserRepository>(context);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.5,
      height: screen.width * 0.5,
      decoration: BoxDecoration(
        image: _user.localUser.photoUrl != null
            ? DecorationImage(
                image: NetworkImage(_user.localUser.photoUrl!),
                // image: MemoryImage(
                //     File(_user.localUser.photoUrl!).readAsBytesSync()),
                fit: BoxFit.cover)
            : null,
        // fit: BoxFit.cover
        boxShadow: const [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: _user.localUser.photoUrl == null
          ? IconButton(
              onPressed: () async {
                await ImageServise().pickImage(_user.localUser);
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
