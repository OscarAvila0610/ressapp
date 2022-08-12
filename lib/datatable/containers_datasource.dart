import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/containers_provider.dart';

import 'package:ress_app/models/container.dart';

import 'package:ress_app/ui/modals/container_modal.dart';

class ContainersDTS extends DataTableSource {
  final List<Contenedore> contenedores;
  final BuildContext context;

  ContainersDTS(this.contenedores, this.context);
  @override
  DataRow getRow(int index) {
    final contenedor = contenedores[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(contenedor.nombre)),
      DataCell(Text(contenedor.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => ContainerModal(contenedor: contenedor));
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
                content: Text('Borrar definitivamente ${contenedor.nombre} ?'),
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
                      await Provider.of<ContainersProviders>(context,
                              listen: false)
                          .deleteContainer(contenedor.id);
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
  int get rowCount => contenedores.length;

  @override
  int get selectedRowCount => 0;
}
