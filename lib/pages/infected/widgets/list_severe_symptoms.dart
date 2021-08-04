import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/models/symptom_register.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';

class ListSevereSymptomPage extends StatefulWidget {
  @override
  _ListSevereSymptomPageState createState() => _ListSevereSymptomPageState();
}

class _ListSevereSymptomPageState extends State<ListSevereSymptomPage> {
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
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    CheckBoxListTile(
                        symptom: 'Dificultad para Respirar',
                        image: 'assets/difficulty-breathing.png',
                        checked: _symptom.difficultyBreathing,
                        onChanged: (bool value) {
                          setState(() {
                            _symptom.difficultyBreathing = value;
                            _symptom.toJson().forEach((key, value) {
                              if (value) {
                                selectedItems
                                    .add(Symptom(difficultyBreathing: value));
                              }
                            });
                            Preferences.myPrefs
                                .setSymptom('difficulty_breathing', value);
                          });
                        }),
                    CheckBoxListTile(
                      symptom: 'Dolor o presión en el pecho',
                      image: 'assets/chest-pain-or-pressure.png',
                      checked: _symptom.chestPainOrPressure,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.chestPainOrPressure = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems
                                  .add(Symptom(chestPainOrPressure: value));
                            }
                          });
                          Preferences.myPrefs
                              .setSymptom('chest_pain_or_pressure', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Incapacidad para hablar o moverse',
                      image: 'assets/inability-to speak.png',
                      checked: _symptom.inabilityToSpeak,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.inabilityToSpeak = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems
                                  .add(Symptom(inabilityToSpeak: value));
                            }
                          });
                          Preferences.myPrefs
                              .setSymptom('inability_to_speak', value);
                        });
                      },
                    )
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
