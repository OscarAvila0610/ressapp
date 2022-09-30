import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/models/user.dart';
import 'package:ress_app/providers/users_provider.dart';

class UsersDTS extends DataTableSource {
  final List<Usuario> users;
  final BuildContext context;

  UsersDTS(this.users, this.context);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(user.rol)),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.correo)),
      DataCell(Text(user.exportador.nombre)),
      DataCell(IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: Colors.red.withOpacity(0.9),
        ),
        onPressed: () {
          final dialog = AlertDialog(
            backgroundColor: const Color(0xff092044),
            title: const Text(
              'Esta segudo que desea desactivar el usuario?',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Desactivar definitivamente a ${user.nombre} ?',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Si, desactivar',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () async {
                  await Provider.of<UsersProvider>(context, listen: false)
                      .deleteUser(user.uid);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

          showDialog(context: context, builder: (_) => dialog);
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
