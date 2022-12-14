import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/api/ress_api.dart';
import 'package:ress_app/services/my_scroll.dart';

import 'providers/providers.dart';

import 'package:ress_app/router/router.dart';

import 'package:ress_app/services/local_storage.dart';
import 'package:ress_app/services/navigation_service.dart';
import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/layouts/auth/auth_layout.dart';
import 'package:ress_app/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:ress_app/ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  RessApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => AirlinesProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => BookingsProvider()),
        ChangeNotifierProvider(create: (_) => RolesProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorFormProvider()),
        ChangeNotifierProvider(create: (_) => ContainersProviders()),
        ChangeNotifierProvider(create: (_) => CommoditiesProviders()),
        ChangeNotifierProvider(create: (_) => DestinationsProviders()),
        ChangeNotifierProvider(lazy: false, create: (_) => ModulesProvider()),
        ChangeNotifierProvider(create: (_) => OriginsProviders()),
        ChangeNotifierProvider(create: (_) => ExportersProviders()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RESapps A.A.',
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messangerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5))),
          unselectedWidgetColor: Colors.white,
          ),
    );
  }
}
