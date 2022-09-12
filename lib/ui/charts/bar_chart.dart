import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ress_app/models/http/kgs_by_exporters.dart';
import 'package:ress_app/ui/cards/white_card.dart';

class KgsBarChart extends StatelessWidget {
  const KgsBarChart(
      {Key? key, required this.totalesKgs, required this.registros})
      : super(key: key);
  final List<Totaleskg> totalesKgs;
  final List<Totaleskg> registros;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<charts.Series<Totaleskg, String>> series = [
      charts.Series(
        id: 'Total de Kilos',
        data: totalesKgs,
        domainFn: (Totaleskg series, _) => series.id,
        measureFn: (Totaleskg series, _) => series.totalVolumen,
        labelAccessorFn: (Totaleskg series, _) =>
            series.totalVolumen.toString(),
      )
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
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < registros.length; i++) ...[
                  WhiteCard(
                      title: totalesKgs[i].id,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('${totalesKgs[i].totalVolumen} kgs'))),
                ],
              ],
            ),
            // if (size.width < 733)
            //   for (var i = 0; i < registros.length; i++) ...[
            //     WhiteCard(
            //         title: totalesKgs[i].id,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 10),
            //           child: Text('${totalesKgs[i].totalVolumen} kgs'),
            //         )),
            //   ],
          ]),
        ));
  }
}
