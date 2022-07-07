import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../../models/user.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../services/change_profile_servise.dart';
import '../../../services/image_service.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../utils/consts/custom_icons.dart';
import '../../../utils/consts/texts_consts.dart';
import '../../../widgets/alerts/progres/show_circular_progress.dart';
import '../../../widgets/alerts/user/delete_user_confirm.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../income_screen/new_user/registration_page.dart';
import 'bloc/profile_bloc.dart';
import 'profile_widgets/profile_text.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routeName = '/profile.dart';
  static const ProfileText title = ProfileText();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<ProfileBloc>().cangeProfileService.dispouse();
    super.initState();
  }

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

        return Scaffold(
          extendBody: true,
          appBar: _ProfileScreenAppBar(
            onAction: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          body: state.isProgress
              ? const ProgresWidget()
              : Stack(
                  children: [
                    ClipPath(
                      clipper: OvalBC(),
                      child: Container(
                        height: screen.height * 0.22,
                        color: CustomColors.blueSoso,
                      ),
                    ),
                    SizedBox(
                      height: screen.height * 0.8,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const Alignment(0, -0.95),
                            child: Container(
                              alignment: const Alignment(0, 0),
                              height: screen.height * 0.35,
                              child: Column(
                                children: [
                                  _ProfilePhotoWidget(
                                    readOnly: _cangeProfileService.readOnly,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(screen.width * 0.02),
                                    child: _NameTextField(
                                      name: _name,
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
                                ? const Alignment(0, -0.1)
                                : const Alignment(0, 0.1),
                            child: _cangeProfileService.isChangeNumber
                                ? const _CodeInput()
                                : _ProfilePhoneInput(
                                    readOnly: _cangeProfileService.readOnly,
                                  ),
                          ),
                          Align(
                            alignment: _cangeProfileService.readOnly
                                ? const Alignment(0, 0.1)
                                : const Alignment(0, 0.3),
                            child: TextButton(
                              child: _cangeProfileService.readOnly
                                  ? const EditeText()
                                  : const SaveText(),
                              onPressed: () {
                                _pressEditing(
                                  cangeProfileService: _cangeProfileService,
                                  name: _name,
                                  user: _user,
                                  context: context,
                                );
                              },
                            ),
                          ),
                          _cangeProfileService.readOnly &&
                                  _user.subscribe == null
                              ? Align(
                                  alignment: const Alignment(0, 0.3),
                                  child: TextButton(
                                    child: const SubscribeText(),
                                    onPressed: () {
                                      context.read<NavigationBloc>().add(
                                          ChangeCurrentIndexEvent(
                                              currentIndex: 7));
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          _cangeProfileService.readOnly &&
                                  _user.subscribe == null
                              ? Align(
                                  alignment: const Alignment(0, 0.45),
                                  child: _CustomProgressIndicator(
                                      taleList: _taleList),
                                )
                              : const SizedBox(),
                          _cangeProfileService.readOnly
                              ? Align(
                                  alignment: const Alignment(0, 0.8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            await auth.signOut();
                                            context.read<NavigationBloc>().add(
                                                  ChangeCurrentIndexEvent(
                                                      currentIndex: 0),
                                                );
                                          },
                                          child: const LogoutText()),
                                      TextButton(
                                          onPressed: () async {
                                            _pressDelete(
                                              context: context,
                                              user: _user,
                                            );
                                          },
                                          child: const DeleteAccountText()),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _pressDelete({
    required BuildContext context,
    required LocalUser user,
  }) {
    Size screen = MediaQuery.of(context).size;
    int now = DateTime.now().millisecondsSinceEpoch.toInt();
    int loginTime = user
            .currentUser?.metadata.lastSignInTime?.millisecondsSinceEpoch
            .toInt() ??
        0;
    bool isNeedSignIn = now - 300000 > loginTime;
    if (isNeedSignIn) {
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        RegistrationPage.routeName,
        (_) => false,
      );
      context
          .read<NavigationBloc>()
          .add(ChangeCurrentIndexEvent(currentIndex: 0));
    } else {
      DeleteUserConfirm.instance.deletedConfirm(
        screen: screen,
        context: context,
      );
    }
  }

  void _pressEditing({
    required CangeProfileService cangeProfileService,
    required BuildContext context,
    required LocalUser user,
    required String name,
  }) {
    bool _isProfileEditingEvent = cangeProfileService.readOnly;
    bool _isSaveEditingEvent =
        !cangeProfileService.isChangeNumber && !cangeProfileService.readOnly;
    bool _isSaveChangedPhoneEvent = !cangeProfileService.readOnly &&
        cangeProfileService.isChangeNumber &&
        cangeProfileService.smsCode.length < 6;
    bool _isSaveEditingWithPhoneEvent = !cangeProfileService.readOnly &&
        cangeProfileService.isChangeNumber &&
        cangeProfileService.smsCode.length == 6;
    if (_isProfileEditingEvent) {
      context.read<ProfileBloc>().add(
            ProfileEditingEvent(newName: name, user: user),
          );
    }
    if (cangeProfileService.phone == null) {
      return;
    }
    if (cangeProfileService.phone!.length < 13) {
      return;
    }
    if (_isSaveEditingEvent) {
      context.read<ProfileBloc>().add(
            SaveEditingEvent(user: user),
          );
    }
    if (_isSaveChangedPhoneEvent) {
      context.read<ProfileBloc>().add(
            SaveChangedPhoneEvent(),
          );
    }
    if (_isSaveEditingWithPhoneEvent) {
      context.read<ProfileBloc>().add(
            SaveEditingWithPhoneEvent(user: user),
          );
    }
  }
}

class _ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProfileScreenAppBar({
    Key? key,
    this.onAction,
  }) : super(key: key);
  final void Function()? onAction;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(),
          Profile.title,
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: onAction,
            ),
            const SizedBox(),
          ],
        ),
      ),
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

    return Container(
      width: screen.height * 0.25,
      height: screen.height * 0.25,
      decoration: BoxDecoration(
        image: widget.readOnly
            ? _decorationImageReadOnly(user: _user)
            : _decorationImage(
                cangeProfileService: _profile.cangeProfileService,
                user: _user,
              ),
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
              icon: SvgPicture.asset(
                CustomIconsImg.emptyfoto,
                color: CustomColors.whiteOp08,
                height: 70,
              ),
            ),
    );
  }
}

DecorationImage? _decorationImageReadOnly({
  required LocalUser user,
}) {
  // if (user.photo != null) {
  //   try {
  //     return DecorationImage(
  //         image: MemoryImage(File(user.photo ?? '').readAsBytesSync()),
  //         fit: BoxFit.cover);
  //   } catch (_) {}
  // }

  if (user.photoUrl != null) {
    try {
      return DecorationImage(
        image: CachedNetworkImageProvider(user.photoUrl ?? ''),
        fit: BoxFit.cover,
      );
    } catch (_) {
      return null;
    }
  }
  return null;
}

DecorationImage? _decorationImage({
  required CangeProfileService cangeProfileService,
  required LocalUser user,
}) {
  if (cangeProfileService.photo != null) {
    try {
      return DecorationImage(
          image:
              MemoryImage(File(cangeProfileService.photo!).readAsBytesSync()),
          fit: BoxFit.cover);
    } catch (_) {}
  }
  if (cangeProfileService.photoUrl != null) {
    try {
      return DecorationImage(
        image: CachedNetworkImageProvider(cangeProfileService.photoUrl ?? ''),
        fit: BoxFit.cover,
      );
    } catch (_) {
      return _decorationImageReadOnly(user: user);
    }
  }
  return _decorationImageReadOnly(user: user);
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
          initialValue: maskFormatter.maskText(
              _user.currentUser?.phoneNumber ?? '0000000000000'.substring(3)),
          readOnly: widget.readOnly,
          // autofocus: true,
          onChanged: (value) {
            context.read<ProfileBloc>().add(ChangePhoneEvent(
                newPhone: '+38${maskFormatter.getUnmaskedText()}',
                user: _user));
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

// // void _pressDelete({
//   required BuildContext context,
//   required LocalUser user,
// }) {
//   Size screen = MediaQuery.of(context).size;
//   int now = DateTime.now().millisecondsSinceEpoch.toInt();
//   int loginTime = user
//           .currentUser?.metadata.lastSignInTime?.millisecondsSinceEpoch
//           .toInt() ??
//       0;
//   bool isNeedSignIn = now - 300000 > loginTime;
//   if (isNeedSignIn) {
//     Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
//       RegistrationPage.routeName,
//       (_) => false,
//     );
//   } else {
//     DeleteUserConfirm.instance.deletedConfirm(
//       screen: screen,
//       context: context,
//     );
//   }
// }

// void _pressEditing({
//   required CangeProfileService cangeProfileService,
//   required BuildContext context,
//   required LocalUser user,
//   required String name,
// }) {
//   bool _isProfileEditingEvent = cangeProfileService.readOnly;
//   bool _isSaveEditingEvent =
//       !cangeProfileService.isChangeNumber && !cangeProfileService.readOnly;
//   bool _isSaveChangedPhoneEvent = !cangeProfileService.readOnly &&
//       cangeProfileService.isChangeNumber &&
//       cangeProfileService.smsCode.length < 6;
//   bool _isSaveEditingWithPhoneEvent = !cangeProfileService.readOnly &&
//       cangeProfileService.isChangeNumber &&
//       cangeProfileService.smsCode.length == 6;
//   if (_isProfileEditingEvent) {
//     context.read<ProfileBloc>().add(
//           ProfileEditingEvent(newName: name, user: user),
//         );
//   }
//   if (cangeProfileService.phone == null) {
//     return;
//   }
//   if (cangeProfileService.phone!.length < 13) {
//     return;
//   }
//   if (_isSaveEditingEvent) {
//     context.read<ProfileBloc>().add(
//           SaveEditingEvent(user: user),
//         );
//   }
//   if (_isSaveChangedPhoneEvent) {
//     context.read<ProfileBloc>().add(
//           SaveChangedPhoneEvent(),
//         );
//   }
//   if (_isSaveEditingWithPhoneEvent) {
//     context.read<ProfileBloc>().add(
//           SaveEditingWithPhoneEvent(user: user),
//         );
//   }
// }
