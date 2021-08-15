import 'package:covserver/config/theme.dart';
import 'package:covserver/data/symptoms.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertNoInfection extends StatefulWidget {
  const AlertNoInfection({Key? key}) : super(key: key);

  @override
  _AlertNoInfectionState createState() => _AlertNoInfectionState();
}

class _AlertNoInfectionState extends State<AlertNoInfection> {
  bool loading = true;

  Future<bool> _makeHealthy() async {
    setState(() => loading = true);
    Map? updated = await setHealthState('healthy');
    setState(() => loading = false);

    if (updated != null) {
      Preferences.myPrefs.setNeedHCUpdate(false);
      Preferences.myPrefs.setHealthCondition('healthy');
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'El tiempo de espera ha terminado',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Debido a que no mostró reportes de contagio por Covid-19 en los últimos 14 días, necesitamos saber cómo se encuentra',
            style: TextStyle(color: applicationColors['font_light']),
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            bool isHealthy = await _makeHealthy();
            if (isHealthy) {
              Navigator.pop(context);
              hc.healthCondition = 'healthy';
            }
          },
          child: Text(
            "Estoy saludable",
            style: TextStyle(
              color: applicationColors['medium_purple'],
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/symptoms_register'),
          child: Text(
            "Estoy contagiado",
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
