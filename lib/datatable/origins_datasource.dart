import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/origins_provider.dart';

import 'package:ress_app/models/origin.dart';

import 'package:ress_app/ui/modals/origin_modal.dart';

class OriginsDTS extends DataTableSource {
  final List<Origene> origenes;
  final BuildContext context;

  OriginsDTS(this.origenes, this.context);
  @override
  DataRow getRow(int index) {
    final origen = origenes[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(origen.prefijo)),
      DataCell(Text(origen.pais)),
      DataCell(Text(origen.nombre)),
      DataCell(Text(origen.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => OriginModal(origen: origen));
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
                content: Text('Borrar definitivamente $origen ?'),
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
                      await Provider.of<OriginsProviders>(context,
                              listen: false)
                          .deleteOrigin(origen.id);
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
  int get rowCount => origenes.length;

  @override
  int get selectedRowCount => 0;
}
