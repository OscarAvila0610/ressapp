import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'AGENTES AEREOS, S.A.',
              style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 10,),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'CARGO LIVE',
              style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          // const SizedBox(height: 10,),
          // const Image(
          //   width: 150,
          //   image: AssetImage('logo3.jpeg'),
          // )
        ],
      ),
    );
  }
}