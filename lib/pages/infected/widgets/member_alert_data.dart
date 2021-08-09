import 'package:flutter/material.dart';

class MemberAlertData extends StatelessWidget {
  final Map<dynamic, dynamic> alert;
  final Map<dynamic, dynamic> args;

  const MemberAlertData({
    Key? key,
    required this.alert,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: alert['completeName'] != null ? 15 : 0),
        Text(
          alert['completeName'] ?? '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: alert['completeName'] != null ? 5 : 0),
        Text(
          '${alert['completeName'] != null ? 'Reportó' : 'Se reportaron'} síntomas el \n${args['symptomsDate']}',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Expanded(child: SizedBox()),
        Text(
          'Pudo haber tenido contacto en',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 5),
        Text(
          alert['groupName'] ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
