import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/database/db.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/history_provider.dart';
import 'package:covserver/utils/handle_history_save.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertPeriodicRecord extends StatelessWidget {
  final SymptomsUser symptomsUser;

  const AlertPeriodicRecord({Key? key, required this.symptomsUser})
      : super(key: key);

  Widget _buildActionButton(String label, void Function() onPressed) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: applicationColors['medium_purple'],
            fontSize: 16,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);
    final hp = Provider.of<HistoryProvider>(context);

    return AlertDialog(
      content: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'El registro se almacenará en estado ',
            style: TextStyle(
                color: applicationColors['font_light'], fontSize: 18)),
        TextSpan(
            text: 'sin riesgo',
            style: TextStyle(
                color: applicationColors['font_light'],
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: ' con los síntomas que haya seleccionado, ¿Desea continuar?.',
            style:
                TextStyle(color: applicationColors['font_light'], fontSize: 18))
      ])),
      actions: [
        _buildActionButton('No, cancelar', () => Navigator.pop(context)),
        _buildActionButton('Sí, continuar', () async {
          HistoryModel? history = await handleHistorySave(
              symptomsUser, hc.notParsed == 'healthy' ? 'none' : hc.notParsed);

          if (history == null) return;

          hp.addRegister(history);
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
        }),
      ],
    );
  }
}
