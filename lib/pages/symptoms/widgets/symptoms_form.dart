import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

import 'package:covserver/models/symptoms_user.dart';

import 'package:covserver/pages/symptoms/widgets/checkbox_list_tile_symptoms.dart';
import 'package:covserver/pages/symptoms/symptoms_config.dart';
import 'package:covserver/pages/symptoms/widgets/checked_value.dart';

import 'package:covserver/services/preferences/preferences.dart';

import 'package:covserver/widgets/date_picker_form.dart';

import 'checked_value.dart';

class SymptomForm extends StatefulWidget {
  final bool fullHeight;
  final bool trigger;
  final void Function(bool) setTrigger;
  final SymptomsUser symptomsUser;
  final void Function(DateTime) updateDate;

  const SymptomForm(
      {Key? key,
      required this.trigger,
      required this.symptomsUser,
      required this.setTrigger,
      required this.updateDate,
      this.fullHeight = false})
      : super(key: key);

  @override
  _SymptomFormState createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomForm> {
  CheckedSymptoms checkedSymptoms = CheckedSymptoms();
  bool loading = false;
  bool connectionFailed = false;
  String fechaSymptom = '';

  final _controllerSymptom = TextEditingController();
  // List<String> symptoms = [];
  String symptomsDate = '';

  @override
  void initState() {
    // symptoms = List<String>.from(widget.symptomsUser.symptoms);

    // print('DE FORM init: ${widget.symptomsUser.symptoms}');
    super.initState();
    // print(widget.symptomsUser.symptoms);
  }

  List<Widget> _drawBody() {
    double formMargin = 25;
    // Symptoms to widgets
    List<Widget> arr = symptomsList
        .map<Widget>((symptom) => CheckBoxListTile(
            symptom: symptom.name,
            image: symptom.asset,
            checked: widget.symptomsUser.symptoms.contains(symptom.name),
            onChanged: (bool? value) {
              setState(() {
                if (value!)
                  widget.symptomsUser.symptoms.add(symptom.name);
                else
                  widget.symptomsUser.symptoms.remove(symptom.name);

                Preferences.myPrefs.setSymptoms(widget.symptomsUser.symptoms);
                // Preferences.myPrefs
                //     .setChecked(checkedSymptoms.nameFever, value);
              });
            }))
        .toList();

    List<Widget> colBody = [];
    colBody
      ..addAll([
        Container(
          margin: EdgeInsets.symmetric(horizontal: 17.5),
          child: Text(
              'Seleccione sus síntomas en la lista y pulse el botón de la esquina para ver las opciones.',
              style: TextStyle(
                  color: applicationColors['font_light']!.withOpacity(0.7),
                  fontSize: 16)),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 17.5),
          child: DateWidget(
            controller: _controllerSymptom,
            selectDate: _selectDateSymptoms,
            label: 'Fecha de inicio',
            helper: 'Fecha en la cual iniciaron los síntomas',
          ),
        ),
      ])
      ..add(SizedBox(height: 20))
      ..addAll(arr)
      ..add(SizedBox(height: 20));
    return colBody;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnBody = _drawBody();

    // if (widget.trigger) {
    //   Preferences.myPrefs.setSymptoms(symptoms, symptomsDate: symptomsDate);
    //   print('$symptoms, $symptomsDate');
    //   widget.setTrigger(false);
    // }

    return Container(
      margin: EdgeInsets.only(
          right: 20, left: 20, bottom: widget.fullHeight ? 15 : 85),
      child: Column(
        children: columnBody,
      ),
    );
  }

  void _selectDateSymptoms(BuildContext context) async {
    const dateParser = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    DateTime today = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today.add(Duration(days: -120)),
      lastDate: today,
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        String formatDate =
            '${picked.day} de ${dateParser[picked.month - 1]} del ${picked.year}';
        symptomsDate = picked.toUtc().toString();
        widget.updateDate(picked);
        _controllerSymptom.text = formatDate;
      });
    }
  }
}
