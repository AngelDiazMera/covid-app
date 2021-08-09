import 'package:covserver/config/theme.dart';
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

  void _makeHealthy() async {
    Map? updated = await setHealthState('healthy');
    setState(() => loading = false);

    if (updated != null) {
      Preferences.myPrefs.setHealthCondition('healthy');
    }
  }

  @override
  void initState() {
    super.initState();
    _makeHealthy();
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    if (loading)
      return AlertDialog(
        content: Text(
          'Cargando...',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '¡Felicidades!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Debido a que no mostró reportes de contagio por Covid-19 en los últimos 14 días, su estado pasa a "sin riesgo".',
            style: TextStyle(color: applicationColors['font_light']),
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              hc.healthCondition = 'healthy';
              Navigator.pop(context, 'OK');
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color?>(
                applicationColors['medium_purple'],
              ),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              foregroundColor: MaterialStateProperty.all<Color?>(
                  applicationColors['font_dark']),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            child: Text("Asombroso"),
          ),
        ),
      ],
    );
  }
}
