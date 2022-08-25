import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/http/bookings_response.dart';
import 'package:ress_app/models/user.dart';

class BookingsProvider extends ChangeNotifier {
  List<Reserva> reservas = [];

  getBookings(Usuario user) async {
    if (user.rol != 'USER_ROLE') {
      final resp = await RessApi.httpGet('/reservas');
      final bookingsResp = BookingsResponse.fromMap(resp);
      reservas = [...bookingsResp.reservas];
    } else {
      final resp = await RessApi.httpGet('/reservas/${user.uid}');
      final bookingsResp = BookingsResponse.fromMap(resp);

      reservas = [...bookingsResp.reservas];
    }

    notifyListeners();
  }

  Future newBooking(
      String airline,
      int awb,
      String commodity,
      String origin,
      String dest,
      String cont,
      int alt,
      int anch,
      int lar,
      int fis,
      int vol,
      String date,
      String descrip) async {
    final data = {
      "aerolinea": airline,
      "awb": awb,
      "tipoCarga": commodity,
      "origen": origin,
      "destino": dest,
      "contenedor": cont,
      "alto": alt,
      "ancho": anch,
      "largo": lar,
      "pesoFisico": fis,
      "pesoVolumetrico": vol,
      "fecha": date,
      "descripcion": descrip
    };

    try {
      final json = await RessApi.post('/reservas', data);
      final newBooking = Reserva.fromMap(json);

      reservas.add(newBooking);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Reserva';
    }
  }
}
