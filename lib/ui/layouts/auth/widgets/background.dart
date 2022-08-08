import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (size.width > 1000) ? Expanded(child: _getBackground(900)) : _getBackground(400);
  }

  Container _getBackground(width) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              width: 400,
              image: AssetImage('logo2.png'),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('banner.jfif'), fit: BoxFit.cover));
  }
}
