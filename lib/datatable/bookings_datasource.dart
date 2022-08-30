import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/models/airline.dart';
import 'package:ress_app/models/commodity.dart';
import 'package:ress_app/models/container.dart';
import 'package:ress_app/models/destination.dart';
import 'package:ress_app/models/origin.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/providers/bookings_provider.dart';

import 'package:ress_app/ui/modals/booking_modal.dart';

class BookingsDTS extends DataTableSource {
  final List<Reserva> reservas;
  final BuildContext context;
  final List<Aerolinea> aerolineas;
  final List<Contenedore> contenedores;
  final List<Tipo> tipos;
  final List<Origene> origenes;
  final List<Destino> destinos;

  BookingsDTS(this.reservas, this.context, this.aerolineas, this.contenedores,
      this.tipos, this.origenes, this.destinos);
  @override
  DataRow getRow(int index) {
    final reserva = reservas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(reserva.aerolinea.prefijo.toString())),
      DataCell(Text(reserva.awb.toString())),
      DataCell(Text(reserva.origen.prefijo)),
      DataCell(Text(reserva.destino.prefijo)),
      DataCell(Text(reserva.usuario.nombre)),
      DataCell((reserva.aprobacion == true) 
                ? const Text('Aprobada', style: TextStyle(color: Colors.green),) 
                : (reserva.cancelada == true) 
                ? const Text('Cancelada', style: TextStyle(color: Colors.red),) 
                : const Text('Pendiente')),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => BookingModal(
                        reserva: reserva,
                        aerolineas: aerolineas,
                        contenedores: contenedores,
                        tipos: tipos,
                        origenes: origenes,
                        destinos: destinos,
                      ));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.green.withOpacity(0.9),
            ),
            onPressed: () {
              final dialog = AlertDialog(
                backgroundColor: const Color(0xff092044),
                title: const Text(
                  'Desea Aprobar la Reserva?',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'AWB ${reserva.awb} ?',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    child:  const Text(
                      'No',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Si',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () async {
                      await Provider.of<BookingsProvider>(context,
                              listen: false)
                          .approveBooking(reserva.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );

              showDialog(context: context, builder: (_) => dialog);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.withOpacity(0.9),
            ),
            onPressed: () {
              final dialog = AlertDialog(
                backgroundColor: const Color(0xff092044),
                title: const Text(
                  'Desea Cancelar la Reserva?',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'AWB ${reserva.awb} ?',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    child:  const Text(
                      'No',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Si',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () async {
                      await Provider.of<BookingsProvider>(context,
                              listen: false)
                          .cancelBooking(reserva.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );

              showDialog(context: context, builder: (_) => dialog);
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => reservas.length;

  @override
  int get selectedRowCount => 0;
}
