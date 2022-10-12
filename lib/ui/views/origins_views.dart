import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/origins_provider.dart';

import 'package:ress_app/datatable/origins_datasource.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/origin_modal.dart';

class OriginsView extends StatefulWidget {
  const OriginsView({Key? key}) : super(key: key);

  @override
  State<OriginsView> createState() => _OriginsViewState();
}

class _OriginsViewState extends State<OriginsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<OriginsProviders>(context, listen: false).getOrigins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final origenes = Provider.of<OriginsProviders>(context).origenes;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              arrowHeadColor: Colors.white,
              columns: [
                DataColumn(
                    label: Text(
                  'Prefijo',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'País',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'Nombre',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'Creado por',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'Acciones',
                  style: CustomLabels.h2,
                )),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: OriginsDTS(origenes, context),
              header: Text(
                'ORÍGENES: ',
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
                        builder: (_) => const OriginModal(origen: null));
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
