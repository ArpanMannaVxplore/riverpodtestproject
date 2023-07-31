import 'package:flutter/material.dart';

class NavigationService {
  /// Creating the first instance
  static final NavigationService _instance = NavigationService._internal();
  NavigationService._internal();

  /// With this factory setup, any time  NavigationService() is called
  /// within the appication _instance will be returned and not a new instance
  factory NavigationService() => _instance;

  ///This would allow the app monitor the current screen state during navigation.
  ///
  ///This is where the singleton setup we did
  ///would help as the state is internally maintained
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  /// For navigating back to the previous screen
  dynamic goBack([dynamic popValue]) {
    return navigationKey.currentState?.pop(popValue);
  }

  /// This allows you to naviagte to the next screen by passing the screen widget
  Future<dynamic> navigateToScreen(Widget page, {arguments}) async => navigationKey.currentState?.push(
    // MaterialPageRoute(
    //   builder: (_) => page,
    // ),
    PageRouteBuilder(
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return
          ScaleTransition(
          alignment: Alignment.center,
          scale:
          Tween<double>(begin: 0.1, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      },
    ),
  );


  /// This allows you to naviagte to the next screen and
  /// also replace the current screen by passing the screen widget
  Future<dynamic> replaceScreen(Widget page, {arguments}) async => navigationKey.currentState?.pushReplacement(
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );

  /// Allows you to pop to the first screen to when the app first launched.
  /// This is useful when you need to log out a user,
  /// and also remove all the screens on the navigation stack.
  /// I find this very useful
  void popToFirst() => navigationKey.currentState?.popUntil((route) => route.isFirst);
}