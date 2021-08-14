import 'package:covserver/config/theme.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/preferences/preferences.dart';
import 'package:flutter/material.dart';

class AlertNotificationFound extends StatefulWidget {
  // final Symptoms symptom;
  final Function? onAccepted;

  const AlertNotificationFound({Key? key, this.onAccepted}) : super(key: key);

  @override
  _AlertNotificationFoundState createState() => _AlertNotificationFoundState();
}

class _AlertNotificationFoundState extends State<AlertNotificationFound> {
  bool loading = false;
  bool connectionFailed = false;

  @override
  void initState() {
    super.initState();
    _makeInfected();
  }

  /// Make the request to the api
  Future<bool> _makeInfected() async {
    DateTime symptomsDate = DateTime.now();

    // Notify Infected
    bool hasNotified = await notifyInfected(
        anonym: false,
        symptomsDate: symptomsDate,
        onError: (String error) => print(error));

    if (hasNotified) {
      Preferences.myPrefs.setNeedHCUpdate(false);
      Preferences.myPrefs.setHealthCondition('infected');
      setState(() => loading = false);
      return true;
    }
    setState(() => loading = false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: connectionFailed
          ? Text(
              'Parece que hubo un problema con el servidor. Inténtalo más tarde.')
          : loading // If it's loading
              ? Text('Cargando')
              : Text(
                  'El registro se ha realizado exitosamente',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
      actions: !loading
          ? [
              TextButton(
                onPressed: () {
                  if (widget.onAccepted != null)
                    widget.onAccepted!();
                  else
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
            ]
          : null,
    );
  }
}
