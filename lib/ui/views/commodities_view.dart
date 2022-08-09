import 'package:flutter/material.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';

import '../cards/white_card.dart';

class CommoditiesView extends StatelessWidget {
  const CommoditiesView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  [
          Text('Tipos de Carga', style: CustomLabels.h1,),

          const SizedBox(height: 10,),

          const WhiteCard(
            title: 'Tipo de Carga',
            child: Text('Hola Mundo'),
          ),
        ],
      )
    );
  }
}