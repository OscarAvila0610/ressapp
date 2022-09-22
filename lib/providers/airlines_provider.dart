import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/airline.dart';
import 'package:ress_app/models/http/airlines_response.dart';

class AirlinesProvider extends ChangeNotifier {
  List<Aerolinea> aerolineas = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getAirlines() async {
    final resp = await RessApi.httpGet('/aerolineas');
    final airlinesResp = AirlinesResponse.fromMap(resp);

    aerolineas = [...airlinesResp.aerolineas];

    notifyListeners();
  }

  Future newAirline(int prefix, String name, String station) async {
    final data = {'prefijo': prefix, 'nombre': name, 'estacion': station};

    try {
      final json = await RessApi.post('/aerolineas', data);
      final newAirline = Aerolinea.fromMap(json);

      aerolineas.add(newAirline);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Aerolinea';
    }
  }

  Future updateAirline(
      String id, int prefix, String name, String station) async {
    final data = {'prefijo': prefix, 'nombre': name, 'estacion': station};

    try {
      await RessApi.put('/aerolineas/$id', data);

      aerolineas = aerolineas.map((aerolinea) {
        if (aerolinea.id != id) return aerolinea;
        aerolinea.prefijo = prefix;
        aerolinea.nombre = name;
        aerolinea.estacion = station;
        return aerolinea;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Aerolinea';
    }
  }

  Future deleteAirline(String id) async {
    try {
      await RessApi.delete('/aerolineas/$id', {});

      aerolineas.removeWhere((aerolinea) => aerolinea.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar aerolinea';
    }
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }
}
