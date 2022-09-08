import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/calculator_modal.dart';

import '../cards/white_card.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculatorFormProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              'Calculadora de Cargos',
              style: CustomLabels.h1,
            ),
            const SizedBox(
              height: 10,
            ),
            WhiteCard(
                title: 'Ingrese datos de la Reserva',
                child: Form(
                  key: calculator.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: calculator.pesoFisico,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: CustomInputs.formInputDecoration(
                            hint: 'Peso Fisico',
                            label: 'Físico',
                            icon: Icons.supervised_user_circle_outlined),
                        onChanged: (value) {
                          calculator.pesoFisico = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Es necesario el peso Fisico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: calculator.pesoVolumetrico,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: CustomInputs.formInputDecoration(
                            hint: 'Peso Volumetrico',
                            label: 'Volumetrico',
                            icon: Icons.mark_email_read_outlined),
                        onChanged: (value) {
                          calculator.pesoVolumetrico = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Es necesario el peso Fisico';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: calculator.tarifa,
                        decoration: CustomInputs.formInputDecoration(
                            hint: 'Tarifa Pactada',
                            label: 'Tarifa',
                            icon: Icons.mark_email_read_outlined),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        ],
                        onChanged: (value) {
                          calculator.tarifa = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Es necesaria la tarifa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 200,
                        child: DropdownButtonFormField(
                          decoration: CustomInputs.loginInputDecoration(
                              label: 'Tipo de embarque',
                              hint: '',
                              icon: Icons.airplanemode_active_outlined),
                          dropdownColor: Colors.white,
                          value: calculator.tipoEmbarque,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (value) {
                            calculator.tipoEmbarque = value.toString();
                          },
                          items: ['PP', 'CC']
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 110),
                        child: ElevatedButton(
                          onPressed: () {
                            final validForm = calculator.validateForm();
                            if (!validForm) return;
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) => CalculatorModal(
                                      pesoFisico: calculator.pesoFisico,
                                      pesoVolumetrico:
                                          calculator.pesoVolumetrico,
                                      tipoEmbarque: calculator.tipoEmbarque,
                                      tarifa: calculator.tarifa,
                                    ));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.save_outlined,
                                size: 20,
                              ),
                              Text(' Calcular')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
