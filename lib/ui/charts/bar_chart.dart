import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ress_app/models/http/kgs_by_exporters.dart';

class KgsBarChart extends StatefulWidget {
  const KgsBarChart(
      {Key? key, required this.totalesKgs, required this.registros})
      : super(key: key);
  final List<Totaleskg> totalesKgs;
  final List<Totaleskg> registros;

  @override
  State<KgsBarChart> createState() => _KgsBarChartState();
}

class _KgsBarChartState extends State<KgsBarChart> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<charts.Series<Totaleskg, String>> series = [
      charts.Series(
          id: 'Total de Kilos',
          data: widget.totalesKgs,
          domainFn: (Totaleskg series, _) => series.id,
          measureFn: (Totaleskg series, _) => series.totalVolumen,
          labelAccessorFn: (Totaleskg series, _) =>
              '${series.totalVolumen.toString()} kgs',
          colorFn: (Totaleskg series, _) =>
              charts.MaterialPalette.indigo.shadeDefault)
    ];
    return Container(
        height: size.height * 0.60,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Row(children: [
            Expanded(
                child: charts.BarChart(
              series,
              animate: true,
              barRendererDecorator: charts.BarLabelDecorator<String>(),
              domainAxis: const charts.OrdinalAxisSpec(),
            )),
          ]),
        ));
  }
}
