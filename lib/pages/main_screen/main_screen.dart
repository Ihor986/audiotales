import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../routes/app_router.dart';
import '../../services/sound_service.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/drawer/custom_drawer.dart';
import '../deleted_screen/deleted_screen.dart';
import '../income_screen/new_user/registration_page.dart';
import '../search_screen/search_page.dart';
import '../subscribe_screen/subscribe_page.dart';
import 'audios_screen/audios_screen.dart';
import 'audios_screen/bloc/audio_screen_bloc.dart';
import 'head_screen/head_screen_page.dart';
import 'main_screen_block/main_screen_bloc.dart';
import 'profile/profile.dart';
import 'record_screen/record_screen.dart';
import 'selections_screen/selections_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/main_screen.dart';
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;
    final FirebaseAuth auth = FirebaseAuth.instance;
    const List<String> _pages = [
      HeadScreen.routeName,
      SelectionsScreen.routeName,
      RecordScreen.routeName,
      AudiosScreen.routeName,
      Profile.routeName,
      SearchScreen.routeName,
      DeletedScreen.routeName,
      SubscribeScreen.routeName,
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioScreenBloc>(
          create: (_) => AudioScreenBloc(_soundService),
        ),
      ],
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (_, state) {
          if (_navigatorKey.currentState != null) {
            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
              _pages.elementAt(state.pageIndex),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Navigator(
              key: _navigatorKey,
              initialRoute: HeadScreen.routeName,
              onGenerateRoute: AppRouter.generateRoute,
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              onTap: (index) {
                _onTap(
                  index: index,
                  auth: auth,
                  soundService: _soundService,
                  context: context,
                  state: state,
                );
              },
            ),
            drawerEnableOpenDragGesture: false,
            drawer: const CustomDrawer(),
            extendBody: true,
            resizeToAvoidBottomInset: false,
          );
        },
      ),
      // ),
    );
  }
}

void _onTap({
  required int index,
  required NavigationState state,
  required FirebaseAuth auth,
  required BuildContext context,
  required SoundService soundService,
}) {
  if (state.pageIndex == index || soundService.recorder.isRecording) return;
  if (auth.currentUser == null && index == 4) {
    index = 0;
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      RegistrationPage.routeName,
      (_) => false,
    );
  } else {
    context
        .read<NavigationBloc>()
        .add(ChangeCurrentIndexEvent(currentIndex: index));
  }
}
