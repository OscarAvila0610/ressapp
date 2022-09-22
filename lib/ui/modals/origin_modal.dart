import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/origins_provider.dart';

import 'package:ress_app/models/origin.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class OriginModal extends StatefulWidget {
  const OriginModal({Key? key, this.origen}) : super(key: key);

  final Origene? origen;

  @override
  State<OriginModal> createState() => _OriginModalState();
}

class _OriginModalState extends State<OriginModal> {
  String prefijo = '';
  String nombre = '';
  String pais = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.origen?.id;
    prefijo = widget.origen?.prefijo ?? '';
    nombre = widget.origen?.nombre ?? '';
    pais = widget.origen?.pais ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final originProvider =
        Provider.of<OriginsProviders>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, //Expanded
      decoration: buildBoxDecoration(),
      child: Form(
        key: originProvider.formKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.origen?.nombre ?? 'Nuevo Origen',
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
              initialValue: widget.origen?.prefijo ?? '',
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[A-Z]")),
                LengthLimitingTextInputFormatter(3),
              ],
              onChanged: (value) {
                if (value.isEmpty) {
                  value = '';
                }
                prefijo = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El prefijo es obligatorio Mayúscula';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Prefijo del origen Mayúscula',
                  label: 'Prefijo',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.origen?.pais ?? '',
              onChanged: (value) => pais = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El país es obligatorio';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'País del origen',
                  label: 'País',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.origen?.nombre ?? '',
              onChanged: (value) => nombre = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre del origen',
                  label: 'Nombre',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                onPressed: () async {
                  if (originProvider.validForm()) {
                    try {
                      if (id == null) {
                        await originProvider.newOrigin(prefijo, pais, nombre);
                        NotificationsService.showSnackbar('$nombre creado');
                      } else {
                        await originProvider.updateOrigin(
                            id!, prefijo, pais, nombre);
                        NotificationsService.showSnackbar(
                            '$nombre actualizado');
                      }
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();
                      NotificationsService.showSnackbarError(
                          'No se pudo guardar el origen');
                    }
                  }
                },
                text: 'Guardar',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
