import 'package:flutter/material.dart';

class BookingFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int awb = 0;
  int alto = 0;
  int largo = 0;
  int ancho = 0;
  int pesoFisico = 0;
  int pesoVolumetrico = 0;
  String fecha = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
