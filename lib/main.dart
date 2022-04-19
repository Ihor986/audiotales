// import 'package:firebase_auth/firebase_auth.dart';
import 'package:audiotales/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc/auth_bloc/auth_block_bloc.dart';
import 'data_base/local_data_base.dart';
import 'firebase_options.dart';
import 'pages/main_screen/head_screen.dart';
import 'pages/main_screen/main_screen.dart';
import 'pages/main_screen/record_screen.dart';
import 'pages/new_user/new_user.dart';
import 'pages/new_user/registration_phone.dart';
import 'pages/new_user/you_super.dart';
import 'pages/regular_user.dart';
import 'pages/test.dart';
import 'repositorys/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.instance.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewUser = LocalDB.instance.getUser().isNewUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlockBloc>(
            create: (context) => AuthBlockBloc(
                AuthReposytory(''),
                isNewUser
                    ? User(isNewUser: false)
                    : LocalDB.instance.getUser())),
        // BlocProvider<MainscreenBloc>(create: (context) => MainscreenBloc()),
        // BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        // initialRoute: MainScreen.routeName,
        initialRoute:
            isNewUser ? NewUserPage.routeName : RegularUserPage.routeName,
        routes: {
          Test.routeName: (_) => const Test(),
          NewUserPage.routeName: (_) => const NewUserPage(),
          HeadScreen.routeName: (_) => const HeadScreen(),
          MainScreen.routeName: (_) => const MainScreen(),
          RegistrationPage.routeName: (_) => const RegistrationPage(),
          YouSuperPage.routeName: (_) => const YouSuperPage(),
          RegularUserPage.routeName: (_) => const RegularUserPage(),
          RecordScreen.routeName: (_) => const RecordScreen(),
        },
      ),
    );
  }
}
