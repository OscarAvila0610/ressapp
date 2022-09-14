import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import 'package:ress_app/api/ress_api.dart';
import 'package:ress_app/models/http/auth_response.dart';
import 'package:ress_app/models/user.dart';

import 'package:ress_app/router/router.dart';

import 'package:ress_app/services/local_storage.dart';
import 'package:ress_app/services/navigation_service.dart';
import 'package:ress_app/services/notifications_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }
  login(String email, String password) {
    //Peticion http

    final data = {
      'correo': email,
      'password': password,
    };

    RessApi.post('/auth/login', data).then((json) {
      // print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('x-token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.blankRoute);

      RessApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      // print('error en: $e');
      NotificationsService.showSnackbarError('USUARIO / PASSWORD NO VALIDOS');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('x-token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await RessApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('x-token', authResponse.token);

      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() async {
    await NavigationService.pop();
    LocalStorage.prefs.remove('x-token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    html.window.location.reload();
  }
}
