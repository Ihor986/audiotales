import 'dart:async';
import 'package:audiotales/models/tales_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user.dart';
import '../../../repositorys/auth.dart';
import '../../../repositorys/tales_list_repository.dart';
import '../../../repositorys/user_reposytory.dart';
import '../../../utils/consts/custom_colors.dart';
import '../../../widgets/texts/start_regular_user_text.dart';
import '../../../widgets/texts/you_super_text.dart';
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
    TalesList _talesList = RepositoryProvider.of<TalesListRepository>(context)
        .getTalesListRepository();
    final LocalUser _user =
        RepositoryProvider.of<UserRepository>(context).localUser;
    Size screen = MediaQuery.of(context).size;
    _authBloc.add(ContinueButtonCodeEvent(
        auth: RepositoryProvider.of<AuthReposytory>(context),
        user: _user,
        talesList: _talesList));
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
              child: const YouSuper(),
            ),
          ),
          const StartRegularUserText1(),
        ],
      ),
    );
  }
}
