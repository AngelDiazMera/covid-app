import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/symptoms_user.dart';
import 'package:persistencia_datos/pages/recomendation/recomedaciones_symptom_page.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';
import 'package:persistencia_datos/pages/infected/widgets/checked_value.dart';
import 'package:persistencia_datos/services/api/requests_symptom.dart';
import 'package:persistencia_datos/services/auth/my_checked.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';
import 'package:persistencia_datos/widgets/floatbutto_widget.dart';
import 'package:persistencia_datos/widgets/date_picker_form.dart';
import 'checked_value.dart';
import 'package:intl/intl.dart';

class SymptomForm extends StatefulWidget {
  @override
  _SymptomFormState createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomForm> {
  SymptomsUser _symptomsUser = SymptomsUser();
  CheckedSymptoms checkedSymptoms = CheckedSymptoms();
  bool loading = false;
  bool connectionFailed = false;
  String fechaSymptom = '';
  List<String> symptoms = [];
  final _controllerSymptom = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loadPreferencesSymptoms();
    _setSymptom();
  }

  Future<bool> _makeInfected() async {
    setState(() => loading = false);
    bool areSymSaved = await MySymptom.mine.saveSymptoms(_symptomsUser);
    if (!areSymSaved) {
      setState(() {
        loading = false;
        connectionFailed = true;
      });
      return false;
    }
  }

  Future<void> _setSymptom() async {
    CheckedSymptoms checkedVal = await MyChecked.mine.getMyChecked();
    setState(() {
      checkedSymptoms = checkedVal;
    });
  }

  _loadPreferencesSymptoms() async {
    SymptomsUser tempSymptom = await MySymptom.mine.getMySymptom();
    setState(() {
      _symptomsUser = tempSymptom;
      symptoms = tempSymptom.symptoms;
    });
  }

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    // Inputs of the form
    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Comentarios',
            'value': _symptomsUser.remarks,
            'keyboard': TextInputType.text,
            'onChanged': _remarksOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.comment
      },
    ];

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
                        checked: checkedSymptoms.fever,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.fever = value;
                            if (value) {
                              symptoms.add(checkedSymptoms.nameFever);
                            } else {
                              symptoms.remove(checkedSymptoms.nameFever);
                            }
                            print(symptoms);
                            Preferences.myPrefs
                                .setChecked(checkedSymptoms.nameFever, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Tos Seca',
                        image: 'assets/dry-cough.png',
                        checked: checkedSymptoms.dryCough,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.dryCough = value;
                            if (value) {
                              symptoms.add(checkedSymptoms.nameDryCough);
                            } else {
                              symptoms.remove(checkedSymptoms.nameDryCough);
                            }
                            print(symptoms);
                            Preferences.myPrefs.setChecked(
                                checkedSymptoms.nameDryCough, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Cansancio',
                        image: 'assets/fatigue.png',
                        checked: checkedSymptoms.fatigue,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.fatigue = value;
                            if (value) {
                              symptoms.add(checkedSymptoms.nameFatigue);
                            } else {
                              symptoms.remove(checkedSymptoms.nameFatigue);
                            }
                            print(symptoms);
                            Preferences.myPrefs
                                .setChecked(checkedSymptoms.nameFatigue, value);
                          });
                        }),
                    CheckBoxListTile(
                      symptom: 'Dolor de Garganta',
                      image: 'assets/sore_throat.png',
                      checked: checkedSymptoms.soreThroat,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.soreThroat = value;
                          if (value) {
                            symptoms.add(checkedSymptoms.nameSoreThroat);
                          } else {
                            symptoms.remove(checkedSymptoms.nameSoreThroat);
                          }
                          print(symptoms);
                          Preferences.myPrefs.setChecked(
                              checkedSymptoms.nameSoreThroat, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Diarrea',
                      image: 'assets/diarrhoea.png',
                      checked: checkedSymptoms.diarrhoea,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.diarrhoea = value;
                          if (value) {
                            symptoms.add(checkedSymptoms.nameDiarrhoea);
                          } else {
                            symptoms.remove(checkedSymptoms.nameDiarrhoea);
                          }
                          print(symptoms);
                          Preferences.myPrefs
                              .setChecked(checkedSymptoms.nameDiarrhoea, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Conjuntivitis',
                      image: 'assets/conjuctivitis.png',
                      checked: checkedSymptoms.conjuctivitis,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.conjuctivitis = value;
                          if (value) {
                            symptoms.add(checkedSymptoms.nameConjuctivitis);
                          } else {
                            symptoms.remove(checkedSymptoms.nameConjuctivitis);
                          }
                          print(symptoms);
                          Preferences.myPrefs.setChecked(
                              checkedSymptoms.nameConjuctivitis, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Dolor de Cabeza',
                      image: 'assets/headache.png',
                      checked: checkedSymptoms.headache,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.headache = value;
                          if (value) {
                            symptoms.add(checkedSymptoms.nameHeadache);
                          } else {
                            symptoms.remove(checkedSymptoms.nameHeadache);
                          }
                          print(symptoms);
                          Preferences.myPrefs
                              .setChecked(checkedSymptoms.nameHeadache, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Perdida de Gusto o Olfato',
                      image: 'assets/loss-of-sense-of-smell.png',
                      checked: checkedSymptoms.lossSenseOfSmell,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.lossSenseOfSmell = value;
                          if (value) {
                            symptoms.add(checkedSymptoms.nameLossSenseOfSmell);
                          } else {
                            symptoms
                                .remove(checkedSymptoms.nameLossSenseOfSmell);
                          }
                          print(symptoms);
                          Preferences.myPrefs.setChecked(
                              checkedSymptoms.nameLossSenseOfSmell, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Pérdida del color en los dedos de manos opies',
                      image: 'assets/loss-of-colour-in fingers.png',
                      checked: checkedSymptoms.lossColourInFingers,
                      onChanged: (bool value) {
                        setState(() {
                          checkedSymptoms.lossColourInFingers = value;
                          if (value) {
                            symptoms
                                .add(checkedSymptoms.nameLossColourInFingers);
                          } else {
                            symptoms.remove(
                                checkedSymptoms.nameLossColourInFingers);
                          }
                          print(symptoms);
                          Preferences.myPrefs.setChecked(
                              checkedSymptoms.nameLossColourInFingers, value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                        symptom: 'Dificultad para Respirar',
                        image: 'assets/difficulty-breathing.png',
                        checked: checkedSymptoms.difficultyBreathing,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.difficultyBreathing = value;
                            if (value) {
                              symptoms
                                  .add(checkedSymptoms.namedifficultyBreathing);
                            } else {
                              symptoms.remove(
                                  checkedSymptoms.namedifficultyBreathing);
                            }
                            print(symptoms);
                            Preferences.myPrefs.setChecked(
                                checkedSymptoms.namedifficultyBreathing, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Dolor o presión en el pecho',
                        image: 'assets/chest-pain-or-pressure.png',
                        checked: checkedSymptoms.chestPainOrPressure,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.chestPainOrPressure = value;
                            if (value) {
                              symptoms
                                  .add(checkedSymptoms.namechestPainOrPressure);
                            } else {
                              symptoms.remove(
                                  checkedSymptoms.namechestPainOrPressure);
                            }
                            print(symptoms);
                            Preferences.myPrefs.setChecked(
                                checkedSymptoms.namechestPainOrPressure, value);
                          });
                        }),
                    CheckBoxListTile(
                        symptom: 'Incapacidad para hablar o moverse',
                        image: 'assets/inability-to speak.png',
                        checked: checkedSymptoms.inabilityToSpeak,
                        onChanged: (bool value) {
                          setState(() {
                            checkedSymptoms.inabilityToSpeak = value;
                            if (value) {
                              symptoms
                                  .add(checkedSymptoms.nameinabilityToSpeak);
                            } else {
                              symptoms
                                  .remove(checkedSymptoms.nameinabilityToSpeak);
                            }
                            print(symptoms);
                            Preferences.myPrefs.setChecked(
                                checkedSymptoms.nameinabilityToSpeak, value);
                          });
                        }),
                    SizedBox(height: 20),
                    DateWidget(
                        controller: _controllerSymptom,
                        selectDate: _selectDateSymptoms),
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
                ),
              ),
            ),
          )
        ],
      ),
    ]);
  }

  void _signSymptoms() {
    SymptomsUser newSymptom = SymptomsUser(
        symptoms: symptoms,
        symptomsDate: _symptomsUser.symptomsDate,
        remarks: _symptomsUser.remarks);
    MySymptom.mine.saveSymptoms(newSymptom);
  }

  void _remarksOnChange(String value) {
    setState(() {
      _symptomsUser.remarks = value;
    });
  }

  Widget buildButton() => ButtonWidget(onClicked: () async {
        _signSymptoms();
        _makeInfected();
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
