import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/http/modules_response.dart';

class ModulesProvider extends ChangeNotifier {
  List<Modulo> modulos = [];

  getModules() async {
    final resp = await RessApi.httpGet('/modulos');
    final modulosResp = ModulesResponse.fromMap(resp);

    modulos = [...modulosResp.modulos];

    notifyListeners();
  }
}
