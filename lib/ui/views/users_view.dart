import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/datatable/users_datasource.dart';
import 'package:ress_app/providers/exporter_provider.dart';
import 'package:ress_app/providers/roles_provider.dart';
import 'package:ress_app/providers/users_provider.dart';
import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

import 'package:ress_app/ui/modals/user_modal.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    Provider.of<ExportersProviders>(context, listen: false).getExporters();
    Provider.of<RolesProvider>(context, listen: false).getRoles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final usersDataSource = UsersDTS(usersProvider.users, context);
    final exportadores = Provider.of<ExportersProviders>(context).exportadores;
    final roles = Provider.of<RolesProvider>(context).roles;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            PaginatedDataTable(
              sortAscending: usersProvider.ascending,
              sortColumnIndex: usersProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label:  Text('Rol', style: CustomLabels.h2,),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort<String>((user) => user.rol);
                    }),
                DataColumn(
                    label:  Text('Nombre', style: CustomLabels.h2,),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort<String>((user) => user.nombre);
                    }),
                DataColumn(
                    label:  Text('Email', style: CustomLabels.h2,),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort<String>((user) => user.correo);
                    }),
                DataColumn(
                    label:  Text('Exportador', style: CustomLabels.h2,),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider
                          .sort<String>((user) => user.exportador.nombre);
                    }),
                 DataColumn(label: Text('Acciones', style: CustomLabels.h2,)),
              ],
              source: usersDataSource,
              onPageChanged: (page) {},
              header:  Text(
                'USUARIOS: ',
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
                        builder: (_) => UserModal(
                              exportadores: exportadores,
                              roles: roles,
                            ));
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
