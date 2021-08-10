import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/text_symptom.dart';
import 'remark_form.dart';
import 'list_symptoms.dart';

class InfectedFormPage extends StatefulWidget {
  @override
  _InfectedFormPageState createState() => _InfectedFormPageState();
}

class _InfectedFormPageState extends State<InfectedFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          alignment: Alignment.center,
                          child: TextSymptomPage(
                            txt: 'Sintomas',
                          ),
                        ),
                        ListSymptomPage(),
                        RemarkForm(),
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
