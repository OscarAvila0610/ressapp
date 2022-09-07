import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ress_app/models/http/kgs_by_exporters.dart';

class KgsBarChart extends StatelessWidget {
  const KgsBarChart({Key? key, required this.totalesKgs}) : super(key: key);
  final List<Totaleskg> totalesKgs;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Totaleskg, String>> series = [
      charts.Series(
        id: 'Total de Kilos',
        data: totalesKgs,
        domainFn: (Totaleskg series, _) => series.id,
        measureFn: (Totaleskg series, _) => series.totalVolumen,
      )
    ];
    return Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Expanded(
                  child: charts.BarChart(
                series,
                animate: true,
              ))
            ]),
          ),
        ));
  }
}
