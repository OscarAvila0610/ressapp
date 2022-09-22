import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/origin.dart';
import 'package:ress_app/models/http/origins_response.dart';

class OriginsProviders extends ChangeNotifier {
  List<Origene> origenes = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getOrigins() async {
    final resp = await RessApi.httpGet('/origenes');
    final originsResp = OriginsResponse.fromMap(resp);

    origenes = [...originsResp.origenes];

    notifyListeners();
  }

  Future newOrigin(String prefix, String country, String name) async {
    final data = {'prefijo': prefix, 'pais': country, 'nombre': name};

    try {
      final json = await RessApi.post('/origenes', data);
      final newOrigin = Origene.fromMap(json);

      origenes.add(newOrigin);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Origen';
    }
  }

  Future updateOrigin(
      String id, String prefix, String country, String name) async {
    final data = {'prefijo': prefix, 'pais': country, 'nombre': name};

    try {
      await RessApi.put('/origenes/$id', data);

      origenes = origenes.map((origen) {
        if (origen.id != id) return origen;
        origen.prefijo = prefix;
        origen.pais = country;
        origen.nombre = name;
        return origen;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Origen';
    }
  }

  Future deleteOrigin(String id) async {
    try {
      await RessApi.delete('/origenes/$id', {});

      origenes.removeWhere((origen) => origen.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar Origen';
    }
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }
}