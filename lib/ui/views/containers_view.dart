import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/containers_provider.dart';

import 'package:ress_app/datatable/containers_datasource.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/container_modal.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  State<ContainersView> createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<ContainersProviders>(context, listen: false).getContainers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contenedores = Provider.of<ContainersProviders>(context).contenedores;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              columns:  [
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
              source: ContainersDTS(contenedores, context),
              header:  Text(
                'CONTENEDORES: ',
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
                        builder: (_) => const ContainerModal(contenedor: null));
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
