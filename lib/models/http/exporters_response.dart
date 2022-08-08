
import 'dart:convert';

import 'package:ress_app/models/exporter.dart';

class ExportersResponse {
    ExportersResponse({
        required this.total,
        required this.exportadores,
    });

    int total;
    List<Exportadore> exportadores;

    factory ExportersResponse.fromJson(String str) => ExportersResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ExportersResponse.fromMap(Map<String, dynamic> json) => ExportersResponse(
        total: json["total"],
        exportadores: List<Exportadore>.from(json["exportadores"].map((x) => Exportadore.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "exportadores": List<dynamic>.from(exportadores.map((x) => x.toMap())),
    };
}


