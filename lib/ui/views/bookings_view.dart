import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/datatable/bookings_datasource.dart';
import 'package:ress_app/models/user.dart';

import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/cards/white_card.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/modals/booking_modal.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({Key? key, required this.user}) : super(key: key);
  final Usuario user;

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<BookingsProvider>(context, listen: false)
        .getBookings(widget.user);
    Provider.of<AirlinesProvider>(context, listen: false).getAirlines();
    Provider.of<ContainersProviders>(context, listen: false).getContainers();
    Provider.of<CommoditiesProviders>(context, listen: false).getCommodities();
    Provider.of<OriginsProviders>(context, listen: false).getOrigins();
    Provider.of<DestinationsProviders>(context, listen: false)
        .getDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reservas = Provider.of<BookingsProvider>(context).reservas;
    final aerolineas = Provider.of<AirlinesProvider>(context).aerolineas;
    final contenedores = Provider.of<ContainersProviders>(context).contenedores;
    final tipos = Provider.of<CommoditiesProviders>(context).tipoCargas;
    final origenes = Provider.of<OriginsProviders>(context).origenes;
    final destinos = Provider.of<DestinationsProviders>(context).destinos;
    final bookingsProvider = Provider.of<BookingsProvider>(context);
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
            if (reservas.isEmpty)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(),
              )),
            if (reservas.isNotEmpty)
              PaginatedDataTable(
                sortAscending: bookingsProvider.ascending,
                sortColumnIndex: bookingsProvider.sortColumnIndex,
                columnSpacing: 30,
                columns: [
                  const DataColumn(label: Text('Aerolínea')),
                  DataColumn(
                      label: const Text('Salida'),
                      onSort: (colIndex, _) {
                        bookingsProvider.sortColumnIndex = colIndex;
                        bookingsProvider.sort<String>((reserva) =>
                            DateFormat('yyyy-MM-dd')
                                .format(reserva.fechaSalida));
                      }),
                  const DataColumn(label: Text('AWB')),
                  const DataColumn(label: Text('Destino')),
                  DataColumn(
                      label: const Text('Exportador'),
                      onSort: (colIndex, _) {
                        bookingsProvider.sortColumnIndex = colIndex;
                        bookingsProvider.sort<String>(
                            (reserva) => reserva.exportador.nombre);
                      }),
                  DataColumn(
                      label: const Text('Creada Por'),
                      onSort: (colIndex, _) {
                        bookingsProvider.sortColumnIndex = colIndex;
                        bookingsProvider
                            .sort<String>((reserva) => reserva.usuario.nombre);
                      }),
                  const DataColumn(label: Text('Estado')),
                  const DataColumn(label: Text('Acciones')),
                ],
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value ?? 10;
                  });
                },
                rowsPerPage: _rowsPerPage,
                source: BookingsDTS(reservas, context, aerolineas, contenedores,
                    tipos, origenes, destinos, widget.user),
                header: const Text(
                  'Reservas realizadas: ',
                  maxLines: 2,
                ),
                actions: [
                  if (widget.user.rol == 'USER_ROLE') ...[
                    CustomIconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => BookingModal(
                                  reserva: null,
                                  aerolineas: aerolineas,
                                  contenedores: contenedores,
                                  tipos: tipos,
                                  origenes: origenes,
                                  destinos: destinos,
                                ));
                      },
                      text: 'Crear',
                      icon: Icons.add_outlined,
                    )
                  ]
                ],
              ),
          ],
        ));
  }
}
