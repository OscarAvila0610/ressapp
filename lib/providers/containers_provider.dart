import 'package:flutter/material.dart';

import 'package:ress_app/api/ress_api.dart';

import 'package:ress_app/models/container.dart';
import 'package:ress_app/models/http/containers_response.dart';


class ContainersProviders extends ChangeNotifier {
  List<Contenedore> contenedores = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getContainers() async {
    final resp = await RessApi.httpGet('/contenedores');
    final containersResp = ContainersResponse.fromMap(resp);

    contenedores = [...containersResp.contenedores];

    notifyListeners();
  }

  Future newContainer(String name, bool uld) async {
    
    final data = {'nombre': name, 'uld': uld};

    try {
      final json = await RessApi.post('/contenedores', data);
      final newContainer = Contenedore.fromMap(json);

      contenedores.add(newContainer);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear Contenedor';
    }
  }

  Future updateContainer(
      String id, String name) async {
    final data = {'nombre': name};

    try {
      await RessApi.put('/contenedores/$id', data);

      contenedores = contenedores.map((contenedor) {
        if (contenedor.id != id) return contenedor;
        contenedor.nombre = name;
        return contenedor;
      }).toList();

      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar Contenedor';
    }
  }

  Future deleteContainer(String id) async {
    try {
      await RessApi.delete('/contenedores/$id', {});

      contenedores.removeWhere((contenedor) => contenedor.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar contenedor';
    }
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }
}
