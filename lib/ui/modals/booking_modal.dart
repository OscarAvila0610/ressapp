import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/models/booking.dart';

import 'package:ress_app/providers/bookings_provider.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class BookingModal extends StatefulWidget {
  const BookingModal({Key? key, this.reserva}) : super(key: key);

  final Reserva? reserva;

  @override
  State<BookingModal> createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  int awb = 0;
  String origen = '';
  String destino = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.reserva?.id;
    awb = widget.reserva?.awb ?? 0;
    origen = widget.reserva?.origen.prefijo ?? '';
    destino = widget.reserva?.destino.prefijo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider =
        Provider.of<BookingsProvider>(context, listen: false);
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
                widget.reserva?.awb.toString() ?? 'Nueva Reserva',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        initialValue: widget.reserva?.origen.prefijo ?? '',
                        onChanged: (value) => origen = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Aerolinea Seleccionada',
                            label: 'Aerolinea',
                            icon: Icons.airplanemode_active),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        initialValue: widget.reserva?.origen.prefijo ?? '',
                        onChanged: (value) => origen = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Numero de AWB',
                            label: 'AWB',
                            icon: Icons.format_list_numbered_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                  child: Row(
                children: [
                  Container(
                    width: 200,
                    child: TextFormField(
                      initialValue: widget.reserva?.origen.prefijo ?? '',
                      onChanged: (value) => origen = value,
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Origen de la Reserva',
                          label: 'Origen',
                          icon: Icons.flight_takeoff_outlined),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      initialValue: widget.reserva?.destino.prefijo ?? '',
                      onChanged: (value) => destino = value,
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Destino de la Reserva',
                          label: 'Destino',
                          icon: Icons.flag_outlined),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        initialValue: widget.reserva?.origen.prefijo ?? '',
                        onChanged: (value) => origen = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Largo de la Carga',
                            label: 'Largo',
                            icon: Icons.vertical_distribute_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        initialValue: widget.reserva?.destino.prefijo ?? '',
                        onChanged: (value) => destino = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ancho de la Carga',
                            label: 'Ancho',
                            icon: Icons.horizontal_distribute_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        initialValue: widget.reserva?.destino.prefijo ?? '',
                        onChanged: (value) => destino = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Alto de la Carga',
                            label: 'Alto',
                            icon: Icons.height_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        initialValue: widget.reserva?.origen.prefijo ?? '',
                        onChanged: (value) => origen = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Peso Fisico',
                            label: 'Fisico',
                            icon: Icons.monitor_weight_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        initialValue: widget.reserva?.destino.prefijo ?? '',
                        onChanged: (value) => destino = value,
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Peso Volumetrico',
                            label: 'Volumetrico',
                            icon: Icons.line_weight_outlined),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                child: TextFormField(
                  initialValue: widget.reserva?.origen.prefijo ?? '',
                  onChanged: (value) => origen = value,
                  decoration: CustomInputs.loginInputDecoration(
                      hint: 'Tipo de Carga',
                      label: 'Tipo',
                      icon: Icons.shopping_basket_outlined),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  initialValue: widget.reserva?.destino.prefijo ?? '',
                  onChanged: (value) => destino = value,
                  decoration: CustomInputs.loginInputDecoration(
                      hint: 'Contenedor de la Carga',
                      label: 'Contenedor',
                      icon: Icons.inventory_2_outlined),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  initialValue: widget.reserva?.destino.prefijo ?? '',
                  onChanged: (value) => destino = value,
                  decoration: CustomInputs.loginInputDecoration(
                      hint: 'Fecha de Salida',
                      label: 'Fecha',
                      icon: Icons.date_range_outlined),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: widget.reserva?.destino.prefijo ?? '',
            onChanged: (value) => destino = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Descripcion de la Reserva',
                label: 'Descripcion',
                icon: Icons.description_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                // try {
                //   if (id == null) {
                //     await airlineProvider.newAirline(
                //         prefijo, nombre, estacion);
                //     NotificationsService.showSnackbar('$nombre creado');
                //   } else {
                //     await airlineProvider.updateAirline(
                //         id!, prefijo, nombre, estacion);
                //     NotificationsService.showSnackbar('$nombre actualizado');
                //   }
                //   Navigator.of(context).pop();
                // } catch (e) {
                //   Navigator.of(context).pop();
                //   NotificationsService.showSnackbarError(
                //       'No se pudo guardar aerolinea');
                // }
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
