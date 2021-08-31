import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/symptoms_user.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/history_provider.dart';
import 'package:covserver/utils/handle_history_save.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertPeriodicRecord extends StatefulWidget {
  final SymptomsUser symptomsUser;

  const AlertPeriodicRecord({Key? key, required this.symptomsUser})
      : super(key: key);

  @override
  _AlertPeriodicRecordState createState() => _AlertPeriodicRecordState();
}

class _AlertPeriodicRecordState extends State<AlertPeriodicRecord> {
  bool loading = false;
  bool reqError = false;
  bool finish = false;

  void _makeRequest(HealthCondition hc, HistoryProvider hp) async {
    if (loading) return;
    setState(() => loading = true);
    // verify if the user has exceeded 3 attempts per day limit
    var isAvailable = await Preferences.myPrefs.canMakeHistory();
    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sólo puede hacer 3 registros por día.')));
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }
    // Call to endpoint. If call is successful, saves on the database
    // and returns an HistoryModel instance. Else, return null;
    HistoryModel? history = await handleHistorySave(
        widget.symptomsUser, hc.notParsed == 'healthy' ? 'none' : hc.notParsed);
    if (history == null) {
      setState(() {
        reqError = true;
        loading = false;
      });
      return;
    }
    // Global state update
    hp.addRegister(history);
    // End of the call
    setState(() {
      finish = true;
      loading = false;
      reqError = false;
    });
  }

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
      content: loading
          ? Loader()
          : reqError
              ? Text(
                  'Hubo un problema con la actualización. Inténtalo más tarde.')
              : finish
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Excelente',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('El estado se ha actualizado con éxito.',
                            style: TextStyle(
                                color: applicationColors['font_light'],
                                fontSize: 18)),
                      ],
                    )
                  : RichText(
                      text: TextSpan(children: [
                      TextSpan(
                          text:
                              'El registro se almacenará en el estado actual (',
                          style: TextStyle(
                              color: applicationColors['font_light'],
                              fontSize: 18)),
                      TextSpan(
                          text: hc.healthCondition.toLowerCase(),
                          style: TextStyle(
                              color: applicationColors['font_light'],
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ') con los síntomas que haya seleccionado, ¿Desea continuar?.',
                          style: TextStyle(
                              color: applicationColors['font_light'],
                              fontSize: 18))
                    ])),
      actions: loading
          ? []
          : reqError
              ? [_buildActionButton('Está bien', () => Navigator.pop(context))]
              : finish
                  ? [
                      _buildActionButton(
                          'Está bien',
                          () => Navigator.of(context)
                              .popUntil(ModalRoute.withName('/')))
                    ]
                  : [
                      _buildActionButton(
                          'No, cancelar', () => Navigator.pop(context)),
                      _buildActionButton(
                          'Sí, continuar', () => _makeRequest(hc, hp)),
                    ],
    );
  }
}
