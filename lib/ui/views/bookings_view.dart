import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:ress_app/datatable/bookings_datasource.dart';
import 'package:ress_app/providers/bookings_provider.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/modals/booking_modal.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<BookingsProvider>(context, listen: false).getBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reservas = Provider.of<BookingsProvider>(context).reservas;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              'Reservas',
              style: CustomLabels.h1,
            ),
            const SizedBox(
              height: 10,
            ),
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('Aerolinea')),
                DataColumn(label: Text('AWB')),
                DataColumn(label: Text('Origen')),
                DataColumn(label: Text('Destino')),
                DataColumn(label: Text('Creado Por')),
                DataColumn(label: Text('Acciones')),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: BookingsDTS(reservas, context),
              header: const Text(
                'Aerolíneas disponibles: ',
                maxLines: 2,
              ),
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) => const BookingModal(reserva: null));
                  },
                  text: 'Crear',
                  icon: Icons.add_outlined,
                )
              ],
            ),
          ],
        ));
  }
}
