import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/providers.dart';

import 'package:ress_app/router/router.dart';
import 'package:ress_app/ui/views/bookings_view_find.dart';
import 'package:ress_app/ui/views/calculator_view.dart';

import 'package:ress_app/ui/views/views.dart';

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
  static Handler calculator = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.calculatorRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CalculatorView();
    } else {
      return const LoginView();
    }
  });

  static Handler bookings = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.bookingsRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return BookingsView(user: authProvider.user!);
    } else {
      return const LoginView();
    }
  });

  static Handler airlines = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.airlinesRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const AirlinesView();
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
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const DestinationsView();
    } else {
      return const LoginView();
    }
  });

  static Handler containers = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.containersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const ContainersView();
    } else {
      return const LoginView();
    }
  });

  static Handler commodities = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.commoditiesRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const CommoditiesView();
    } else {
      return const LoginView();
    }
  });

  static Handler origins = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.originsRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const OriginsView();
    } else {
      return const LoginView();
    }
  });

  static Handler exporters = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.exportersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
      return const ExportersView();
    } else {
      return const LoginView();
    }
  });

  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (authProvider.user!.rol != 'ADMIN_ROLE') {
        Provider.of<SideMenuProvider>(context, listen: false)
            .setCurrentPageUrl(Flurorouter.dashboardRoute);
        return const DashboardView();
      }
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
  static Handler awb = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.awbRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['awb']?.first != null) {
        return BookingsViewFind(awb: params['awb']!.first, user: authProvider.user!,);
      } else {
        return const UsersView();
      }
    } else {
      return const LoginView();
    }
  });
}
