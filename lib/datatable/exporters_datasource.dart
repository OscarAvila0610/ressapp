import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/exporter_provider.dart';

import 'package:ress_app/models/exporter.dart';

import 'package:ress_app/ui/modals/exporter_modal.dart';

class ExportersDTS extends DataTableSource {
  final List<Exportadore> exportadores;
  final BuildContext context;

  ExportersDTS(this.exportadores, this.context);
  @override
  DataRow getRow(int index) {
    final exportador = exportadores[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(exportador.nombre)),
      DataCell(Text(exportador.direccion)),
      DataCell(Text(exportador.telefono.toString())),
      DataCell(Text(exportador.codigoIata.toString())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => ExporterModal(exportador: exportador));
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
                content: Text('Borrar definitivamente ${exportador.nombre} ?'),
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
                      await Provider.of<ExportersProviders>(context,
                              listen: false)
                          .deleteExporter(exportador.id);
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
  int get rowCount => exportadores.length;

  @override
  int get selectedRowCount => 0;
}