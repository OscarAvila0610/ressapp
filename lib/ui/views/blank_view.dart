import 'package:flutter/material.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';

import '../cards/white_card.dart';

class BlankView extends StatelessWidget {
  const BlankView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  [
          Text('Blank View', style: CustomLabels.h1,),

          const SizedBox(height: 10,),

          const WhiteCard(
            title: 'Hello',
            child: Text('Hola Mundo'),
          ),
        ],
      )
    );
  }
}