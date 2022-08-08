import 'package:flutter/material.dart';
import 'package:ress_app/ui/cards/white_card.dart';

import 'package:ress_app/ui/labels/custom_labels.dart';


class IconsView extends StatelessWidget {
  const IconsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children:  [
          Text('Icons', style: CustomLabels.h1,),
          const SizedBox(height: 10,),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const [
              WhiteCard(
                child: Center(child: Icon(Icons.ac_unit_outlined),),
                title: 'ac_unit_outlined',
                width: 170
              ),
              WhiteCard(
                child: Center(child: Icon(Icons.access_alarm_outlined),),
                title: 'access_alarm_outlined',
                width: 170
              ),
              WhiteCard(
                child: Center(child: Icon(Icons.mail_outline),),
                title: 'mail_outline',
                width: 170
              ),
              WhiteCard(
                child: Center(child: Icon(Icons.people_alt),),
                title: 'people_alt',
                width: 170
              ),
              WhiteCard(
                child: Center(child: Icon(Icons.desktop_mac_outlined),),
                title: 'desktop_mac_outlined',
                width: 170
              ),
            ],
          )
        ],
      )
    );
  }
}