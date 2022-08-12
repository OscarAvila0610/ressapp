import 'dart:convert';

import 'package:ress_app/models/commodity.dart';

class CommodityResponse {
    CommodityResponse({
        required this.total,
        required this.tipos,
    });

    int total;
    List<Tipo> tipos;

    factory CommodityResponse.fromJson(String str) => CommodityResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CommodityResponse.fromMap(Map<String, dynamic> json) => CommodityResponse(
        total: json["total"],
        tipos: List<Tipo>.from(json["tipos"].map((x) => Tipo.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "tipos": List<dynamic>.from(tipos.map((x) => x.toMap())),
    };
}


