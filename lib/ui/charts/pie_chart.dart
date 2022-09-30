import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class BookingPieChart extends StatefulWidget {
  const BookingPieChart({
    Key? key,
    required this.aprobadas,
    required this.canceladas,
    required this.pendientes,
  }) : super(key: key);
  final int aprobadas;
  final int canceladas;
  final int pendientes;

  @override
  State<BookingPieChart> createState() => _BookingPieChartState();
}

class _BookingPieChartState extends State<BookingPieChart> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final total = widget.aprobadas + widget.canceladas + widget.pendientes;
    final aprobadas = (widget.aprobadas == 0) ? 0 : widget.aprobadas / total;
    final canceladas = (widget.aprobadas == 0) ? 0 : widget.canceladas / total;
    final pendientes = (widget.aprobadas == 0) ? 0 : widget.pendientes / total;
    Map<String, double> dataMap = {
      'Aprobadas': aprobadas * 100,
      'Canceladas': canceladas * 100,
      'Pendientes': pendientes * 100
    };
    List<Color> colorList = [
      const Color(0xff10A33A),
      const Color(0xffC11616),
      const Color(0xffA2A1A1)
    ];
    return Container(
        height: size.height * 0.45,
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          Expanded(
              child: PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius: size.width / 2,
            chartType: ChartType.ring,
            ringStrokeWidth: 50,
            animationDuration: const Duration(seconds: 2),
            chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValueBackground: false),
            legendOptions: LegendOptions(
                legendPosition: (size.width > 488)
                    ? LegendPosition.right
                    : LegendPosition.bottom),
          )),
        ]));
  }
}

class PieChartData {
  PieChartData({required this.title, required this.cant});

  String title;
  int cant;
}
