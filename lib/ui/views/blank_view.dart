import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

import '../cards/white_card.dart';

class BlankView extends StatelessWidget {
  const BlankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            WhiteCard(
              title: user!.nombre,
              child: Text(
                'Lleve su mercancía dónde necesite rápidamente con Prioritise - nuestra solución express, cuya esencia es la fiabilidad, ofrece tiempos de entrega y aceptación rápidos para todas las cargas unitarias y sueltas.',
                style: CustomLabels.text,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const WhiteCard(child: Banner())
          ],
        ));
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        width: double.infinity,
        child: const Image(
          image: AssetImage('banner.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      //height: 40,
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
      ],
      image: const DecorationImage(image: AssetImage('banner.jpg')));
}
