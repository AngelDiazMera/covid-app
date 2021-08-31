import 'package:covserver/config/theme.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertRestablish extends StatefulWidget {
  AlertRestablish({Key? key}) : super(key: key);

  @override
  _AlertRestablishState createState() => _AlertRestablishState();
}

class _AlertRestablishState extends State<AlertRestablish> {
  bool finish = false;
  bool loading = false;

  Future<void> _cancelRequest(HealthCondition hc) async {
    if (loading) return;
    setState(() => loading = true);

    // bool updatedSymp = await deleteSymptoms();

    // if (!updatedSymp) {
    //   setState(() {
    //     reqError = true;
    //     loading = false;
    //   });
    //   return;
    // }

    Preferences.myPrefs.deleteCovid();
    Preferences.myPrefs.setNeedHCUpdate(false);

    hc.healthCondition = 'healthy';
    setState(() {
      finish = true;
      loading = false;
    });
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

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

    return AlertDialog(
      content: loading
          ? Loader()
          : hc.notParsed == 'healthy'
              ? Text('Usted ya se encuentra en estado de bajo riesgo.')
              : RichText(
                  text: TextSpan(children: [
                  TextSpan(
                      text:
                          'Al aceptar esta opción, su estado se modificará a ',
                      style: TextStyle(
                          color: applicationColors['font_light'],
                          fontSize: 18)),
                  TextSpan(
                      text: 'sin riesgo',
                      style: TextStyle(
                          color: applicationColors['font_light'],
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          ', lo que podría causar confusiones, ¿Desea continuar?',
                      style: TextStyle(
                          color: applicationColors['font_light'], fontSize: 18))
                ])),
      actions: loading
          ? []
          : hc.notParsed == 'healthy'
              ? [
                  _buildActionButton(
                      'Está bien', () => Navigator.of(context).pop())
                ]
              : [
                  _buildActionButton(
                      'No, cancelar', () => Navigator.of(context).pop()),
                  _buildActionButton('Sí, acepto', () => _cancelRequest(hc))
                ],
    );
  }
}
