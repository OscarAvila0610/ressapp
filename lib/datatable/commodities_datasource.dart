import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/commodities_provider.dart';

import 'package:ress_app/models/commodity.dart';

import 'package:ress_app/ui/modals/commodity_modal.dart';

class CommoditiesDTS extends DataTableSource {
  final List<Tipo> tipos;
  final BuildContext context;

  CommoditiesDTS(this.tipos, this.context);
  @override
  DataRow getRow(int index) {
    final tipo = tipos[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(tipo.prefijo)),
      DataCell(Text(tipo.nombre)),
      (tipo.peligroso) ? const DataCell(Text('Si')) : const DataCell(Text('No')),
      DataCell(Text(tipo.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => CommodityModal(tipo: tipo));
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
                title: const Text('Esta seguro de borrarlo?', style: TextStyle(color: Colors.white),),
                content: Text('Borrar definitivamente ${tipo.nombre} ?', style: const TextStyle(color: Colors.white),),
                actions: [
                  TextButton(
                    child: const Text('No', style: TextStyle(color: Colors.red),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Si, borrar', style: TextStyle(color: Colors.green),),
                    onPressed: () async {
                      await Provider.of<CommoditiesProviders>(context,
                              listen: false)
                          .deleteTipoCarga(tipo.id);
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
  int get rowCount => tipos.length;

  @override
  int get selectedRowCount => 0;
}