
import 'dart:convert';

import 'package:ress_app/models/container.dart';

class ContainersResponse {
    ContainersResponse({
        required this.total,
        required this.contenedores,
    });

    int total;
    List<Contenedore> contenedores;

    factory ContainersResponse.fromJson(String str) => ContainersResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ContainersResponse.fromMap(Map<String, dynamic> json) => ContainersResponse(
        total: json["total"],
        contenedores: List<Contenedore>.from(json["contenedores"].map((x) => Contenedore.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "contenedores": List<dynamic>.from(contenedores.map((x) => x.toMap())),
    };
}


