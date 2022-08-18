import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/models/booking.dart';

import 'package:ress_app/ui/modals/booking_modal.dart';

class BookingsDTS extends DataTableSource {
  final List<Reserva> reservas;
  final BuildContext context;

  BookingsDTS(this.reservas, this.context);
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
                  builder: (_) => BookingModal(reserva: reserva));
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
