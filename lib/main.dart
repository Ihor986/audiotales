// import 'package:firebase_auth/firebase_auth.dart';
import 'package:audiotales/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc/auth_bloc/auth_block_bloc.dart';
import 'data_base/local_data_base.dart';
import 'firebase_options.dart';
import 'pages/income_screen/new_user/new_user.dart';
import 'pages/income_screen/new_user/registration_phone.dart';
import 'pages/income_screen/new_user/you_super.dart';
import 'pages/main_screen/head_screen.dart';
import 'pages/main_screen/main_screen.dart';
import 'pages/main_screen/record_screen/record_screen.dart';
import 'pages/income_screen/regular_user.dart';
import 'pages/test.dart';
import 'repositorys/auth.dart';
import 'repositorys/user_reposytory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.instance.ensureInitialized();
  await Hive.openBox('testBox');
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

    User? user = FirebaseAuth.instance.currentUser;
    // isNewUser = user == null ? isNewUser : true;
    user == null ? print('no user') : print('${user.phoneNumber}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlockBloc>(
            create: (context) => AuthBlockBloc(
                // AuthReposytory(''),
                isNewUser
                    ? LocalUser(isNewUser: false)
                    : LocalDB.instance.getUser())),
        // BlocProvider<MainscreenBloc>(create: (context) => MainscreenBloc()),
        // BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UserRepository()),
          RepositoryProvider(create: (context) => AuthReposytory('')),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: true,
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
            // SaveRecordScreen.routeName: (_) => const SaveRecordScreen(),
          },
        ),
      ),
    );
  }
}
