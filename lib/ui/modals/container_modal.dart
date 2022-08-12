import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/containers_provider.dart';

import 'package:ress_app/models/container.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class ContainerModal extends StatefulWidget {
  const ContainerModal({Key? key, this.contenedor}) : super(key: key);

  final Contenedore? contenedor;

  @override
  State<ContainerModal> createState() => _ContainerModalState();
}

class _ContainerModalState extends State<ContainerModal> {
  String nombre = '';
  bool uld = false;
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.contenedor?.id;
    nombre = widget.contenedor?.nombre ?? '';
    uld = widget.contenedor?.uld ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final containerProvider =
        Provider.of<ContainersProviders>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, //Expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.contenedor?.nombre ?? 'Nuevo Contenedor',
                style: CustomLabels.h1.copyWith(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: widget.contenedor?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre del Contenedor',
                label: 'Nombre',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          FormField<bool>(
            builder: (_) {
              return CheckboxListTile(
                  activeColor: Colors.indigo,
                  checkColor: Colors.white,
                  
                  controlAffinity: ListTileControlAffinity.platform,
                  title: const Text(
                    'ULD',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: uld,
                  onChanged: (value) {
                    setState(() {
                      uld = value!;
                    });
                  });
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    await containerProvider.newContainer(nombre, uld);
                    NotificationsService.showSnackbar('$nombre creado');
                  } else {
                    await containerProvider.updateContainer(id!, nombre);
                    NotificationsService.showSnackbar('$nombre actualizado');
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar el contenedor');
                }
              },
              text: 'Guardar',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
