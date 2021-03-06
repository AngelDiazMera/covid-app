import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

// ignore: must_be_immutable
class SexButton extends StatelessWidget {
  bool isSelected;
  Function onPressed;
  IconData icon;

  SexButton(
      {Key? key,
      required this.isSelected,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? color = isSelected
        ? applicationColors['light_purple']
        : Theme.of(context).brightness == Brightness.dark
            ? applicationColors['input_dark']
            : applicationColors['input_light'];

    return TextButton(
      onPressed: onPressed as void Function()?,
      child: Icon(icon),
      style: TextButton.styleFrom(
        primary: isSelected ? Colors.white : Colors.black54,
        backgroundColor: color,
        shape: CircleBorder(),
        minimumSize: Size(50, 50),
      ),
    );
  }
}
