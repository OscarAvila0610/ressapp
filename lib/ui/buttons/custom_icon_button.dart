import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = Colors.indigo,
      this.isFilled = false,
      required this.icon})
      : super(key: key);

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateProperty.all(color.withOpacity(0.5)),
        overlayColor: MaterialStateProperty.all(color.withOpacity(0.3)),
      ),
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
