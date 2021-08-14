import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/pages/infected/widgets/text_symptom.dart';
import 'package:persistencia_datos/pages/infected/widgets/symptoms_form.dart';

class InfectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments ?? 'No data';

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
