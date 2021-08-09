import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

import 'calendar_dialog.dart';

class VisitAlertData extends StatelessWidget {
  final Map<dynamic, dynamic> alert;
  final Map<dynamic, dynamic> args;

  const VisitAlertData({
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
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    CalendarDialog(dates: alert['dates'] ?? ''),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 5),
                  Text(
                    'Ver calendario',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    applicationColors['font_light']!.withOpacity(0.75)),
                overlayColor: MaterialStateProperty.all<Color>(
                    applicationColors['font_light']!.withOpacity(0.15)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
