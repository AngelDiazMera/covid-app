import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class CovidButton extends StatelessWidget {
  bool isSelected;
  Function onPressed;
  IconData icon;

  CovidButton(
      {Key key,
      @required this.isSelected,
      @required this.onPressed,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? applicationColors['light_purple']
        : Theme.of(context).brightness == Brightness.dark
            ? applicationColors['input_dark']
            : applicationColors['input_light'];

    return TextButton(
      onPressed: onPressed,
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