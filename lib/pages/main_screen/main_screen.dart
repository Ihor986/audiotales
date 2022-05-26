import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../routes/app_router.dart';
import '../../utils/consts/custom_colors.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/custom_drawer.dart';
import '../test.dart';
import 'head_screen/head_screen_page.dart';
import 'profile/bloc/profile_bloc.dart';
import 'profile/profile.dart';
import 'record_screen/record_screen.dart';
import 'selections_screen/selections_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main_screen.dart';

  @override
  Widget build(BuildContext context) {
    // Size screenHeight = MediaQuery.of(context).size;
    List _pages = [
      const HeadScreen(),
      const SelectionsScreen(),
      const RecordScreen(),
      const Test(),
      const Profile(),
    ];

    List _titles = [
      HeadScreen.title,
      SelectionsScreen.title,
      RecordScreen.title,
      Test.title,
      Profile.title,
    ];

    return MultiBlocProvider(
      providers: [
        // BlocProvider<MainScreenBloc>(create: (context) => MainScreenBloc()),
        BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
      ],
      // child:
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: state.currentIndex == 1
                ? null
                : AppBar(
                    backgroundColor: CustomColors.blueSoso,
                    elevation: 0,
                    title: _titles[state.currentIndex],
                    centerTitle: true,
                  ),
            // body: _pages[state.currentIndex],
            body: Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateInitialRoutes: (route, string) {
                return [
                  MaterialPageRoute(builder: (_) => _pages[state.currentIndex]),
                ];
              },
              onGenerateRoute: AppRouter.generateRoute,
            ),
            drawer: const CustomDrawer(),
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
