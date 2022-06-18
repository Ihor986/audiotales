import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../models/tales_list.dart';
import '../../repositorys/tales_list_repository.dart';
import '../../routes/app_router.dart';
import '../../services/select_audio_to_delete_service.dart';
import '../../services/sound_service.dart';
import '../../utils/consts/custom_colors.dart';
import '../../utils/consts/custom_icons_img.dart';

import '../../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../../widgets/navigation/drawer/custom_drawer.dart';
import '../deleted_screen/bloc/delete_bloc.dart';
import '../deleted_screen/deleted_screen.dart';

import '../deleted_screen/widgets/deleted_screen_text.dart';
import '../search_screen/search_page.dart';
import '../search_screen/widgets/search_text.dart';
import '../subscribe_screen/subscribe_page.dart';
import '../subscribe_screen/widgets/subscribe_text_widget.dart';
import 'audios_screen/audios_screen.dart.dart';
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

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   void initState() {

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final SoundService _soundService =
        BlocProvider.of<MainScreenBloc>(context).sound;
    List _pages = [
      const HeadScreen(),
      const SelectionsScreen(),
      const RecordScreen(),
      const AudiosScreen(),
      const Profile(),
      const SearchScreen(),
      const DeletedScreen(),
      const SubscribeScreen(),
    ];

    List<PreferredSizeWidget?> _appBars = [
      const _HaedScreenAppBar(),
      null,
      const _RecordScreenAppBar(),
      const _AudioScreenAppBar(),
      const _ProfileScreenAppBar(),
      const _SearchScreenAppBar(),
      const _DeletedScreenAppBar(),
      const _SubscribeScreenAppBar(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioScreenBloc>(
          create: (_) => AudioScreenBloc(_soundService),
        ),
      ],
      // child: MultiBlocProvider(
      //   providers: [
      //     BlocProvider<SoundBloc>(
      //         create: (context) => SoundBloc(_soundService)),
      //   ],
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: state.pageIndex < 8 ? _appBars[state.pageIndex] : null,
            body: Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateInitialRoutes: (route, string) {
                return [
                  MaterialPageRoute(
                    builder: (_) => _pages[state.pageIndex],
                  ),
                ];
              },
              onGenerateRoute: AppRouter.generateRoute,
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
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

class _HaedScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HaedScreenAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          HeadScreen.title,
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),

      elevation: 0,
      // title: HeadScreen.title,
      // centerTitle: true,
    );
  }
}

// class _SelectionsScreenAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   const _SelectionsScreenAppBar({Key? key}) : super(key: key);
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
//   @override
//   Widget build(BuildContext context) {
//     final SelectionsBloc _selectionsBloc =
//         BlocProvider.of<SelectionsBloc>(context);
//     Size screen = MediaQuery.of(context).size;
//     return AppBar(
//       actions: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(right: screen.width * 0.04),
//           child: Column(
//             children: [
//               IconButton(
//                 icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
//                 // tooltip: 'Open shopping cart',
//                 onPressed: () {},
//               ),
//               const SizedBox(),
//             ],
//           ),
//         ),
//       ],
//       backgroundColor: CustomColors.oliveSoso,
//       // centerTitle: true,
//       elevation: 0,
//       flexibleSpace: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: const [
//           SizedBox(),
//           SelectionsScreen.title,
//         ],
//       ),

//       // title: SelectionsScreen.title,
//       leading: Padding(
//         padding: EdgeInsets.only(
//           left: screen.width * 0.04,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: ImageIcon(
//                 CustomIconsImg.plusPlus,
//                 color: CustomColors.white,
//                 size: screen.width * 0.06,
//               ),
//               onPressed: () {
//                 _selectionsBloc.add(CreateNewSelectonEvent());
//                 Navigator.pushNamed(context, AddNewSelectionScreen.routeName);
//               },
//             ),
//             const SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _RecordScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _RecordScreenAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      elevation: 0,
      // title: RecordScreen.title,
      // centerTitle: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          RecordScreen.title,
        ],
      ),
      // titleSpacing: 0.00,
      // bottom: _ProfileScreenAppBar(),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _AudioScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _AudioScreenAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.width * 0.04),
          child: Column(
            children: [
              IconButton(
                icon: const ImageIcon(CustomIconsImg.moreHorizRounded),
                onPressed: () {},
              ),
              const SizedBox(),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.audiotalesHeadColorBlue,
      elevation: 0,
      // title: AudiosScreen.title,
      // centerTitle: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          AudiosScreen.title,
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProfileScreenAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      elevation: 0,
      // title: Profile.title,
      // centerTitle: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          Profile.title,
        ],
      ),
      // titleSpacing: 0.00,
      // bottom: _ProfileScreenAppBar(),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _DeletedScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _DeletedScreenAppBar({
    Key? key,
    // required this.height,
  }) : super(key: key);
  // final double height;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
  @override
  Widget build(BuildContext context) {
    final DeleteBloc _deleteBloc = BlocProvider.of<DeleteBloc>(context);
    final TalesList _talesList =
        RepositoryProvider.of<TalesListRepository>(context)
            .getTalesListRepository();
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.width * 0.04),
          child: Column(
            children: [
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                icon: SvgPicture.asset(
                  CustomIconsImg.moreHorizontRounded,
                  // height: 3,
                  // color: CustomColors.black,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text(
                      'Выбрать несколько',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                    value: () {
                      if (_deleteBloc.selectAudioToDeleteService.isChosen) {
                        return;
                      }
                      _deleteBloc.add(SelectDeletedAudioEvent());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      'Удалить все',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                    value: () {
                      _deleteBloc
                          .add(DeleteSelectedAudioEvent(talesList: _talesList));
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      'Восстановить все',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                    value: () {
                      _deleteBloc.add(
                          RestoreSelectedAudioEvent(talesList: _talesList));
                    },
                  ),
                ],
                onSelected: (Function value) {
                  value();
                },
              ),

              // const SizedBox(),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.audiotalesHeadColorBlue,
      elevation: 0,
      // toolbarHeight: 40, // Set this height
      // title: DeletedScreen.title,
      // centerTitle: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(),
          DeletedScreenTitleText(),
        ],
      ),
      // titleSpacing: 0.00,
      // bottom: _ProfileScreenAppBar(),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _SearchScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _SearchScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: screen.width * 0.04),
          child: Column(
            children: [
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                icon: SvgPicture.asset(
                  CustomIconsImg.moreHorizontRounded,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text(
                      '',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                    value: () {},
                  ),
                  PopupMenuItem(
                    child: const Text(
                      '',
                      style: TextStyle(
                        color: CustomColors.black,
                      ),
                    ),
                    value: () {},
                  ),
                ],
                onSelected: (Function value) {
                  value();
                },
              ),
            ],
          ),
        ),
      ],
      backgroundColor: CustomColors.audiotalesHeadColorBlue,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          SearchAppBarText(),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _SubscribeScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _SubscribeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.3);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: CustomColors.blueSoso,
      elevation: 0,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SizedBox(),
          SubscribeScreenTitleText(),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: screen.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                CustomIconsImg.drawer,
                height: 25,
                color: CustomColors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
