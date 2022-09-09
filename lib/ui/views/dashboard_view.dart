import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/ui/cards/white_card.dart';
import 'package:ress_app/ui/charts/bar_chart.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    Provider.of<AdminProvider>(context, listen: false).getKgsByExporter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    final kgs = Provider.of<AdminProvider>(context);
    return Column(
      children: [
        if (user.rol == 'ADMIN_ROLE') ...[
          WhiteCard(
              title: 'Total Kgs por Exportador',
              child: KgsBarChart(
                totalesKgs: kgs.listaFinal,
                registros: kgs.kgsExporter,
              )),
        ]
      ],
    );
  }
}
