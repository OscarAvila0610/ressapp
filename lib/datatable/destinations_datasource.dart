import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/destinations_provider.dart';

import 'package:ress_app/models/destination.dart';

import 'package:ress_app/ui/modals/destination_modal.dart';

class DestinationsDTS extends DataTableSource {
  final List<Destino> destinos;
  final BuildContext context;

  DestinationsDTS(this.destinos, this.context);
  @override
  DataRow getRow(int index) {
    final destino = destinos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(destino.prefijo)),
      DataCell(Text(destino.pais)),
      DataCell(Text(destino.nombre)),
      DataCell(Text(destino.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => DestinationModal(destino: destino));
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
                content: Text('Borrar definitivamente $destino ?'),
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
                      await Provider.of<DestinationsProviders>(context,
                              listen: false)
                          .deleteDestination(destino.id);
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
  int get rowCount => destinos.length;

  @override
  int get selectedRowCount => 0;
}
