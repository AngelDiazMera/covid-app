import 'package:covserver/config/theme.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/utils/handle_notification_risk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertMakeInfected extends StatelessWidget {
  const AlertMakeInfected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Información',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              text: 'Al marcar esta opción, la aplicación te pondrá en ',
              style: TextStyle(
                  color: applicationColors['font_light'], fontSize: 19),
              children: [
                TextSpan(
                    text: 'estado de riesgo ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: ' durante las siguientes dos semanas.',
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'CANCEL');
          },
          child: Text(
            "Cancelar",
            style: TextStyle(
              color: applicationColors['font_light']!.withOpacity(0.75),
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            handleNotificationRisk(context, hc);
            Navigator.of(context).popUntil(ModalRoute.withName('/'));
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
