import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class InitDevDialog extends StatelessWidget {
  const InitDevDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Antes de iniciar'),
      content: Text(
        'Esta versión aún se encuentra en desarrollo. Si encuentra un error, por favor notifíquenos.',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Está bien',
              style: TextStyle(
                color: applicationColors['medium_purple'],
                fontSize: 16,
              ),
            ))
      ],
    );
  }
}
