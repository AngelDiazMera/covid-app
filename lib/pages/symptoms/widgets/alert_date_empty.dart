import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class AlertDateEmpty extends StatelessWidget {
  const AlertDateEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cuidado',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
              'No puede realizar esta opción si ha marcado síntomas y no ha establecido una fecha de inicio.',
              style: TextStyle(
                  color: applicationColors['font_light'], fontSize: 18)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text(
            "Aceptar",
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
