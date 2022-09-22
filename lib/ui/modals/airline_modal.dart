import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/airlines_provider.dart';

import 'package:ress_app/models/airline.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class AirlineModal extends StatefulWidget {
  const AirlineModal({Key? key, this.aerolinea}) : super(key: key);

  final Aerolinea? aerolinea;

  @override
  State<AirlineModal> createState() => _AirlineModalState();
}

class _AirlineModalState extends State<AirlineModal> {
  int prefijo = 0;
  String nombre = '';
  String estacion = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.aerolinea?.id;
    prefijo = widget.aerolinea?.prefijo ?? 0;
    nombre = widget.aerolinea?.nombre ?? '';
    estacion = widget.aerolinea?.estacion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final airlineProvider =
        Provider.of<AirlinesProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, //Expanded
      decoration: buildBoxDecoration(),
      child: Form(
        key: airlineProvider.formKey,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.aerolinea?.nombre ?? 'Nueva Aerolínea',
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
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              initialValue: widget.aerolinea?.prefijo.toString() ?? '',
              onChanged: (value) {
                if (value.isEmpty) {
                  value = '0';
                }
                prefijo = int.parse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El prefijo es obligatorio';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Prefijo de la Aerolínea',
                  label: 'Prefijo',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.aerolinea?.nombre ?? '',
              onChanged: (value) => nombre = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresar país';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la Aerolínea',
                  label: 'Aerolínea',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.aerolinea?.estacion ?? '',
              onChanged: (value) => estacion = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La estacíon es obligatoria';
                }
                return null;
              },
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Nombre de la estación',
                  label: 'Estacíon',
                  icon: Icons.airplanemode_active),
              style: const TextStyle(color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                onPressed: () async {
                  if (airlineProvider.validForm()) {
                    try {
                      if (id == null) {
                        await airlineProvider.newAirline(
                            prefijo, nombre, estacion);
                        NotificationsService.showSnackbar('$nombre creado');
                      } else {
                        await airlineProvider.updateAirline(
                            id!, prefijo, nombre, estacion);
                        NotificationsService.showSnackbar(
                            '$nombre actualizado');
                      }
                      Navigator.of(context).pop();
                    } catch (e) {
                      Navigator.of(context).pop();
                      NotificationsService.showSnackbarError(
                          'No se pudo guardar aerolinea');
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
