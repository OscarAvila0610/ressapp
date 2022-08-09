
import 'dart:convert';

import 'package:ress_app/models/airline.dart';

class AirlinesResponse {
    AirlinesResponse({
        required this.total,
        required this.aerolineas,
    });

    int total;
    List<Aerolinea> aerolineas;

    factory AirlinesResponse.fromJson(String str) => AirlinesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AirlinesResponse.fromMap(Map<String, dynamic> json) => AirlinesResponse(
        total: json["total"],
        aerolineas: List<Aerolinea>.from(json["aerolineas"].map((x) => Aerolinea.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "aerolineas": List<dynamic>.from(aerolineas.map((x) => x.toMap())),
    };
}


