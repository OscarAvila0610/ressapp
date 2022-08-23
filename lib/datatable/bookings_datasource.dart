import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/models/airline.dart';
import 'package:ress_app/models/commodity.dart';
import 'package:ress_app/models/container.dart';
import 'package:ress_app/models/destination.dart';
import 'package:ress_app/models/origin.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/models/booking.dart';

import 'package:ress_app/ui/modals/booking_modal.dart';

class BookingsDTS extends DataTableSource {
  final List<Reserva> reservas;
  final BuildContext context;
  final List<Aerolinea> aerolineas;
  final List<Contenedore> contenedores;
  final List<Tipo> tipos;
  final List<Origene> origenes;
  final List<Destino> destinos;

  BookingsDTS(this.reservas, this.context, this.aerolineas, this.contenedores, this.tipos, this.origenes, this.destinos);
  @override
  DataRow getRow(int index) {
    final reserva = reservas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(reserva.aerolinea.prefijo.toString())),
      DataCell(Text(reserva.awb.toString())),
      DataCell(Text(reserva.origen.prefijo)),
      DataCell(Text(reserva.destino.prefijo)),
      DataCell(Text(reserva.usuario.nombre)),
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
              Icons.delete_outline,
              color: Colors.red.withOpacity(0.9),
            ),
            onPressed: () {
              final dialog = AlertDialog(
                title: const Text('Esta seguro de borrarlo?'),
                content: Text('Borrar definitivamente ${reserva.awb} ?'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Si, borrar'),
                    onPressed: () async {
                      await Provider.of<AirlinesProvider>(context,
                              listen: false)
                          .deleteAirline(reserva.id);
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
