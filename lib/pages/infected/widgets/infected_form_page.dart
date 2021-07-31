import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/text_symptom.dart';
import 'package:persistencia_datos/pages/infected/widgets/date_picker.dart';
import 'form_observer.dart';
import 'float_button.dart';
import 'list_common_symptoms.dart';
import 'list_less_common_symptoms.dart';
import 'list_severe_symptoms.dart';

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
                        TextSymptomPage(
                          txt: 'Síntomas comunes',
                        ),
                        ListCommonSymptomPage(),
                        TextSymptomPage(
                          txt: 'Síntomas menos comunes',
                        ),
                        ListLessCommonSymptomPage(),
                        TextSymptomPage(
                          txt: 'Síntomas graves',
                        ),
                        ListSevereSymptomPage(),
                        DatePickerPage(),
                        SettingsForm(),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FloatButtonPage(),
                        ),
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
