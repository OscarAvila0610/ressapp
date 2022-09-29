import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/excel/mobile.dart'
    if (dart.library.html) 'package:ress_app/excel/web.dart';
import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/user.dart';
import 'package:ress_app/services/notifications_service.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;

import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/cards/white_card.dart';
import 'package:ress_app/ui/charts/bar_chart.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key, required this.user}) : super(key: key);
  final Usuario user;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String fechaInicial = '';
  String fechaFinal = '';
  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getKgsByExporter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kgs = Provider.of<AdminProvider>(context);
    return ListView(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WhiteCard(
              title: 'Total Kgs por Exportador',
              child: KgsBarChart(
                totalesKgs: kgs.listaFinal,
                registros: kgs.kgsExporter,
              )),
          WhiteCard(
            child: Form(
              key: kgs.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fecha Inicio obligatoria';
                        }
                        return null;
                      },
                      initialValue: '',
                      onChanged: (value) {
                        fechaInicial = value;
                      },
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Año-Mes-Día',
                          label: 'Fecha de Inicio',
                          icon: Icons.date_range_outlined),
                      style: const TextStyle(color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fecha Final obligatoria';
                        }
                        return null;
                      },
                      initialValue: fechaFinal,
                      onChanged: (value) {
                        fechaFinal = value;
                      },
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Año-Mes-Día',
                          label: 'Fecha de Fin',
                          icon: Icons.date_range_outlined),
                      style: const TextStyle(color: Colors.indigo),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: ElevatedButton(
                      onPressed: () async {
                        final iniVal = DateTime.parse(fechaInicial);
                        final endVal = DateTime.parse(fechaFinal);
                        if (iniVal.isAfter(endVal)) {
                          NotificationsService.showSnackbarError(
                              'La fecha inicial no puede ser mayor a la fecha final');
                        }
                        if (kgs.validForm()) {
                          await Provider.of<BookingsProvider>(context,
                                  listen: false)
                              .getBookingByDate(fechaInicial, fechaFinal);
                          final reservas = Provider.of<BookingsProvider>(
                                  context,
                                  listen: false)
                              .reservas;
                          if (reservas.isNotEmpty) {
                            generarLista(reservas);
                          } else {
                            NotificationsService.showSnackbarError(
                                'No se encontraron datos de Reserva en las fechas estipuladas');
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                          ),
                          Text(' Generar lista de AWBs')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Future<void> generarLista(List<Reserva> reservas) async {
    int total = 1;
    final xls.Workbook lista = xls.Workbook();
    final xls.Worksheet awbs = lista.worksheets[0];
    awbs.showGridlines = false;
    awbs.enableSheetCalculations();

    awbs.getRangeByName('A1').setText('Aerolínea');
    awbs.getRangeByName('B1').setText('AWB');
    awbs.getRangeByName('C1').setText('Fecha Salida');
    awbs.getRangeByName('D1').setText('Destino');
    awbs.getRangeByName('E1').setText('Peso Físico');
    awbs.getRangeByName('F1').setText('Peso Volumétrico');
    awbs.getRangeByName('G1').setText('Tipo de Carga');
    awbs.getRangeByName('H1').setText('Exportador');
    awbs.getRangeByName('I1').setText('Estado');
    awbs.getRangeByName('J1').setText('Fecha Solicitud');
    awbs.getRangeByName('K1').setText('Fecha Resolución');
    awbs.getRangeByName('L1').setText('Trabajado Por');
    awbs.getRangeByName('A1:L1').columnWidth = 20;
    awbs.getRangeByName('A1:L1').cellStyle.bold = true;
    awbs.getRangeByName('A1:L1').cellStyle.hAlign = xls.HAlignType.center;
    awbs.getRangeByName('A1:L1').cellStyle.backColor = '#000000';
    awbs.getRangeByName('A1:L1').cellStyle.fontColor = '#FFFFFF';
    awbs.getRangeByName('A1:L1').cellStyle.fontSize = 12;

    for (var i = 0; i < reservas.length; i++) {
      awbs
          .getRangeByName('A${i + 2}')
          .setText(reservas[i].aerolinea.prefijo.toString());
      awbs.getRangeByName('B${i + 2}').setText(reservas[i].awb.toString());
      awbs.getRangeByName('C${i + 2}').setText(
          '${reservas[i].fechaSalida.year}/${reservas[i].fechaSalida.month}/${reservas[i].fechaSalida.day}');
      awbs.getRangeByName('D${i + 2}').setText(reservas[i].destino.prefijo);
      awbs
          .getRangeByName('E${i + 2}')
          .setNumber(double.parse(reservas[i].pesoFisico.toString()));
      awbs
          .getRangeByName('F${i + 2}')
          .setNumber(double.parse(reservas[i].pesoVolumetrico.toString()));
      awbs.getRangeByName('G${i + 2}').setText(reservas[i].tipoCarga.nombre);
      awbs.getRangeByName('H${i + 2}').setText(reservas[i].exportador.nombre);
      awbs.getRangeByName('I${i + 2}').setText((reservas[i].aprobacion)
          ? 'Aprobada'
          : (reservas[i].cancelada)
              ? 'Cancelada'
              : 'Pendiente');
      awbs.getRangeByName('J${i + 2}').setText(
          '${reservas[i].fechaSolicitud.year}/${reservas[i].fechaSolicitud.month}/${reservas[i].fechaSolicitud.day}');
      awbs.getRangeByName('K${i + 2}').setText((reservas[i].aprobacion ||
              reservas[i].cancelada)
          ? '${reservas[i].fechaRes.year}/${reservas[i].fechaRes.month}/${reservas[i].fechaRes.day}'
          : 'Pendiente');
      awbs.getRangeByName('L${i + 2}').setText(reservas[i].actualizado.nombre);
      total++;
    }
    awbs.getRangeByName('A${total + 1}').setText('Total Registros');
    awbs
        .getRangeByName('B${total + 1}')
        .setNumber(double.parse(reservas.length.toString()));
    awbs.getRangeByName('E${total + 1}').setFormula('=SUM(E2:E$total)');
    awbs.getRangeByName('E${total + 1}').cellStyle.bold = true;
    awbs.getRangeByName('F${total + 1}').setFormula('=SUM(F2:F$total)');
    awbs.getRangeByName('F${total + 1}').cellStyle.bold = true;
    awbs.getRangeByName('A${total + 1}:B${total + 1}').cellStyle.hAlign =
        xls.HAlignType.center;
    awbs.getRangeByName('A${total + 1}:B${total + 1}').cellStyle.bold = true;
    List<int> bytes = lista.saveAsStream();
    lista.dispose();

    saveAndLaunchFile(bytes, 'ListaAwbs.xlsx');
  }
}
