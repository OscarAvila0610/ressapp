import 'package:flutter/material.dart';
import 'package:ress_app/api/ress_api.dart';
import 'package:ress_app/models/user.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  late GlobalKey<FormState> formKey;

  // void updateListeners() {
  //   notifyListeners();
  // }

  copyUserWith({
    String? nombre,
    String? correo,
    String? rol,
    bool? estado,
    Exportador? exportador,
    String? uid,
    String? img,
  }) {
    user = Usuario(
      nombre: nombre ?? user!.nombre,
      correo: correo ?? user!.correo,
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      exportador: exportador ?? user!.exportador,
      uid: uid ?? user!.uid,
      img: img ?? user!.img,
    );

    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser(String oldPass, String newPass) async {
    if (!_validForm()) {
      return false;
    }

    final data = {
      'nombre': user!.nombre,
      'correo': user!.correo,
      'oldPassword': oldPass,
      'newPassword': newPass,
      'rol': user!.rol
    };

    try {
      final resp = await RessApi.put('/usuarios/${user!.uid}', data);
      // print(resp);
      return true;
    } catch (e) {
      print('error al actualizar Usuario $e');
      return false;
    }
  }
}
