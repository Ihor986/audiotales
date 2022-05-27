import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../routes/app_router.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';
import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/custom_drawer.dart';
import 'audios_screen/audios_screen.dart.dart';
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
      const AudiosScreen(),
      const Profile(),
    ];

    List<Widget> _titles = [
      HeadScreen.title,
      SelectionsScreen.title,
      RecordScreen.title,
      AudiosScreen.title,
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
            appBar: _appBar(
                index: state.currentIndex, titles: _titles, context: context),
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

AppBar? _appBar(
    {required int index,
    required List<Widget> titles,
    required BuildContext context}) {
  Size screen = MediaQuery.of(context).size;
  if (index == 2 || index == 4) {
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      elevation: 0,
      title: titles[index],
      centerTitle: true,
    );
  }
  if (index == 3) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.width * 0.04),
          child: Column(
            children: [
              IconButton(
                icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
                // tooltip: 'Open shopping cart',
                onPressed: () {},
              ),
              const SizedBox(),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.audiotalesHeadColorBlue,
      elevation: 0,
      title: titles[index],
      centerTitle: true,
    );
  }
  return null;
}
