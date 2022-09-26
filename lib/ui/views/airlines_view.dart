import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/datatable/airlines_datasource.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/modals/airline_modal.dart';

class AirlinesView extends StatefulWidget {
  const AirlinesView({Key? key}) : super(key: key);

  @override
  State<AirlinesView> createState() => _AirlinesViewState();
}

class _AirlinesViewState extends State<AirlinesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<AirlinesProvider>(context, listen: false).getAirlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final aerolineas = Provider.of<AirlinesProvider>(context).aerolineas;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('Prefijo')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Estación')),
                DataColumn(label: Text('Creado por')),
                DataColumn(label: Text('Acciones')),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: AirlinesDTS(aerolineas, context),
              header: const Text(
                'Aerolíneas disponibles: ',
                maxLines: 2,
              ),
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const AirlineModal(aerolinea: null));
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
