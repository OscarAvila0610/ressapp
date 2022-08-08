
import 'dart:convert';

import 'package:ress_app/models/origin.dart';

class OriginsResponse {
    OriginsResponse({
        required this.total,
        required this.origenes,
    });

    int total;
    List<Origene> origenes;

    factory OriginsResponse.fromJson(String str) => OriginsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OriginsResponse.fromMap(Map<String, dynamic> json) => OriginsResponse(
        total: json["total"],
        origenes: List<Origene>.from(json["origenes"].map((x) => Origene.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "origenes": List<dynamic>.from(origenes.map((x) => x.toMap())),
    };
}

