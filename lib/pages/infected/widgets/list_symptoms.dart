import 'package:flutter/material.dart';
import 'package:persistencia_datos/data/symptoms.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/pages/covid/widgets/covid_form_page.dart';
import 'package:persistencia_datos/pages/infected/widgets/checked_value.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/services/auth/my_checked.dart';

class ListSymptomPage extends StatefulWidget {
  @override
  _ListSymptomPageState createState() => _ListSymptomPageState();
}

class _ListSymptomPageState extends State<ListSymptomPage> {
  SymptomsUser _symptomsUser = SymptomsUser();
  List<String> symptom = [];
  Checked _checked = Checked();
  String namedifficultyBreathing = 'difficulty breathing';
  String namechestPainOrPressure = 'chest pain or pressure';
  String nameinabilityToSpeak = 'inability to speak';
  String nameFever = 'fever';
  String nameDryCough = 'dry cough';
  String nameFatigue = 'fatigue';
  String nameSoreThroat = 'sore throat';
  String nameDiarrhoea = 'diarrhoea';
  String nameConjuctivitis = 'conjuctivitis';
  String nameHeadache = 'headache';
  String nameLossSenseOfSmell = 'loss sense of smell';
  String nameLossColourInFingers = 'loss colour in fingers';

  @override
  void initState() {
    super.initState();
    //_setSymptom();
  }

  /*Future<void> _setSymptom() async {
    Checked checkedVal = await MyChecked.mine.getMyChecked();
    setState(() {
      _checked = checkedVal;
    });
  }
*/
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
                        checked: _checked.fever,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.fever = value;

                            if (value) {
                              symptom.add(nameFever);
                              _symptomsUser.symptoms = symptom;
                            } else {
                              _symptomsUser.symptoms.remove(nameFever);
                            }
                            Preferences.myPrefs.setChecked(nameFever, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Tos Seca',
                        image: 'assets/dry-cough.png',
                        checked: _checked.dryCough,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.dryCough = value;
                            if (value) {
                              _symptomsUser.symptoms.add(nameDryCough);
                            } else {
                              _symptomsUser.symptoms.remove(nameDryCough);
                            }
                            Preferences.myPrefs.setChecked(nameDryCough, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Cansancio',
                        image: 'assets/fatigue.png',
                        checked: _checked.fatigue,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.fatigue = value;
                            if (value) {
                              _symptomsUser.symptoms.add(nameFatigue);
                            } else {
                              _symptomsUser.symptoms.remove(nameFatigue);
                            }
                            Preferences.myPrefs.setChecked(nameFatigue, value);
                          });
                        }),
                    CheckBoxListTile(
                      symptom: 'Dolor de Garganta',
                      image: 'assets/sore_throat.png',
                      checked: _checked.soreThroat,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.soreThroat = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameSoreThroat);
                          } else {
                            _symptomsUser.symptoms.remove(nameSoreThroat);
                          }
                          Preferences.myPrefs.setChecked(nameSoreThroat, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Diarrea',
                      image: 'assets/diarrhoea.png',
                      checked: _checked.diarrhoea,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.diarrhoea = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameDiarrhoea);
                          } else {
                            _symptomsUser.symptoms.remove(nameDiarrhoea);
                          }
                          Preferences.myPrefs.setChecked(nameDiarrhoea, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Conjuntivitis',
                      image: 'assets/conjuctivitis.png',
                      checked: _checked.conjuctivitis,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.conjuctivitis = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameConjuctivitis);
                          } else {
                            _symptomsUser.symptoms.remove(nameConjuctivitis);
                          }
                          Preferences.myPrefs
                              .setChecked(nameConjuctivitis, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Dolor de Cabeza',
                      image: 'assets/headache.png',
                      checked: _checked.headache,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.headache = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameHeadache);
                          } else {
                            _symptomsUser.symptoms.remove(nameHeadache);
                          }
                          Preferences.myPrefs.setChecked(nameHeadache, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Perdida de Gusto o Olfato',
                      image: 'assets/loss-of-sense-of-smell.png',
                      checked: _checked.lossSenseOfSmell,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.lossSenseOfSmell = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameLossSenseOfSmell);
                          } else {
                            _symptomsUser.symptoms.remove(nameLossSenseOfSmell);
                          }
                          Preferences.myPrefs
                              .setChecked(nameLossSenseOfSmell, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Pérdida del color en los dedos de manos opies',
                      image: 'assets/loss-of-colour-in fingers.png',
                      checked: _checked.lossColourInFingers,
                      onChanged: (bool value) {
                        setState(() {
                          _checked.lossColourInFingers = value;
                          if (value) {
                            _symptomsUser.symptoms.add(nameLossColourInFingers);
                          } else {
                            _symptomsUser.symptoms
                                .remove(nameLossColourInFingers);
                          }
                          Preferences.myPrefs
                              .setChecked(nameLossColourInFingers, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                        symptom: 'Dificultad para Respirar',
                        image: 'assets/difficulty-breathing.png',
                        checked: _checked.difficultyBreathing,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.difficultyBreathing = value;
                            if (value) {
                              _symptomsUser.symptoms
                                  .add(namedifficultyBreathing);
                            } else {
                              _symptomsUser.symptoms
                                  .remove(namedifficultyBreathing);
                            }
                            Preferences.myPrefs
                                .setChecked(namedifficultyBreathing, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Dolor o presión en el pecho',
                        image: 'assets/chest-pain-or-pressure.png',
                        checked: _checked.chestPainOrPressure,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.chestPainOrPressure = value;
                            if (value) {
                              _symptomsUser.symptoms
                                  .add(namechestPainOrPressure);
                            } else {
                              _symptomsUser.symptoms
                                  .remove(namechestPainOrPressure);
                            }
                            Preferences.myPrefs
                                .setChecked(namechestPainOrPressure, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Incapacidad para hablar o moverse',
                        image: 'assets/inability-to speak.png',
                        checked: _checked.inabilityToSpeak,
                        onChanged: (bool value) {
                          setState(() {
                            _checked.inabilityToSpeak = value;
                            if (value) {
                              _symptomsUser.symptoms.add(nameinabilityToSpeak);
                            } else {
                              _symptomsUser.symptoms
                                  .remove(nameinabilityToSpeak);
                            }
                            Preferences.myPrefs
                                .setChecked(nameinabilityToSpeak, value);
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
