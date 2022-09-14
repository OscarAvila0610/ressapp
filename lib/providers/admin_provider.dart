import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';
import 'package:ress_app/models/exporter.dart';
import 'package:ress_app/models/http/exporters_response.dart';

import 'package:ress_app/models/http/kgs_by_exporters.dart';

class AdminProvider extends ChangeNotifier {
  List<Totaleskg> kgsExporter = [];
  List<Exportadore> exportadores = [];
  List<Totaleskg> listaFinal = [];

  getKgsByExporter() async {
    try {
      final resp = await RessApi.httpGet('/reservas/totalKilos');
      final totalsResp = KgsByExporter.fromMap(resp);
      final respExp = await RessApi.httpGet('/exportadores');
      final exportadoresResp = ExportersResponse.fromMap(respExp);

      exportadores = [...exportadoresResp.exportadores];
      kgsExporter = [...totalsResp.totaleskgs];

      for (var i = 0; i < kgsExporter.length; i++) {
        for (var j = 0; j < exportadores.length; j++) {
          if (kgsExporter[i].id == exportadores[j].id) {
            final data = Totaleskg(
                id: exportadores[j].nombre,
                totalVolumen: kgsExporter[i].totalVolumen);
            listaFinal.add(data);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
