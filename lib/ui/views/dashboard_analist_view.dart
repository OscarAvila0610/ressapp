import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/models/booking.dart';
import 'package:ress_app/models/user.dart';
import 'package:ress_app/services/notifications_service.dart';
import 'package:ress_app/ui/charts/pie_chart.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:ress_app/pdf/mobile.dart'
    if (dart.library.html) 'package:ress_app/pdf/web.dart';

import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/cards/white_card.dart';

class DashboardAnalistView extends StatefulWidget {
  const DashboardAnalistView({Key? key, required this.user}) : super(key: key);
  final Usuario user;

  @override
  State<DashboardAnalistView> createState() => _DashboardAnalistViewState();
}

class _DashboardAnalistViewState extends State<DashboardAnalistView> {
  @override
  void initState() {
    Provider.of<BookingsProvider>(context, listen: false)
        .getBookings(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    final reservas = Provider.of<BookingsProvider>(context);
    return SingleChildScrollView(
        child: Column(
      children: [
        WhiteCard(
            title: 'Resumen Analista',
            child: BookingPieChart(
              aprobadas: reservas.aprobadas,
              canceladas: reservas.canceladas,
              pendientes: reservas.pendientes,
            )),
        const SizedBox(
          height: 10,
        ),
        WhiteCard(
            title: 'Resumen Reservas',
            child: Wrap(
              spacing: 75,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                WhiteCard(
                    width: 170,
                    title: 'Reservas Aprobadas',
                    child: Text(
                      reservas.aprobadas.toString(),
                      style: const TextStyle(color: Colors.green),
                    )),
                const SizedBox(
                  height: 10,
                ),
                WhiteCard(
                    width: 170,
                    title: 'Reservas Canceladas',
                    child: Text(reservas.canceladas.toString(),
                        style: const TextStyle(color: Colors.red))),
                const SizedBox(
                  height: 10,
                ),
                WhiteCard(
                    width: 170,
                    title: 'Reservas Pendientes',
                    child: Text(reservas.pendientes.toString())),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: ElevatedButton(
            onPressed: () {
              if (reservas.planVuelo.isNotEmpty) {
                _generateFlyPlan(reservas.planVuelo, user);
              } else {
                NotificationsService.showSnackbarError(
                    'No hay registros en el plan de vuelo de hoy');
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            child: Row(
              children: const [
                Icon(
                  Icons.airplanemode_active_outlined,
                  size: 20,
                ),
                Text(' Generar Plan de Vuelo')
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Future _generateFlyPlan(List<Reserva> reservas, Usuario user) async {
    PdfDocument flyPlan = PdfDocument();
    final page = flyPlan.pages.add();
    DateTime today = DateTime.now();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(PdfBitmap(await _readImageData()),
        const Rect.fromLTWH(400, 10, 100, 50));
    int kilosDespachados = 0;
    double canceladasPer = 0;

    page.graphics.drawString(
        '\tGuatemala, ${today.day}/${today.month}/${today.year}\n\n\n\tSe??ores\n\tOperaciones\n\tIBERIA L??NEAS A??REAS DE ESPA??A, S.A OPERADORA\n\tPresente',
        PdfStandardFont(
          PdfFontFamily.timesRoman,
          12,
          style: PdfFontStyle.bold,
        ),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height * 0.10, 0, 0));
    page.graphics.drawString(
        '\tEstimados se??ores Operaciones: \n\n\tEn la presente se encuentra la informacion correspondiente al vuelo IB6342 del d??a de hoy.',
        PdfStandardFont(PdfFontFamily.timesRoman, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height * 0.30, 0, 0));

    final PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(
          PdfFontFamily.timesRoman,
          8,
          style: PdfFontStyle.bold,
        ),
        cellPadding: PdfPaddings(bottom: 2, left: 2, right: 2, top: 2));
    grid.columns.add(count: 6);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Aerol??nea - No. AWB';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Destino';
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[2].value = 'Exportador';
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].value = 'Peso F??sico';
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[4].value = 'Peso Volum??trico';
    headerRow.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[5].value = 'Estado';
    headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;

    for (var i = 0; i < reservas.length; i++) {
      addRow(
          '${reservas[i].aerolinea.prefijo.toString()}-${reservas[i].awb.toString()}',
          reservas[i].destino.prefijo,
          reservas[i].exportador.nombre,
          reservas[i].pesoFisico,
          reservas[i].pesoVolumetrico,
          (reservas[i].aprobacion) ? 'Aprobada' : 'Cancelada',
          grid);
      if (reservas[i].aprobacion) {
        kilosDespachados = kilosDespachados + reservas[i].pesoVolumetrico;
      } else {
        canceladasPer = canceladasPer + 1;
      }
    }
    canceladasPer = (canceladasPer / reservas.length) * 100;

    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }

    grid.draw(
        page: page, bounds: Rect.fromLTWH(0, pageSize.height * 0.40, 0, 0));

    page.graphics.drawString(
        '\tTotal de Kilos Despachados: $kilosDespachados\n\n\tPorcentaje Reservas Canceladas: $canceladasPer%',
        PdfStandardFont(PdfFontFamily.timesRoman, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height * 0.63, 0, 0));

    page.graphics.drawString(
        '\t____________________________\n\t${user.nombre}\n\t${user.exportador.nombre}',
        PdfStandardFont(PdfFontFamily.timesRoman, 13, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height * 0.80, 0, 0));

    page.graphics.drawString(
        'Toda la Informaci??n contenida en el plan de vuelo ha sido revisada por \nnuestros analistas, por lo que se confirma que los kilos descritos seran despachados',
        PdfStandardFont(PdfFontFamily.timesRoman, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.justify),
        bounds: Rect.fromLTWH(0, pageSize.height - 70, 0, 0));

    List<int> bytes = await flyPlan.save();
    flyPlan.dispose();
    saveAndLaunchFile(
        bytes, 'Plan de Vuelo ${today.day}-${today.month}-${today.year}.pdf');
  }

  Future<Uint8List> _readImageData() async {
    final data = await rootBundle.load('logo3.jpeg');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  void addRow(String aerolineaAWb, String destino, String exportador,
      int pesofis, int pesoVol, String aprobada, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = aerolineaAWb;
    row.cells[1].value = destino;
    row.cells[2].value = exportador;
    row.cells[3].value = pesofis.toString();
    row.cells[4].value = pesoVol.toString();
    row.cells[5].value = aprobada;
  }
}
