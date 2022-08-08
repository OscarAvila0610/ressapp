import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';
import 'package:ress_app/models/http/users_response.dart';

import 'package:ress_app/models/user.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  UsersProvider() {
    getPaginatedUsers();
  }

  getPaginatedUsers() async {
    final resp = await RessApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResponse = UsersResponse.fromMap(resp);

    users = [...usersResponse.usuarios];
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserbyId(String uid) async {
    try {
      final resp = await RessApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    users = users.map((user) {
      if (user.uid == newUser.uid) {
        user = newUser;
      }
      return user;
    }).toList();

    notifyListeners();
  }
}
