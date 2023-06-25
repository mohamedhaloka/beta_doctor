import 'package:beta_doctor/routers/routers.dart';
import 'package:beta_doctor/services/audio_call/pages/video_call_page.dart';
import 'package:beta_doctor/services/authentication/login/pages/login.dart';
import 'package:beta_doctor/services/authentication/register/pages/registration_page.dart';
import 'package:beta_doctor/services/chat_room/pages/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/pages/base_page.dart';
import '../services/chat_room/blocs/chat_room_bloc.dart';
import '../services/chats/model/chat_model.dart';
import '../services/splash/pages/splash_page.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.easeInOut;
var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static _pageRoute(Widget screen) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _pageRoute(const SplashPage());
      case Routes.register:
        return _pageRoute(const RegistrationPage());
      case Routes.login:
        return _pageRoute(const LoginPage());
      case Routes.home:
        return _pageRoute(const BasePage());
      case Routes.videoCall:
        final ChatModel chatModel = settings.arguments as ChatModel;
        return _pageRoute(const VideoCallPage());
      case Routes.audioCall:
        final ChatModel chatModel = settings.arguments as ChatModel;
        return _pageRoute(const VideoCallPage());
      case Routes.chatRoom:
        final List args = settings.arguments as List;
        return _pageRoute(
          ChatRoomPage(
            args[0],
            userId: args[1],
          ),
        );
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
