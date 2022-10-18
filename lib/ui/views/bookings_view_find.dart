import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/datatable/bookings_datasource.dart';
import 'package:ress_app/models/user.dart';

import 'package:ress_app/providers/providers.dart';

import 'package:ress_app/ui/buttons/custom_icon_button.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';
import 'package:ress_app/ui/modals/booking_modal.dart';
import 'package:ress_app/ui/shared/widgets/search_text.dart';

class BookingsViewFind extends StatefulWidget {
  const BookingsViewFind({Key? key, required this.awb, required this.user})
      : super(key: key);
  final String awb;
  final Usuario user;

  @override
  State<BookingsViewFind> createState() => _BookingsViewFindState();
}

class _BookingsViewFindState extends State<BookingsViewFind> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    Provider.of<BookingsProvider>(context, listen: false)
        .getBookingByAwb(widget.awb);
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
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: const SearchText(),
              ),
            PaginatedDataTable(
              sortAscending: bookingsProvider.ascending,
              sortColumnIndex: bookingsProvider.sortColumnIndex,
              columnSpacing: 30,
              columns: [
                DataColumn(
                    label: Text(
                  'Aerolínea',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                      'Salida',
                      style: CustomLabels.h2,
                    ),
                    onSort: (colIndex, _) {
                      bookingsProvider.sortColumnIndex = colIndex;
                      bookingsProvider.sort<String>((reserva) =>
                          DateFormat('yyyy-MM-dd').format(reserva.fechaSalida));
                    }),
                DataColumn(
                    label: Text(
                  'AWB',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'Destino',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                      'Exportador',
                      style: CustomLabels.h2,
                    ),
                    onSort: (colIndex, _) {
                      bookingsProvider.sortColumnIndex = colIndex;
                      bookingsProvider
                          .sort<String>((reserva) => reserva.exportador.nombre);
                    }),
                DataColumn(
                    label: Text(
                      'Creada Por',
                      style: CustomLabels.h2,
                    ),
                    onSort: (colIndex, _) {
                      bookingsProvider.sortColumnIndex = colIndex;
                      bookingsProvider
                          .sort<String>((reserva) => reserva.usuario.nombre);
                    }),
                DataColumn(
                    label: Text(
                  'Estado',
                  style: CustomLabels.h2,
                )),
                DataColumn(
                    label: Text(
                  'Acciones',
                  style: CustomLabels.h2,
                )),
              ],
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              source: BookingsDTS(reservas, context, aerolineas, contenedores,
                  tipos, origenes, destinos, widget.user),
              header: Text(
                'RESERVAS: ',
                maxLines: 2,
                style: CustomLabels.h1,
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
