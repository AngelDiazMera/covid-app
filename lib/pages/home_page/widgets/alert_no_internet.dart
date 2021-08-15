import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class AlertNoInternet extends StatelessWidget {
  final Function? onAccepted;

  const AlertNoInternet({Key? key, this.onAccepted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('No se encuentra conectado a internet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center),
          SizedBox(
            height: 15,
          ),
          Text(
              'Podrá seguir utilizando la aplicación, sin embargo, las funciones se encontrarán limitadas.',
              style: TextStyle(color: applicationColors['font_light']),
              textAlign: TextAlign.center)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onAccepted != null) onAccepted!();
            Navigator.pop(context);
          },
          child: Text(
            "Está bien",
            style: TextStyle(
              color: applicationColors['medium_purple'],
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
