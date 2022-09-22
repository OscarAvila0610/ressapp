import 'package:flutter/material.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class CalculatorModal extends StatefulWidget {
  const CalculatorModal(
      {Key? key,
      required this.tarifa,
      required this.pesoFisico,
      required this.pesoVolumetrico,
      required this.tipoEmbarque})
      : super(key: key);

  final String tarifa;
  final String pesoFisico;
  final String pesoVolumetrico;
  final String tipoEmbarque;

  @override
  State<CalculatorModal> createState() => _CalculatorModalState();
}

class _CalculatorModalState extends State<CalculatorModal> {
  double terminal = 0;
  double ics = 12;
  double flete = 0;
  double vat = 0;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    terminal = double.parse(widget.pesoFisico) * 0.3399;
    flete = double.parse(widget.pesoVolumetrico) * double.parse(widget.tarifa);
    vat = (widget.tipoEmbarque == 'PP') ? (terminal + flete + ics) * 0.12 : 0;
    total = terminal + flete + ics + vat;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300, //Expanded
      decoration: buildBoxDecoration(),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cargos a incluir en AWB',
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
            enabled: false,
            initialValue: 'USD ${flete.toStringAsFixed(2)}',
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Flete', label: 'Flete', icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: 'USD ${terminal.toStringAsFixed(2)}',
            enabled: false,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Terminal',
                label: 'Terminal',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: 'USD ${ics.toString()}',
            enabled: false,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Transmision Electronica',
                label: 'Transmision',
                icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: 'USD ${vat.toStringAsFixed(2)}',
            enabled: false,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'IVA', label: 'IVA', icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: 'USD ${total.toStringAsFixed(2)}',
            enabled: false,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Total', label: 'Total', icon: Icons.airplanemode_active),
            style: const TextStyle(color: Colors.white),
          ),
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
