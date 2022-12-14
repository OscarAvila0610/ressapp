import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/commodities_provider.dart';

import 'package:ress_app/datatable/commodities_datasource.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/commodity_modal.dart';

class CommoditiesView extends StatefulWidget {
  const CommoditiesView({Key? key}) : super(key: key);

  @override
  State<CommoditiesView> createState() => _CommoditiesViewState();
}

class _CommoditiesViewState extends State<CommoditiesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<CommoditiesProviders>(context, listen: false).getCommodities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tipos = Provider.of<CommoditiesProviders>(context).tipoCargas;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns:  [
                DataColumn(label: Text('Prefijo', style: CustomLabels.h2,)),
                DataColumn(label: Text('Nombre', style: CustomLabels.h2,)),
                DataColumn(label: Text('DG', style: CustomLabels.h2,)),
                DataColumn(label: Text('Creado por', style: CustomLabels.h2,)),
                DataColumn(label: Text('Acciones', style: CustomLabels.h2,)),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: CommoditiesDTS(tipos, context),
              header:  Text(
                'TIPOS DE CARGA: ',
                maxLines: 2,
                style: CustomLabels.h1,
              ),
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const CommodityModal(tipo: null));
                  },
                  text: 'Crear',
                  icon: Icons.add_outlined,
                )
              ],
            ),
          ],
        ));
  }
}
