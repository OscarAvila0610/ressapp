import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/datatable/users_datasource.dart';
import 'package:ress_app/providers/users_provider.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final usersDataSource = UsersDTS(usersProvider.users);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              'Usuarios Disponibles',
              style: CustomLabels.h1,
            ),
            const SizedBox(
              height: 10,
            ),
            PaginatedDataTable(
              sortAscending: usersProvider.ascending,
              sortColumnIndex: usersProvider.sortColumnIndex,
              columns: [
                const DataColumn(label: Text('Avatar')),
                DataColumn(
                    label: const Text('Nombre'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort<String>((user) => user.nombre);
                    }),
                DataColumn(
                    label: const Text('Email'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider.sort<String>((user) => user.correo);
                    }),
                DataColumn(
                    label: const Text('Exportador'),
                    onSort: (colIndex, _) {
                      usersProvider.sortColumnIndex = colIndex;
                      usersProvider
                          .sort<String>((user) => user.exportador.nombre);
                    }),
                const DataColumn(label: Text('Acciones')),
              ],
              source: usersDataSource,
              onPageChanged: (page) {},
            ),
          ],
        ));
  }
}
