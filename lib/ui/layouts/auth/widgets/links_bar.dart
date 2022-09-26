import 'package:flutter/material.dart';

import '../../../buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      height: (size.width > 1000) ? size.height * 0.07 : null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children:  const [
          LinkText(text: 'Todos los derechos reservados. 2022© Agentes Aéreos, Sociedad Anonima'),
        ],
      )
    );
  }
}
