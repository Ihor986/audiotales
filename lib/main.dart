import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'data_base/data/local_data_base.dart';
import 'data_base/data_base.dart';
import 'firebase_options.dart';
import 'pages/income_screen/auth_bloc/auth_block_bloc.dart';
import 'pages/income_screen/new_user/new_user_page.dart';
import 'pages/income_screen/new_user/registration_page.dart';
import 'pages/income_screen/new_user/you_super.dart';
import 'pages/main_screen/head_screen/head_screen.dart';
import 'pages/main_screen/main_screen.dart';
import 'pages/main_screen/record_screen/record_screen.dart';
import 'pages/income_screen/regular_user.dart';
import 'pages/main_screen/selections_screen/add_new_selection/add_new_selection_screen.dart';
import 'pages/main_screen/selections_screen/add_new_selection/select_audio/select_audio_screen.dart';
import 'pages/main_screen/selections_screen/selections_screen.dart';
import 'pages/main_screen/selections_screen/selections_text.dart';
import 'pages/test.dart';
import 'repositorys/auth.dart';
import 'repositorys/tales_list_repository.dart';
import 'repositorys/user_reposytory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DataBase.instance.ensureInitialized();
  // await Hive.openBox('testBox');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewUser = LocalDB.instance.getUser().isNewUser == null;

    // User? user = FirebaseAuth.instance.currentUser;
    // isNewUser = user == null ? isNewUser : true;
    // user == null ? print('no user') : print('${user.phoneNumber}');
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => AuthReposytory('')),
        RepositoryProvider(create: (context) => TalesListRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBlockBloc>(
            create: (context) => AuthBlockBloc(),
          ),
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
            SelectionsScreen.routeName: (_) => const SelectionsScreen(),
            AddNewSelectionScreen.routeName: (_) =>
                const AddNewSelectionScreen(),
            SelectAudioScreen.routeName: (_) => const SelectAudioScreen(),
          },
        ),
      ),
    );
  }
}
