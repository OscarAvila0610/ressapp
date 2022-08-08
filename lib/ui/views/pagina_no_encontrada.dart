import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginaNoEncontrada extends StatelessWidget {
  const PaginaNoEncontrada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: Text(
          '404 - Pagina no Encontrada',
          style: GoogleFonts.montserratAlternates(
              fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
