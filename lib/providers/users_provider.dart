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

  Future newUser(String email,String name, String rol,
      String exportador) async {
    final data = {
      'nombre': name,
      'correo': email,
      'rol': rol,
      'exportador': exportador
    };

    try {
      final json = await RessApi.post('/usuarios', data);
      final newUser = Usuario.fromMap(json);

      users.add(newUser);
      notifyListeners();
    } catch (e) {
      print(e);
      throw 'Error al crear Usuario';
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

  Future deleteUser(String id) async {
    try {
      await RessApi.delete('/usuarios/$id', {});

      users.removeWhere((user) => user.uid == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar usuario';
    }
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
