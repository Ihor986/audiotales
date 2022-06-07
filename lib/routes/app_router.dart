import 'package:flutter/material.dart';

import '../pages/income_screen/new_user/new_user_page.dart';
import '../pages/income_screen/new_user/registration_page.dart';
import '../pages/income_screen/new_user/you_super_page.dart';
import '../pages/income_screen/regular_user.dart';
import '../pages/main_screen/head_screen/head_screen_page.dart';
import '../pages/main_screen/main_screen.dart';
import '../pages/main_screen/record_screen/record_screen.dart';
import '../pages/main_screen/selections_screen/add_new_selection/add_new_selection_screen.dart';
import '../pages/main_screen/selections_screen/add_new_selection/select_audio/select_audio_screen.dart';
import '../pages/main_screen/selections_screen/selection_screen.dart/selection_screen.dart';
import '../pages/main_screen/selections_screen/selections_screen.dart';
import '../pages/main_screen/audios_screen/audios_screen.dart.dart';
import '../pages/outher/deleted_screen/deleted_screen.dart';

class AppRouter {
  const AppRouter._();

  static List<MaterialPageRoute<dynamic>> generateInitialRoute(bool isNewUser) {
    return [
      isNewUser
          ? MaterialPageRoute(builder: (_) => const NewUserPage())
          : MaterialPageRoute(builder: (_) => const RegularUserPage()),
    ];
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case AudiosScreen.routeName:
        builder = (_) => const AudiosScreen();
        break;

      case RegularUserPage.routeName:
        builder = (_) => const RegularUserPage();
        break;

      case NewUserPage.routeName:
        builder = (_) => const NewUserPage();
        break;

      // case TicketDetailsPage.routeName:
      //   final TicketDetailsPageArguments args =
      //       arguments as TicketDetailsPageArguments;
      //   builder = (_) => TicketDetailsPage(
      //         index: args.index,
      //         title: args.title,
      //       );
      //   break;

      case HeadScreen.routeName:
        builder = (_) => const HeadScreen();
        break;

      case MainScreen.routeName:
        builder = (_) => const MainScreen();
        break;

      case RegistrationPage.routeName:
        builder = (_) => const RegistrationPage();
        break;

      case YouSuperPage.routeName:
        builder = (_) => const YouSuperPage();
        break;

      case RecordScreen.routeName:
        builder = (_) => const RecordScreen();
        break;

      case SelectionsScreen.routeName:
        builder = (_) => const SelectionsScreen();
        break;

      case AddNewSelectionScreen.routeName:
        builder = (_) => const AddNewSelectionScreen();
        break;

      case SelectionScreen.routeName:
        final SelectionScreenPageArguments args =
            arguments as SelectionScreenPageArguments;
        builder = (_) => SelectionScreen(
              selection: args.selection,
            );
        break;

      case SelectAudioScreen.routeName:
        builder = (_) => const SelectAudioScreen();
        break;
      case DeletedScreen.routeName:
        builder = (_) => const DeletedScreen();
        break;

      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
