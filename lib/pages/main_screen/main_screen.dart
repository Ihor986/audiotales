import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../utils/consts/custom_colors.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/custom_drawer.dart';
import '../test.dart';
import 'head_screen.dart';
import 'profile.dart';
import 'record_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main_screen.dart';

  @override
  Widget build(BuildContext context) {
    List _pages = [
      const HeadScreen(),
      const Test(),
      const RecordScreen(),
      const Test(),
      const Profile(),
    ];
    // num screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
        providers: [
          // BlocProvider<MainscreenBloc>(create: (context) => MainscreenBloc()),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        ],
        child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              backgroundColor: CustomColors.blueSoso,
              elevation: 0,
            ),
            body: _pages[state.currentIndex],
            drawer: const CustomDrawer(),
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        }));
  }
}
