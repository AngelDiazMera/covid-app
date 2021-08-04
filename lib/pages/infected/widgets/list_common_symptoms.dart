import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/models/symptom_register.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';

class ListCommonSymptomPage extends StatefulWidget {
  @override
  _ListCommonSymptomPageState createState() => _ListCommonSymptomPageState();
}

class _ListCommonSymptomPageState extends State<ListCommonSymptomPage> {
  Symptom _symptom = new Symptom();
  List<Symptom> selectedItems = List();

  @override
  void initState() {
    super.initState();
    _setSymptom();
  }

  Future<void> _setSymptom() async {
    Symptom symptom = await MySymtop.mine.getMySymptom();
    setState(() {
      _symptom = symptom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(children: [
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    CheckBoxListTile(
                        symptom: 'Fiebre',
                        image: 'assets/fever.png',
                        checked: _symptom.fever,
                        onChanged: (bool value) {
                          setState(() {
                            _symptom.fever = value;
                            _symptom.toJson().forEach((key, value) {
                              if (value) {
                                selectedItems.add(Symptom(fever: value));
                              }
                            });
                            Preferences.myPrefs.setSymptom('fever', value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Tos Seca',
                        image: 'assets/dry-cough.png',
                        checked: _symptom.dryCough,
                        onChanged: (bool value) {
                          setState(() {
                            _symptom.dryCough = value;
                            _symptom.toJson().forEach((key, value) {
                              if (value) {
                                selectedItems.add(Symptom(dryCough: value));
                              }
                            });
                            Preferences.myPrefs.setSymptom('dry_cough', value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Cansancio',
                        image: 'assets/fatigue.png',
                        checked: _symptom.fatigue,
                        onChanged: (bool value) {
                          setState(() {
                            _symptom.fatigue = value;
                            _symptom.toJson().forEach((key, value) {
                              if (value) {
                                selectedItems.add(Symptom(fatigue: value));
                              }
                            });
                            Preferences.myPrefs.setSymptom('fatigue', value);
                          });
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ]);
  }
}
