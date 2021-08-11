import 'package:covserver/config/theme.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/need_hc_update_provider.dart';
import 'package:covserver/utils/handle_notification_risk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertMakeInfected extends StatefulWidget {
  const AlertMakeInfected({Key? key}) : super(key: key);

  @override
  _AlertMakeInfectedState createState() => _AlertMakeInfectedState();
}

class _AlertMakeInfectedState extends State<AlertMakeInfected> {
  String hcState = '';
  bool loading = true;

  void _loadPrefs() async {
    String hc = await Preferences.myPrefs.getHealthCondition();
    setState(() {
      loading = false;
      hcState = hc;
    });
  }

  @override
  void initState() {
    _loadPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            // While getting prefs
            loading
                ? [
                    Text(
                      'Cargando...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ]
                // If is infected
                : hcState == 'infected'
                    ? [
                        Text(
                          'Lo sentimos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Usted ya se encuentra contagiado de Covid-19 y no puede registrar el riesgo.',
                          style: TextStyle(
                              fontSize: 19,
                              color: applicationColors['font_light']),
                        )
                      ]
                    // If is healthy or in risk
                    : [
                        Text(
                          'Información',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                'Al marcar esta opción, la aplicación te pondrá en ',
                            style: TextStyle(
                                color: applicationColors['font_light'],
                                fontSize: 19),
                            children: [
                              TextSpan(
                                  text: 'estado de riesgo ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
            if (hcState != 'infected') {
              handleNotificationRisk(context, hc);
            }
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
