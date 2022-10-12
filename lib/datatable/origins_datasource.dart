import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/origins_provider.dart';

import 'package:ress_app/models/origin.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

import 'package:ress_app/ui/modals/origin_modal.dart';

class OriginsDTS extends DataTableSource {
  final List<Origene> origenes;
  final BuildContext context;

  OriginsDTS(this.origenes, this.context);
  @override
  DataRow getRow(int index) {
    final origen = origenes[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(
        origen.prefijo,
        style: CustomLabels.text,
      )),
      DataCell(Text(
        origen.pais,
        style: CustomLabels.text,
      )),
      DataCell(Text(
        origen.nombre,
        style: CustomLabels.text,
      )),
      DataCell(Text(
        origen.usuario.nombre,
        style: CustomLabels.text,
      )),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
            ),
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
                backgroundColor: const Color(0xff092044),
                title: const Text(
                  'Esta seguro de borrarlo?',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'Borrar definitivamente ${origen.nombre} ?',
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
