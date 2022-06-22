import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation_bloc/navigation_bloc.dart';
import 'data_base/data/local_data_base.dart';
import 'data_base/data_base.dart';
import 'firebase_options.dart';
import 'pages/deleted_screen/bloc/delete_bloc.dart';
import 'pages/income_screen/auth_bloc/auth_block_bloc.dart';
import 'pages/main_screen/main_screen_block/main_screen_bloc.dart';
import 'pages/main_screen/profile/bloc/profile_bloc.dart';
import 'pages/main_screen/selections_screen/bloc/selections_bloc.dart';
import 'pages/subscribe_screen/bloc/subscribe_bloc.dart';
import 'repositorys/auth.dart';
import 'repositorys/selections_repositiry.dart';
import 'repositorys/tales_list_repository.dart';
import 'repositorys/user_reposytory.dart';
import 'routes/app_router.dart';
import 'package:bot_toast/bot_toast.dart';

import 'services/sound_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DataBase.instance.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isNewUser = LocalDB.instance.getUser().isNewUser == null &&
        FirebaseAuth.instance.currentUser == null;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => AuthReposytory('')),
        RepositoryProvider(create: (context) => TalesListRepository()),
        RepositoryProvider(create: (context) => SelectionsListRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBlockBloc>(create: (context) => AuthBlockBloc()),
          BlocProvider<SelectionsBloc>(create: (context) => SelectionsBloc()),
          BlocProvider<MainScreenBloc>(create: (context) => MainScreenBloc()),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
          BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
          BlocProvider<DeleteBloc>(create: (context) => DeleteBloc()),
          BlocProvider<SubscribeBloc>(create: (context) => SubscribeBloc()),
        ],
        child: MaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: true,
          onGenerateInitialRoutes: (route) {
            return AppRouter.generateInitialRoute(_isNewUser);
          },
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
