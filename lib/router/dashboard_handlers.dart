import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/router/router.dart';

import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/sidemenu_provider.dart';

import 'package:ress_app/ui/views/blank_view.dart';
import 'package:ress_app/ui/views/dashboard_view.dart';
import 'package:ress_app/ui/views/destinations_view.dart';
import 'package:ress_app/ui/views/icons_view.dart';
import 'package:ress_app/ui/views/login_view.dart';
import 'package:ress_app/ui/views/user_view.dart';
import 'package:ress_app/ui/views/users_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler icons = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.iconsRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  static Handler destinations = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.destinationsRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DestinationsView();
    } else {
      return const LoginView();
    }
  });

  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });
  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        return UserView(uid: params['uid']!.first);
      } else {
        return const UsersView();
      }
    } else {
      return const LoginView();
    }
  });
}