import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/airline.dart';
import 'package:ress_app/models/commodity.dart';
import 'package:ress_app/models/container.dart';
import 'package:ress_app/models/destination.dart';
import 'package:ress_app/models/origin.dart';
import 'package:ress_app/providers/booking_form_provider.dart';

import 'package:ress_app/providers/providers.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/booking/full_screen.dart';
import 'package:ress_app/ui/modals/booking/responsive_screen.dart';

class BookingModal extends StatefulWidget {
  const BookingModal(
      {Key? key,
      this.reserva,
      required this.aerolineas,
      required this.contenedores,
      required this.tipos,
      required this.origenes,
      required this.destinos})
      : super(key: key);

  final List<Aerolinea> aerolineas;
  final List<Contenedore> contenedores;
  final List<Tipo> tipos;
  final List<Origene> origenes;
  final List<Destino> destinos;

  final Reserva? reserva;

  @override
  State<BookingModal> createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider =
        Provider.of<BookingsProvider>(context, listen: false);
    final user = Provider.of<AuthProvider>(context).user;
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => BookingFormProvider(),
      child: Builder(builder: (context) {
        final bookingFormProvider = Provider.of<BookingFormProvider>(context);
        return Container(
          padding: const EdgeInsets.all(20),
          height: 600,
          width: 300, //Expanded
          decoration: buildBoxDecoration(),
          child: Form(
            key: bookingFormProvider.formKey,
            child: SingleChildScrollView(
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
                  if (size.width > 1124) ...[
                    FullScreenBookings(
                        aerolineas: widget.aerolineas,
                        contenedores: widget.contenedores,
                        tipos: widget.tipos,
                        origenes: widget.origenes,
                        destinos: widget.destinos,
                        reserva: widget.reserva,
                        bookingFormProvider: bookingFormProvider,
                        bookingsProvider: bookingsProvider,
                        user: user!)
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  if (size.width < 1124) ...[
                    ResponsiveScreen(
                      aerolineas: widget.aerolineas,
                      contenedores: widget.contenedores,
                      tipos: widget.tipos,
                      origenes: widget.origenes,
                      destinos: widget.destinos,
                      reserva: widget.reserva,
                      bookingFormProvider: bookingFormProvider,
                      bookingsProvider: bookingsProvider,
                      user: user!,
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
