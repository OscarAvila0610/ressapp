import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/ui/views/blank_view.dart';

import '../ui/views/login_view.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const BlankView();
    }
  });
}
