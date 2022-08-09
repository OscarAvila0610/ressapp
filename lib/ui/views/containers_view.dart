import 'package:flutter/material.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';

import '../cards/white_card.dart';

class ContainersView extends StatelessWidget {
  const ContainersView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  [
          Text('Contenedores View', style: CustomLabels.h1,),

          const SizedBox(height: 10,),

          const WhiteCard(
            title: 'Contenedores',
            child: Text('Hola Mundo'),
          ),
        ],
      )
    );
  }
}