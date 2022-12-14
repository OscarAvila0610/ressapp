import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/http/bookings_response.dart';
import 'package:ress_app/models/user.dart';

class BookingsProvider extends ChangeNotifier {
  List<Reserva> reservas = [];
  List<Reserva> planVuelo = [];
  bool ascending = true;
  int? sortColumnIndex;
  int aprobadas = 0;
  int canceladas = 0;
  int pendientes = 0;

  getBookings(Usuario user) async {
    reservas = [];
    planVuelo = [];
    aprobadas = 0;
    canceladas = 0;
    pendientes = 0;
    if (user.rol != 'USER_ROLE') {
      final resp = await RessApi.httpGet('/reservas');
      final bookingsResp = BookingsResponse.fromMap(resp);
      reservas = [...bookingsResp.reservas];
    } else {
      final resp = await RessApi.httpGet('/reservas/${user.uid}');
      final bookingsResp = BookingsResponse.fromMap(resp);
      reservas = [...bookingsResp.reservas];
    }
    DateTime today = DateTime.now();
    for (var i = 0; i < reservas.length; i++) {
      (reservas[i].aprobacion)
          ? aprobadas = aprobadas + 1
          : (reservas[i].cancelada)
              ? canceladas = canceladas + 1
              : pendientes = pendientes + 1;
      if (DateFormat('yyyy-MM-dd').format(reservas[i].fechaSalida) ==
          DateFormat('yyyy-MM-dd').format(today)) {
        planVuelo.add(reservas[i]);
      }
    }
    notifyListeners();
  }

  getBookingByAwb(String awb) async {
    reservas = [];

    try {
      final resp = await RessApi.httpGet('/reservas/awb/$awb');
      final bookingsResp = BookingsResponse.fromMap(resp);
      reservas = [...bookingsResp.reservas];
    } catch (e) {
      throw 'Error en el Get por AWB';
    }

    notifyListeners();
  }

  getBookingByDate(String fechaInicial, String fechaFinal) async {
    reservas = [];
    final data = {"fecha_inicial": fechaInicial, "fecha_final": fechaFinal};

    try {
      final resp = await RessApi.post('/reservas/totalAwbsFecha', data);
      final bookingsResp = BookingsResponse.fromMap(resp);
      reservas = [...bookingsResp.reservas];
    } catch (e) {
      throw 'Error al obtener rango de fecha';
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
      String exp,
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
      "exportador": exp,
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

  Future updateBooking(
      String id,
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
      "descripcion": descrip,
      "aprobacion": false,
      "cancelada": false
    };

    try {
      await RessApi.put('/reservas/$id', data);

      reservas = reservas.map((reserva) {
        if (reserva.id != id) return reserva;
        reserva.aerolinea.id = airline;
        reserva.awb = awb;
        reserva.tipoCarga.id = commodity;
        reserva.origen.id = origin;
        reserva.destino.id = dest;
        reserva.contenedor.id = cont;
        reserva.alto = alt;
        reserva.ancho = anch;
        reserva.largo = lar;
        reserva.fechaSalida = DateTime.parse(date);
        reserva.pesoFisico = fis;
        reserva.pesoVolumetrico = vol;
        reserva.descripcion = descrip;
        reserva.cancelada = false;
        reserva.aprobacion = false;
        return reserva;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Reserva';
    }
  }

  Future approveBooking(String id) async {
    final data = {"aprobacion": true};
    try {
      await RessApi.put('/reservas/$id', data);

      reservas = reservas.map((reserva) {
        if (reserva.id != id) return reserva;
        reserva.aprobacion = true;
        return reserva;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al aprobar reserva';
    }
  }

  Future cancelBooking(String id) async {
    final data = {"cancelada": true};
    try {
      await RessApi.put('/reservas/$id', data);

      reservas = reservas.map((reserva) {
        if (reserva.id != id) return reserva;
        reserva.cancelada = true;
        return reserva;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al cancelar reserva';
    }
  }

  void sort<T>(Comparable<T> Function(Reserva reserva) getField) {
    reservas.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;
    notifyListeners();
  }
}
