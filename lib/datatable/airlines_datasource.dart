import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/models/airline.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

import 'package:ress_app/ui/modals/airline_modal.dart';

class AirlinesDTS extends DataTableSource {
  final List<Aerolinea> aerolineas;
  final BuildContext context;

  AirlinesDTS(this.aerolineas, this.context);
  @override
  DataRow getRow(int index) {
    final aerolinea = aerolineas[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(aerolinea.prefijo.toString(), style: CustomLabels.text,)),
      DataCell(Text(aerolinea.nombre, style: CustomLabels.text,)),
      DataCell(Text(aerolinea.estacion, style: CustomLabels.text,)),
      DataCell(Text(aerolinea.usuario.nombre, style: CustomLabels.text,)),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => AirlineModal(aerolinea: aerolinea));
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
                  'Esta seguro de borrarlo?',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'Borrar definitivamente ${aerolinea.nombre} ?',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Si, borrar',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () async {
                      await Provider.of<AirlinesProvider>(context,
                              listen: false)
                          .deleteAirline(aerolinea.id);
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
  int get rowCount => aerolineas.length;

  @override
  int get selectedRowCount => 0;
}
