import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/date_picker.dart';
import 'package:persistencia_datos/pages/covid/widgets/state_covid.dart';
import 'float_button_covid.dart';
import 'custom_form_covid.dart';

class SymptomFormPage extends StatefulWidget {
  @override
  _SymptomFormPageState createState() => _SymptomFormPageState();
}

class _SymptomFormPageState extends State<SymptomFormPage> {
  String _infection = 'Bajo riesgo';
  Color _color;
  String _txt;
  @override
  Widget build(BuildContext context) {
    if (_infection == 'Bajo riesgo') {
      _txt = _infection;
      _color = Colors.greenAccent;
    } else {
      _txt = 'En riesgo';
      _color = Colors.redAccent;
    }
    double formMargin = 25;
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
                        StateCovidPage(
                          estado: _txt,
                          estadoColor: _color,
                        ),
                        CustomFormSymptom(
                            horizontalMargin: formMargin,
                            hasInfectionSelection: true,
                            infection: _infection,
                            onInfectionChange: (String value) {
                              setState(() {
                                _infection = value;
                              });
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        DatePickerPage(),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
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
