// To parse this JSON data, do
//
//     final destinationsResponse = destinationsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:ress_app/models/destination.dart';

class DestinationsResponse {
    DestinationsResponse({
        required this.total,
        required this.destinos,
    });

    int total;
    List<Destino> destinos;

    factory DestinationsResponse.fromJson(String str) => DestinationsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DestinationsResponse.fromMap(Map<String, dynamic> json) => DestinationsResponse(
        total: json["total"],
        destinos: List<Destino>.from(json["destinos"].map((x) => Destino.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "destinos": List<dynamic>.from(destinos.map((x) => x.toMap())),
    };
}


