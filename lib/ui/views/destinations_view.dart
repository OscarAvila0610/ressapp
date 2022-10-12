import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/destinations_provider.dart';

import 'package:ress_app/datatable/destinations_datasource.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/destination_modal.dart';

class DestinationsView extends StatefulWidget {
  const DestinationsView({Key? key}) : super(key: key);

  @override
  State<DestinationsView> createState() => _DestinationsViewState();
}

class _DestinationsViewState extends State<DestinationsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<DestinationsProviders>(context, listen: false)
        .getDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final destinos = Provider.of<DestinationsProviders>(context).destinos;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns:  [
                DataColumn(label: Text('Prefijo', style: CustomLabels.h2,)),
                DataColumn(label: Text('Pais', style: CustomLabels.h2,)),
                DataColumn(label: Text('Nombre', style: CustomLabels.h2,)),
                DataColumn(label: Text('Creado por', style: CustomLabels.h2,)),
                DataColumn(label: Text('Acciones', style: CustomLabels.h2,)),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: DestinationsDTS(destinos, context),
              header:  Text(
                'DESTINOS: ',
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
                        builder: (_) => const DestinationModal(destino: null));
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
