import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/models/booking.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:ress_app/pdf/mobile.dart'
    if (dart.library.html) 'package:ress_app/pdf/web.dart';
import 'package:ress_app/models/user.dart';
import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/cards/white_card.dart';

class DashboardUserView extends StatefulWidget {
  const DashboardUserView({Key? key, required this.user}) : super(key: key);
  final Usuario user;

  @override
  State<DashboardUserView> createState() => _DashboardUserViewState();
}

class _DashboardUserViewState extends State<DashboardUserView> {
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
    return Column(
      children: [
        WhiteCard(title: 'Dashboard Usuario', child: Text(user.nombre)),
        const SizedBox(
          height: 10,
        ),
        WhiteCard(
            title: 'Resumen Reservas',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WhiteCard(
                    title: 'Reservas Aprobadas',
                    child: Text(
                      reservas.aprobadas.toString(),
                      style: const TextStyle(color: Colors.green),
                    )),
                const SizedBox(
                  height: 10,
                ),
                WhiteCard(
                    title: 'Reservas Canceladas',
                    child: Text(reservas.canceladas.toString(),
                        style: const TextStyle(color: Colors.red))),
                const SizedBox(
                  height: 10,
                ),
                WhiteCard(
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
            onPressed: () => _generateFlyPlan(reservas.planVuelo, user),
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
    );
  }

  Future _generateFlyPlan(List<Reserva> reservas, Usuario user) async {
    PdfDocument flyPlan = PdfDocument();
    final page = flyPlan.pages.add();
    DateTime today = DateTime.now();
    final Size pageSize = page.getClientSize();
    page.graphics.drawImage(PdfBitmap(await _readImageData()),
        const Rect.fromLTWH(400, 10, 100, 50));

    page.graphics.drawString(
        '\n\n\n\n\tGuatemala, ${today.day}/${today.month}/${today.year}\n\n\n\tPlan de Vuelo: ',
        PdfStandardFont(PdfFontFamily.timesRoman, 15,
            style: PdfFontStyle.bold));

    final PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 8,
            style: PdfFontStyle.bold),
        cellPadding: PdfPaddings(bottom: 2, left: 2, right: 2, top: 2));
    grid.columns.add(count: 6);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Aerolínea - No. AWB';
    headerRow.cells[1].value = 'Destino';
    headerRow.cells[2].value = 'Exportador';
    headerRow.cells[3].value = 'Peso Físico';
    headerRow.cells[4].value = 'Peso Volumétrico';
    headerRow.cells[5].value = 'Estado';

    for (var i = 0; i < reservas.length; i++) {
      addRow(
          '${reservas[i].aerolinea.prefijo.toString()}-${reservas[i].awb.toString()}',
          reservas[i].destino.prefijo,
          reservas[i].exportador.nombre,
          reservas[i].pesoFisico,
          reservas[i].pesoVolumetrico,
          (reservas[i].aprobacion) ? 'Aprobada' : 'Cancelada',
          grid);
    }

    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 200, 0, 0));

    page.graphics.drawString('____________________________\n${user.nombre}',
        PdfStandardFont(PdfFontFamily.timesRoman, 13, style: PdfFontStyle.bold),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height - 150, 0, 0));

    page.graphics.drawString(
        'Toda la Información contenida en el plan de vuelo ha sido revisada por \nnuestros analistas, por lo que se confirma que los kilos descritos seran despachados',
        PdfStandardFont(PdfFontFamily.timesRoman, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.left),
        bounds: Rect.fromLTWH(0, pageSize.height - 70, 0, 0));

    List<int> bytes = await flyPlan.save();
    flyPlan.dispose();
    saveAndLaunchFile(bytes, 'PlanDeVuelo.pdf');
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
