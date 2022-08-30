import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/commodities_provider.dart';

import 'package:ress_app/models/commodity.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class CommodityModal extends StatefulWidget {
  const CommodityModal({Key? key, this.tipo}) : super(key: key);

  final Tipo? tipo;

  @override
  State<CommodityModal> createState() => _CommodityModalState();
}

class _CommodityModalState extends State<CommodityModal> {
  String prefijo = '';
  String nombre = '';
  bool dg = false;
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.tipo?.id;
    prefijo = widget.tipo?.prefijo ?? '';
    nombre = widget.tipo?.nombre ?? '';
    dg = widget.tipo?.peligroso ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final commodityProvider =
        Provider.of<CommoditiesProviders>(context, listen: false);
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
                widget.tipo?.nombre ?? 'Nuevo Tipo de Carga',
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
            initialValue: widget.tipo?.prefijo ?? '',
            onChanged: (value) => prefijo = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Prefijo Tipo de Carga',
                label: 'Prefijo',
                icon: Icons.production_quantity_limits_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: widget.tipo?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre Tipo de Carga',
                label: 'Tipo de Carga',
                icon: Icons.production_quantity_limits_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          CheckboxListTile(
              activeColor: Colors.indigo,
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.platform,
              title: const Text(
                'Mercancia Peligrosa',
                style: TextStyle(color: Colors.white),
              ),
              value: dg,
              onChanged: (value) {
                setState(() {
                  dg = value!;
                });
              }),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    await commodityProvider.newCommodity(prefijo, nombre, dg);
                    NotificationsService.showSnackbar('$nombre creado');
                  } else {
                    await commodityProvider.updateCommodity(
                        id!, prefijo, nombre);
                    NotificationsService.showSnackbar('$nombre actualizado');
                  }
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar el tipo de Carga');
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
