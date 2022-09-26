import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ress_app/models/airline.dart';
import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/commodity.dart';
import 'package:ress_app/models/container.dart';
import 'package:ress_app/models/destination.dart';
import 'package:ress_app/models/origin.dart';
import 'package:ress_app/models/user.dart';
import 'package:ress_app/providers/booking_form_provider.dart';
import 'package:ress_app/providers/bookings_provider.dart';
import 'package:ress_app/services/notifications_service.dart';
import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen(
      {Key? key,
      required this.aerolineas,
      required this.contenedores,
      required this.tipos,
      required this.origenes,
      required this.destinos,
      required this.reserva,
      required this.bookingFormProvider, required this.bookingsProvider, required this.user})
      : super(key: key);

  final List<Aerolinea> aerolineas;
  final List<Contenedore> contenedores;
  final List<Tipo> tipos;
  final List<Origene> origenes;
  final List<Destino> destinos;
  final BookingFormProvider bookingFormProvider;
  final BookingsProvider bookingsProvider;
  final Usuario user;

  final Reserva? reserva;

  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  int awb = 0;
  int alto = 0;
  int largo = 0;
  int ancho = 0;
  int pesoFisico = 0;
  int pesoVolumetrico = 0;
  String aerolinea = '';
  String contenedor = '';
  String tipo = '';
  String origen = '';
  String destino = '';
  String descripcion = '';
  String? id;
  DateTime fecha = DateTime.now();
  String date = '';

  @override
  void initState() {
    super.initState();
    aerolinea = widget.reserva?.aerolinea.id ?? '62cec0f7717a2552db8f99c6';
    contenedor = widget.reserva?.contenedor.id ?? '62cec510ad30a92c9c4bdc71';
    tipo = widget.reserva?.tipoCarga.id ?? '62ceb7f84d468c6ea3b0176c';
    id = widget.reserva?.id;
    awb = widget.reserva?.awb ?? 0;
    alto = widget.reserva?.alto ?? 0;
    largo = widget.reserva?.largo ?? 0;
    ancho = widget.reserva?.ancho ?? 0;
    pesoFisico = widget.reserva?.pesoFisico ?? 0;
    fecha = widget.reserva?.fechaSolicitud ?? DateTime.now();
    pesoVolumetrico = widget.reserva?.pesoVolumetrico ?? 0;
    origen = widget.reserva?.origen.id ?? '62f1052b1314231c0daaacb7';
    destino = widget.reserva?.destino.id ?? '62cdbb6208337546686bdd2f';
    descripcion = widget.reserva?.descripcion ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: CustomInputs.loginInputDecoration(
              label: 'Aerolínea',
              hint: '',
              icon: Icons.airplanemode_active_outlined),
          dropdownColor: const Color(0xff0F2039),
          value: aerolinea,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              aerolinea = value!;
            });
          },
          items: widget.aerolineas.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
                value: value.id, child: Text(value.prefijo.toString()));
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          initialValue: widget.reserva?.awb.toString() ?? '',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El numero de AWB es obligatorio';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            awb = int.parse(value);
            widget.bookingFormProvider.awb = awb;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Número de AWB',
              label: 'AWB',
              icon: Icons.format_list_numbered_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: CustomInputs.loginInputDecoration(
              label: 'Origen', hint: '', icon: Icons.flight_takeoff_outlined),
          dropdownColor: const Color(0xff0F2039),
          value: origen,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              origen = value!;
            });
          },
          items: widget.origenes.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
                value: value.id, child: Text(value.prefijo));
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: CustomInputs.loginInputDecoration(
              label: 'Destino', hint: '', icon: Icons.flag_outlined),
          dropdownColor: const Color(0xff0F2039),
          value: destino,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              destino = value!;
            });
          },
          items: widget.destinos.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
                value: value.id, child: Text(value.prefijo));
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El largo es obligatorio';
            }
            return null;
          },
          initialValue: widget.reserva?.largo.toString() ?? '',
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            largo = int.parse(value);
            widget.bookingFormProvider.largo = largo;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Largo de la Carga',
              label: 'Largo cm',
              icon: Icons.vertical_distribute_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El ancho es obligatorio';
            }
            return null;
          },
          initialValue: widget.reserva?.ancho.toString() ?? '',
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            ancho = int.parse(value);
            widget.bookingFormProvider.ancho = ancho;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Ancho de la Carga',
              label: 'Ancho cm',
              icon: Icons.horizontal_distribute_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El alto es obligatorio';
            }
            return null;
          },
          initialValue: widget.reserva?.alto.toString() ?? '',
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            alto = int.parse(value);
            widget.bookingFormProvider.alto = alto;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Alto de la Carga',
              label: 'Alto cm',
              icon: Icons.height_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Peso obligatorio';
            }
            return null;
          },
          initialValue: widget.reserva?.pesoFisico.toString() ?? '',
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            pesoFisico = int.parse(value);
            widget.bookingFormProvider.pesoFisico = pesoFisico;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Peso Físico',
              label: 'Físico kg',
              icon: Icons.monitor_weight_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Peso obligatorio';
            }
            return null;
          },
          initialValue: widget.reserva?.pesoVolumetrico.toString() ?? '',
          onChanged: (value) {
            if (value.isEmpty) {
              value = '0';
            }
            pesoVolumetrico = int.parse(value);
            widget.bookingFormProvider.pesoVolumetrico = pesoVolumetrico;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Peso Volumétrico',
              label: 'Volumétrico kg',
              icon: Icons.line_weight_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: CustomInputs.loginInputDecoration(
              label: 'Tipo de Carga',
              hint: '',
              icon: Icons.shopping_basket_outlined),
          dropdownColor: const Color(0xff0F2039),
          value: tipo,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              tipo = value!;
            });
          },
          items: widget.tipos.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
                value: value.id, child: Text(value.prefijo));
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: CustomInputs.loginInputDecoration(
              label: 'Contenedor', hint: '', icon: Icons.dashboard_outlined),
          dropdownColor: const Color(0xff0F2039),
          value: contenedor,
          style: const TextStyle(color: Colors.white),
          onChanged: (String? value) {
            setState(() {
              contenedor = value!;
            });
          },
          items: widget.contenedores.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
                value: value.id, child: Text(value.nombre));
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.datetime,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Fecha obligatoria';
            }
            return null;
          },
          initialValue: (widget.reserva == null)
              ? ''
              : DateFormat('yyyy-MM-dd').format(widget.reserva!.fechaSalida),
          onChanged: (value) {
            date = value;
            widget.bookingFormProvider.fecha = date;
          },
          decoration: CustomInputs.loginInputDecoration(
              hint: 'Fecha de Salida',
              label: 'Año-Mes-Día',
              icon: Icons.date_range_outlined),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
                    height: 10,
                  ),
        TextFormField(
                    initialValue: widget.reserva?.descripcion ?? '',
                    onChanged: (value) => descripcion = value,
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
                        try {
                          if (id == null) {
                            final validForm =
                                widget.bookingFormProvider.validateForm();
                            if (!validForm) return;
                            await widget.bookingsProvider.newBooking(
                                aerolinea,
                                awb,
                                tipo,
                                origen,
                                destino,
                                contenedor,
                                widget.user.exportador.id,
                                alto,
                                ancho,
                                largo,
                                pesoFisico,
                                pesoVolumetrico,
                                date,
                                descripcion);
                            NotificationsService.showSnackbar(
                                'Reserva AWB $awb creada');
                          } else {
                            await widget.bookingsProvider.updateBooking(
                                id!,
                                aerolinea,
                                awb,
                                tipo,
                                origen,
                                destino,
                                contenedor,
                                alto,
                                ancho,
                                largo,
                                pesoFisico,
                                pesoVolumetrico,
                                date,
                                descripcion);
                            NotificationsService.showSnackbar(
                                '$awb actualizado');
                          }
                          Navigator.of(context).pop();
                        } catch (e) {
                          Navigator.of(context).pop();
                          NotificationsService.showSnackbarError(
                              'No se pudo guardar reserva');
                        }
                      },
                      text: 'Guardar',
                      color: Colors.white,
                    ),
                  ),
      ],
    );
  }
}
