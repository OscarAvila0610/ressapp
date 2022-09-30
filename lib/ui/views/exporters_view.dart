import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/exporter_provider.dart';

import 'package:ress_app/datatable/exporters_datasource.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/modals/exporter_modal.dart';

class ExportersView extends StatefulWidget {
  const ExportersView({Key? key}) : super(key: key);

  @override
  State<ExportersView> createState() => _ExportersViewState();
}

class _ExportersViewState extends State<ExportersView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<ExportersProviders>(context, listen: false).getExporters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exportadores = Provider.of<ExportersProviders>(context).exportadores;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Dirección')),
                DataColumn(label: Text('Teléfono')),
                DataColumn(label: Text('Código IATA')),
                DataColumn(label: Text('Acciones')),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: ExportersDTS(exportadores, context),
              header: const Text(
                'Exportadores disponibles: ',
                maxLines: 2,
              ),
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const ExporterModal(exportador: null));
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
