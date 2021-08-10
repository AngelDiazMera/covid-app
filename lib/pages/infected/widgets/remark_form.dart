import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/symptoms/recomedaciones_symptom_page.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/widgets/floatbutto_widget.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';
import 'package:persistencia_datos/widgets/date_picker_form.dart';
import 'package:intl/intl.dart';

class RemarkForm extends StatefulWidget {
  @override
  _RemarkFormState createState() => _RemarkFormState();
}

class _RemarkFormState extends State<RemarkForm> {
  SymptomsUser _symptomsUser = SymptomsUser();
  String fechaSymptom = '';
  final _controllerSymptom = TextEditingController();
  Map<String, dynamic> _formData = {
    'symptomDate': '',
    'remarks': '',
  };

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    // Inputs of the form
    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Comentarios',
            'value': _formData['remarks'],
            'keyboard': TextInputType.text,
            'onChanged': _remarksOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.comment
      },
    ];

    return Column(
      children: [
        SizedBox(height: 20),
        DateWidget(
            controller: _controllerSymptom, selectDate: _selectDateSymptoms),
        CustomForm(
          inputs: _inputs,
          horizontalMargin: formMargin,
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: buildButton(),
        ),
      ],
    );
  }

  void _signSymptoms() {
    /*_symptomsUser.remarks = _formData['remarks'];
    _formData['symptomDate'] = _symptomsUser.symptomsDate;
    SymptomsUser newSymptom = SymptomsUser.fromJson(_formData);
    MySymptom.mine.saveMySymptom(newSymptom);*/
  }

  void _remarksOnChange(String value) {
    setState(() {
      _formData['remarks'] = value;
    });
  }

  Widget buildButton() => ButtonWidget(onClicked: () async {
        _signSymptoms();
        //_signDate();
        _pantallaform(context);
      });

  void _pantallaform(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, //Para el clikc afuera y salir
        builder: (context) {
          return SymptomPage();
        });
  }

  void _selectDateSymptoms(BuildContext context) async {
    _symptomsUser.symptomsDate = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                  primary: const Color.fromRGBO(72, 75, 235, 1),
                  onPrimary: Colors.white,
                  brightness: Brightness.light),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        });

    if (_symptomsUser.symptomsDate != null) {
      String formattedDate =
          DateFormat('dd-MM-yyy').format(_symptomsUser.symptomsDate);
      setState(() {
        fechaSymptom = formattedDate;
        _controllerSymptom.text = fechaSymptom;
      });
    }
  }
}
