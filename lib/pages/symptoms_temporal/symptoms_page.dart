import 'package:covserver/pages/symptoms_temporal/widgets/alert_notification.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: DESTRUIR ESTA PÁGINA DE PRUEBA

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de síntomas'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertNotificationFound(
                onAccepted: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  hc.healthCondition = 'infected';
                },
              ),
            );
          },
          child: Text('Estoy contagiado'),
        ),
      ),
    );
  }
}
