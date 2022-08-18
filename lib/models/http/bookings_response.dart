import 'dart:convert';

import 'package:ress_app/models/booking.dart';

class BookingsResponse {
    BookingsResponse({
        required this.total,
        required this.reservas,
    });

    int total;
    List<Reserva> reservas;

    factory BookingsResponse.fromJson(String str) => BookingsResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BookingsResponse.fromMap(Map<String, dynamic> json) => BookingsResponse(
        total: json["total"],
        reservas: List<Reserva>.from(json["reservas"].map((x) => Reserva.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "reservas": List<dynamic>.from(reservas.map((x) => x.toMap())),
    };
}


