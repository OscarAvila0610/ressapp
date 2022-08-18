import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/http/bookings_response.dart';

class BookingsProvider extends ChangeNotifier {
  List<Reserva> reservas = [];

  getBookings() async {
    final resp = await RessApi.httpGet('/reservas');
    final bookingsResp = BookingsResponse.fromMap(resp);

    reservas = [...bookingsResp.reservas];

    notifyListeners();
  }
}
