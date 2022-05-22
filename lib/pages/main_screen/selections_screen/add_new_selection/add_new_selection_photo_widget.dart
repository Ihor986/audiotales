import 'package:audiotales/models/user.dart';
import 'package:audiotales/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/consts/custom_colors.dart';
import '../../../../../utils/consts/custom_icons_img.dart';

class AddNewSelectionPhotoWidget extends StatefulWidget {
  const AddNewSelectionPhotoWidget({Key? key}) : super(key: key);

  @override
  State<AddNewSelectionPhotoWidget> createState() =>
      _AddNewSelectionPhotoWidget();
}

class _AddNewSelectionPhotoWidget extends State<AddNewSelectionPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    // final SoundBloc _soundBloc = BlocProvider.of<SoundBloc>(context);
    // final UserRepository _user = RepositoryProvider.of<UserRepository>(context);
    Size screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.92,
      height: screen.height * 0.25,
      decoration: const BoxDecoration(
        image
            // : _user.localUser.photoUrl != null
            //     ? DecorationImage(
            //         image: NetworkImage(_user.localUser.photoUrl!),
            //         // image: MemoryImage(
            //         //     File(_user.localUser.photoUrl!).readAsBytesSync()),
            //         fit: BoxFit.cover)
            : null,
        // fit: BoxFit.cover
        boxShadow: [
          BoxShadow(
              color: CustomColors.boxShadow, spreadRadius: 3, blurRadius: 10)
        ],
        color: CustomColors.whiteOp,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child:
          //  _user.localUser.photoUrl == null
          //     ?
          IconButton(
        onPressed: () async {
          // await ImageServise().pickImage(LocalUser());
          // setState(() {});
        },
        icon: const ImageIcon(
          CustomIconsImg.emptyfoto,
          color: CustomColors.iconsColorPlayRecUpbar,
          size: 50,
        ),
      ),
      // : null,
    );
  }
}
