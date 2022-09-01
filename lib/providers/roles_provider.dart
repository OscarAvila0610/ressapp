import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/http/roles_response.dart';
import 'package:ress_app/models/role.dart';

class RolesProvider extends ChangeNotifier {
  List<Role> roles = [];

  getRoles() async {
    final resp = await RessApi.httpGet('/roles');
    final rolesResp = RoleResponse.fromMap(resp);

    roles = [...rolesResp.roles];

    notifyListeners();
  }
}