import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/destination.dart';
import 'package:ress_app/models/http/destinations_response.dart';

class DestinationsProviders extends ChangeNotifier {
  List<Destino> destinos = [];

  getDestinations() async {
    final resp = await RessApi.httpGet('/destinos');
    final destinationsResp = DestinationsResponse.fromMap(resp);

    destinos = [...destinationsResp.destinos];

    notifyListeners();
  }

  Future newDestination(String prefix, String country, String name) async {
    final data = {'prefijo': prefix, 'pais': country, 'nombre': name};

    try {
      final json = await RessApi.post('/destinos', data);
      final newDestination = Destino.fromMap(json);

      destinos.add(newDestination);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future updateDestination(
      String id, String prefix, String country, String name) async {
    final data = {'prefijo': prefix, 'pais': country, 'nombre': name};

    try {
      await RessApi.put('/destinos/$id', data);

      destinos = destinos.map((destino) {
        if (destino.id != id) return destino;
        destino.prefijo = prefix;
        destino.pais = country;
        destino.nombre = name;
        return destino;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar categoria';
    }
  }

  Future deleteDestination(String id) async {
    try {
      await RessApi.delete('/destinos/$id', {});

      destinos.removeWhere((destino) => destino.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }
}
