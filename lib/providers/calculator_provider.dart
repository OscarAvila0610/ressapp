import 'package:flutter/material.dart';

class CalculatorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String pesoFisico = '';
  String pesoVolumetrico = '';
  String tarifa = '';
  String tipoEmbarque = 'PP';

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
