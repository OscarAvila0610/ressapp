import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ress_app/models/user.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.user}) : super(key: key);
  final Usuario user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          const Icon(
            Icons.bubble_chart_outlined,
            size: 50,
            color: Color(0xff7A6BF5),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              user.exportador.nombre,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserratAlternates(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
