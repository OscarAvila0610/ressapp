import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/commodity.dart';

import 'package:ress_app/models/http/commodities_response.dart';

class CommoditiesProviders extends ChangeNotifier {
  List<Tipo> tipoCargas = [];

  getCommodities() async {
    final resp = await RessApi.httpGet('/tipoCargas');
    final commoditiesResp = CommodityResponse.fromMap(resp);

    tipoCargas = [...commoditiesResp.tipos];

    notifyListeners();
  }

  Future newCommodity(String prefix, String name, bool dg) async {
    final data = {'prefijo': prefix, 'nombre': name, 'peligroso': dg};

    try {
      final json = await RessApi.post('/tipoCargas', data);
      final newCommodity = Tipo.fromMap(json);

      tipoCargas.add(newCommodity);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Tipo de Carga';
    }
  }

  Future updateCommodity(String id, String prefix, String name) async {
    final data = {'prefijo': prefix, 'nombre': name};

    try {
      await RessApi.put('/tipoCargas/$id', data);

      tipoCargas = tipoCargas.map((tipoCarga) {
        if (tipoCarga.id != id) return tipoCarga;
        tipoCarga.prefijo = prefix;
        tipoCarga.nombre = name;
        return tipoCarga;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Tipo de Carga';
    }
  }

  Future deleteTipoCarga(String id) async {
    try {
      await RessApi.delete('/tipoCargas/$id', {});

      tipoCargas.removeWhere((tipoCarga) => tipoCarga.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar Tipo de Carga';
    }
  }
}
