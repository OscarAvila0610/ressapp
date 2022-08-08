import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/destinations_provider.dart';

import 'package:ress_app/models/destination.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class DestinationModal extends StatefulWidget {
  const DestinationModal({Key? key, this.destino}) : super(key: key);

  final Destino? destino;

  @override
  State<DestinationModal> createState() => _DestinationModalState();
}

class _DestinationModalState extends State<DestinationModal> {
  String prefijo = '';
  String nombre = '';
  String pais = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.destino?.id;
    prefijo = widget.destino?.prefijo ?? '';
    nombre = widget.destino?.nombre ?? '';
    pais = widget.destino?.pais ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final destinationProvider =
        Provider.of<DestinationsProviders>(context, listen: false);
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
                widget.destino?.nombre ?? 'Nuevo Destino',
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
            initialValue: widget.destino?.prefijo ?? '',
            onChanged: (value) => prefijo = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Prefijo del destino',
                label: 'Prefijo',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.destino?.pais ?? '',
            onChanged: (value) => pais = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'País del destino',
                label: 'País',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.destino?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre del destino',
                label: 'Nombre',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    await destinationProvider.newDestination(
                        prefijo, pais, nombre);
                    NotificationsService.showSnackbar('$nombre creado');
                  } else {
                    await destinationProvider.updateDestination(
                        id!, prefijo, pais, nombre);
                    NotificationsService.showSnackbar('$nombre actualizado');
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar el destino');
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
