import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../routes/app_router.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/drawer/custom_drawer.dart';
import '../../widgets/toasts/alert_microphone_permision.dart';
import '../deleted_screen/deleted_screen.dart';
import '../income_screen/new_user/registration_page.dart';
import '../search_screen/search_page.dart';
import '../subscribe_screen/subscribe_page.dart';
import 'audios_screen/audios_screen.dart';
import 'head_screen/head_screen_page.dart';
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

    return BlocConsumer<NavigationBloc, NavigationState>(
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
                context: context,
              );
            },
          ),
          drawerEnableOpenDragGesture: false,
          drawer: const CustomDrawer(),
          extendBody: true,
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }

  Future<void> _onTap({
    required int index,
    required FirebaseAuth auth,
    required BuildContext context,
  }) async {
    if (index == 2) {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        context
            .read<NavigationBloc>()
            .add(ChangeCurrentIndexEvent(currentIndex: 0));
        MicrophonePermissionConfirmAlert.instance.confirm(context: context);
        return;
      }
    }
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
}
