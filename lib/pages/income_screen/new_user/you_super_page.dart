import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/texts_consts.dart';
import '../../../widgets/uncategorized/custom_clipper_widget.dart';
import '../../main_screen/main_screen.dart';
import '../auth_bloc/auth_block_bloc.dart';

class YouSuperPage extends StatefulWidget {
  const YouSuperPage({Key? key}) : super(key: key);
  static const routeName = '/new_user/you_super.dart';

  @override
  State<YouSuperPage> createState() => _YouSuperPageState();
}

class _YouSuperPageState extends State<YouSuperPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        MainScreen.routeName,
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthBlockBloc _authBloc = context.read<AuthBlockBloc>();
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).getLocalUser();
    Size screen = MediaQuery.of(context).size;
    _authBloc.add(ContinueButtonCodeEvent(
      auth: RepositoryProvider.of<AuthReposytory>(context),
      user: _user,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColors.blueSoso,
        elevation: 0,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBC(),
            child: Container(
              height: screen.height / 4.5,
              color: CustomColors.blueSoso,
              child: const _YouSuper(),
            ),
          ),
          const _StartRegularUserText1(),
        ],
      ),
    );
  }
}

class _YouSuper extends StatelessWidget {
  const _YouSuper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text(
            TextsConst.youSuper,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 48,
            ),
          ),
        ),
      ],
    );
  }
}

class _StartRegularUserText1 extends StatelessWidget {
  const _StartRegularUserText1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    num screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      SizedBox(
        height: screenHeight / 15,
      ),
      Container(
        child: const Center(
          child: Text(
            TextsConst.hello,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        height: screenHeight / 15,
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: CustomColors.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColors.boxShadow,
              offset: Offset(0, 5),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
      const Icon(
        Icons.favorite,
        color: CustomColors.rose,
        size: 45,
      ),
      SizedBox(
        height: screenHeight / 14,
      ),
    ]);
  }
}
