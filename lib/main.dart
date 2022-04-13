import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'bloc/auth_bloc/auth_block_bloc.dart';
import 'firebase_options.dart';
import 'pages/head_screen/head_screen.dart';
import 'pages/new_user/new_user.dart';
import 'pages/new_user/registration_phone.dart';
import 'pages/new_user/you_super.dart';
import 'pages/regular_user.dart';
import 'pages/test.dart';
import 'repositorys/auth.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewUser = false;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlockBloc>(
            create: (context) => AuthBlockBloc(AuthReposytory(''))),
      ],
      child:
          // Builder(builder: (context) {
          //   return
          MaterialApp(
        debugShowCheckedModeBanner: true,
        // initialRoute: isNewUser ? Test.routeName : Test.routeName,
        initialRoute:
            isNewUser ? NewUserPage.routeName : RegularUserPage.routeName,
        routes: {
          Test.routeName: (_) => const Test(),
          NewUserPage.routeName: (_) => const NewUserPage(),
          HeadScreen.routeName: (_) => const HeadScreen(),
          RegistrationPage.routeName: (_) => const RegistrationPage(),
          YouSuperPage.routeName: (_) => const YouSuperPage(),
          RegularUserPage.routeName: (_) => const RegularUserPage(),
        },
        // home: newUser ? RegistrationPageCode() : RegularUserPage(),
      ), //;
      // }),
    );
  }
}
