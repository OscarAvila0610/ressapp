import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/exporter_provider.dart';

import 'package:ress_app/models/exporter.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class ExporterModal extends StatefulWidget {
  const ExporterModal({Key? key, this.exportador}) : super(key: key);

  final Exportadore? exportador;

  @override
  State<ExporterModal> createState() => _ExporterModalState();
}

class _ExporterModalState extends State<ExporterModal> {
  String nombre = '';
  String direccion = '';
  int telefono = 0;
  int codigoIata = 0;

  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.exportador?.id;
    nombre = widget.exportador?.nombre ?? '';
    direccion = widget.exportador?.direccion ?? '';
    telefono = widget.exportador?.telefono ?? 0;
    codigoIata = widget.exportador?.codigoIata ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final exporterProvider =
        Provider.of<ExportersProviders>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, //Expanded
      decoration: buildBoxDecoration(),
      child: Form(
        key: exporterProvider.formKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exportador?.nombre ?? 'Nuevo Exportador',
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
              height: 10,
            ),
            TextFormField(
              initialValue: widget.exportador?.nombre ?? '',
              onChanged: (value) => nombre = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre del Exportador',
                  label: 'Nombre',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: widget.exportador?.direccion ?? '',
              onChanged: (value) => direccion = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La direcci??n es obligatoria';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Direcci??n del Exportador',
                  label: 'Direcci??n',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: widget.exportador?.telefono.toString() ?? '',
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              onChanged: (value) {
                if (value.isEmpty) {
                  value = '0';
                }
                telefono = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El tel??fono es obligatorio';
                }
                if (value.length < 8) {
                  return 'Debe ingresar los 8 d??gitos';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Tel??fono del Exportador',
                  label: 'Tel??fono',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: widget.exportador?.codigoIata.toString() ?? '',
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              onChanged: (value) {
                if (value.isEmpty) {
                  value = '0';
                }
                codigoIata = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El tel??fono es obligatorio';
                }
                if (value.length < 11) {
                  return 'Debe ingresar los 11 d??gitos';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'C??digo IATA',
                  label: 'IATA',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 17),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                onPressed: () async {
                  if (exporterProvider.validForm()) {
                    try {
                      if (id == null) {
                        await exporterProvider.newExporter(
                            nombre, direccion, telefono, codigoIata);
                        NotificationsService.showSnackbar('$nombre creado');
                      } else {
                        await exporterProvider.updateExporter(
                            id!, nombre, direccion, telefono, codigoIata);
                        NotificationsService.showSnackbar(
                            '$nombre actualizado');
                      }
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();
                      NotificationsService.showSnackbarError(
                          'No se pudo guardar el exportador');
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
