import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static replaceTo(String routeName) async {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  static pop() async {
    navigatorKey.currentState!
    .pushNamedAndRemoveUntil('/auth/login', (Route<dynamic> route) => false);
  }
}
