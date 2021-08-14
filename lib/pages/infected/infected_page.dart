import 'package:covserver/config/theme.dart';
import 'package:covserver/pages/infected/widgets/symptoms_form.dart';
import 'package:covserver/pages/infected/widgets/text_symptom.dart';
import 'package:flutter/material.dart';

import 'package:covserver/services/api/requests.dart';

/// Page displayed when handle infected notifications
class InfectedPage extends StatefulWidget {
  @override
  _InfectedPageState createState() => _InfectedPageState();
}

class _InfectedPageState extends State<InfectedPage> {
  // Flags
  bool loading = true;
  bool isRequesting = false;
  // Data retrieved from api
  Map? alert = new Map();

  /// Loads the data making a request to the api
  void loadAlert(Map args) async {
    if (!loading) return;
    if (isRequesting) return;
    setState(() => isRequesting = true);
    Map? data =
        await getAlertData(args['userRef'], args['groupRef'], args['anonym'],
            onError: (String err) {
      print(err);
    });
    if (data == null) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      alert = data;
      loading = false;
      isRequesting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Data from the notification
    final Map args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    // Get data from server
    loadAlert(args);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sintomología'),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? applicationColors['medium_purple']
            : applicationColors['medium_purple'],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 30.0),
          shrinkWrap: true,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextSymptomPage(
                            txt: '¿Tienes algún síntoma?',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SymptomForm(),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
