import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../data_base/data/local_data_base.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../services/change_profile_servise.dart';
import '../../../services/image_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons_img.dart';
import '../../../utils/consts/texts_consts.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../income_screen/auth_bloc/auth_block_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'profile_widgets/profile_text.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/test.dart';
  static const ProfileText title = ProfileText();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileInitialState>(
      builder: (context, state) {
        final TalesListRepository _taleList =
            context.read<TalesListRepository>();
        final CangeProfileService _cangeProfileService =
            context.read<ProfileBloc>().cangeProfileService;
        final LocalUser _user = context.read<UserRepository>().getLocalUser();
        Size screen = MediaQuery.of(context).size;
        FirebaseAuth auth = FirebaseAuth.instance;
        String _name = _user.name ?? TextsConst.profileTextName;
        // bool isPhoneNotChanged = true;

        return Stack(
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
                    _ProfilePhotoWidget(
                      readOnly: _cangeProfileService.readOnly,
                    ),
                    Padding(
                      padding: EdgeInsets.all(screen.width * 0.03),
                      child: _NameTextField(
                        name: _name,
                        // readOnly: _readOnly,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _cangeProfileService.isChangeNumber
                ? const Align(
                    alignment: Alignment(0, -0.1),
                    child: Text('Введи код из смс'),
                  )
                : const SizedBox(),
            Align(
              alignment: _cangeProfileService.readOnly
                  ? const Alignment(0, -0.2)
                  : const Alignment(0, 0.1),
              child: _cangeProfileService.isChangeNumber
                  ? const _CodeInput()
                  : _ProfilePhoneInput(
                      readOnly: _cangeProfileService.readOnly,
                    ),
            ),
            Align(
              alignment: _cangeProfileService.readOnly
                  ? const Alignment(0, 0)
                  : const Alignment(0, 0.3),
              child: TextButton(
                child: _cangeProfileService.readOnly
                    ? const EditeText()
                    : const SaveText(),
                onPressed: () {
                  if (_cangeProfileService.readOnly &&
                      !_cangeProfileService.isChangeNumber) {
                    context.read<ProfileBloc>().add(
                          ProfileEditingEvent(newName: _name, user: _user),
                        );
                    print('ProfileEditingEvent');
                  }
                  if (_cangeProfileService.phone == null) {
                    return;
                  }
                  if (_cangeProfileService.phone!.length < 13) {
                    return;
                  }
                  if (!_cangeProfileService.isChangeNumber &&
                      !_cangeProfileService.readOnly) {
                    context.read<ProfileBloc>().add(
                          SaveEditingEvent(user: _user),
                        );
                    print('SaveEditingEvent');
                  }
                  if (!_cangeProfileService.readOnly &&
                      _cangeProfileService.isChangeNumber &&
                      _cangeProfileService.smsCode.length < 6) {
                    context.read<ProfileBloc>().add(
                          SaveChangedPhoneEvent(),
                        );
                    print('SaveChangedPhoneEvent');
                  }
                  if (!_cangeProfileService.readOnly &&
                      _cangeProfileService.isChangeNumber &&
                      _cangeProfileService.smsCode.length == 6) {
                    context.read<ProfileBloc>().add(
                          SaveEditingWithPhoneEvent(user: _user),
                        );
                    print('SaveEditingWithPhoneEvent');
                  }
                },
              ),
            ),
            _cangeProfileService.readOnly
                ? Align(
                    alignment: const Alignment(0, 0.3),
                    child: TextButton(
                      child: const SubscribeText(),
                      onPressed: () {},
                    ),
                  )
                : const SizedBox(),
            _cangeProfileService.readOnly
                ? Align(
                    alignment: const Alignment(0, 0.45),
                    child: _CustomProgressIndicator(taleList: _taleList),
                  )
                : const SizedBox(),
            _cangeProfileService.readOnly
                ? Align(
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
                  )
                : const SizedBox(),
          ],
          // ),
          // drawer: const CustomDrawer(),
        );
      },
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({
    Key? key,
    required this.name,
    // required this.readOnly,
  }) : super(key: key);

  // final bool readOnly;
  final String? name;
  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profile = context.read<ProfileBloc>();
    final CangeProfileService _changeName = _profile.cangeProfileService;
    Size screen = MediaQuery.of(context).size;
    return SizedBox(
      width: screen.width * 0.44,
      child: TextFormField(
        decoration: InputDecoration(
          border: _changeName.readOnly ? InputBorder.none : null,
        ),
        initialValue: name,
        onChanged: (value) {
          _profile.add(ChangeNameEvent(newName: value));
        },
        readOnly: _changeName.readOnly,
        style: const TextStyle(color: CustomColors.black),
        textAlign: TextAlign.center,
      ),
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
  const _ProfilePhotoWidget({
    Key? key,
    required this.readOnly,
  }) : super(key: key);

  final bool readOnly;

  @override
  State<_ProfilePhotoWidget> createState() => _SelectionPhotoWidgetState();
}

class _SelectionPhotoWidgetState extends State<_ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    final ProfileBloc _profile = context.read<ProfileBloc>();
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    Size screen = MediaQuery.of(context).size;
    DecorationImage? _decorationImageReadOnly() {
      if (_user.photo != null) {
        try {
          return DecorationImage(
              image: MemoryImage(File(_user.photo ?? '').readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (_) {}
      }

      if (_user.photoUrl != null) {
        try {
          return DecorationImage(
            image: NetworkImage(_user.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    DecorationImage? _decorationImage() {
      if (_profile.cangeProfileService.photo != null) {
        try {
          return DecorationImage(
              image: MemoryImage(
                  File(_profile.cangeProfileService.photo!).readAsBytesSync()),
              fit: BoxFit.cover);
        } catch (_) {}
      }
      if (_profile.cangeProfileService.photoUrl != null) {
        try {
          return DecorationImage(
            image: NetworkImage(_profile.cangeProfileService.photoUrl ?? ''),
            fit: BoxFit.cover,
          );
        } catch (_) {
          return _decorationImageReadOnly();
        }
      }
      return _decorationImageReadOnly();
    }

    return Container(
      width: screen.height * 0.25,
      height: screen.height * 0.25,
      decoration: BoxDecoration(
        image:
            widget.readOnly ? _decorationImageReadOnly() : _decorationImage(),
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
      child: widget.readOnly
          ? null
          : IconButton(
              onPressed: () async {
                _profile.cangeProfileService.photo =
                    await ImageServise().pickImageToCasheMemory();
                setState(() {});
              },
              icon: const ImageIcon(
                CustomIconsImg.emptyfoto,
                color: CustomColors.iconsColorPlayRecUpbar,
                size: 50,
              ),
            ),
    );
  }
}

class _ProfilePhoneInput extends StatefulWidget {
  const _ProfilePhoneInput({
    Key? key,
    required this.readOnly,
  }) : super(key: key);

  final bool readOnly;

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
    User? user = FirebaseAuth.instance.currentUser;
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
          readOnly: widget.readOnly,
          // autofocus: true,
          onChanged: (value) {
            context.read<ProfileBloc>().add(ChangePhoneEvent(
                newPhone: '+38${maskFormatter.getUnmaskedText()}',
                user: _user));
            // authReposytory.phoneNumberForVerification =
            //     '+380${maskFormatter.getUnmaskedText()}';
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

class _CodeInput extends StatefulWidget {
  const _CodeInput({Key? key}) : super(key: key);

  @override
  State<_CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<_CodeInput> {
  final maskFormatter = MaskTextInputFormatter(
      mask: '######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    // final AuthReposytory authReposytory =
    //     RepositoryProvider.of<AuthReposytory>(context);
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
          autofocus: false,
          onChanged: (value) {
            context.read<ProfileBloc>().add(ChangeCodeEvent(
                  code: maskFormatter.getUnmaskedText(),
                ));
            // authReposytory.smsCode = maskFormatter.getUnmaskedText();
          },
          textAlign: TextAlign.center,
          // style: const TextStyle(
          //   letterSpacing: 10,
          // ),
          cursorRadius: const Radius.circular(41.0),
          keyboardType: TextInputType.number,
          inputFormatters: [
            maskFormatter,
          ],
          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
            hintText: 'XXXXXX',
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
