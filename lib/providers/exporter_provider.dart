import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/exporter.dart';
import 'package:ress_app/models/http/exporters_response.dart';

class ExportersProviders extends ChangeNotifier {
  List<Exportadore> exportadores = [];

  getExporters() async {
    final resp = await RessApi.httpGet('/exportadores');
    final exportadoresResp = ExportersResponse.fromMap(resp);

    exportadores = [...exportadoresResp.exportadores];

    notifyListeners();
  }

  Future newExporter(String name, String address, int tel, int iatacode) async {
    final data = {'nombre': name, 'direccion': address, 'telefono': tel, 'codigoIata': iatacode};

    try {
      final json = await RessApi.post('/exportadores', data);
      final newExporter = Exportadore.fromMap(json);

      exportadores.add(newExporter);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Exportador';
    }
  }

  Future updateExporter(
      String id, String name, String address, int tel, int iatacode) async {
    final data = {'nombre': name, 'direccion': address, 'telefono': tel, 'codigoIata': iatacode};

    try {
      await RessApi.put('/exportadores/$id', data);

      exportadores = exportadores.map((exportador) {
        if (exportador.id != id) return exportador;
        exportador.nombre = name;
        exportador.direccion = address;
        exportador.telefono = tel;
        exportador.codigoIata = iatacode;
        return exportador;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar exportador';
    }
  }

  Future deleteExporter(String id) async {
    try {
      await RessApi.delete('/exportadores/$id', {});

      exportadores.removeWhere((exportador) => exportador.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar exportador';
    }
  }
}
