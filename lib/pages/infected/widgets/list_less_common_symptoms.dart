import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/models/symptom_register.dart';
import 'package:persistencia_datos/services/auth/my_symptom.dart';

class ListLessCommonSymptomPage extends StatefulWidget {
  @override
  _ListLessCommonSymptomPageState createState() =>
      _ListLessCommonSymptomPageState();
}

class _ListLessCommonSymptomPageState extends State<ListLessCommonSymptomPage> {
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
                      symptom: 'Dolor de Garganta',
                      image: 'assets/sore_throat.png',
                      checked: _symptom.soreThroat,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.soreThroat = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems.add(Symptom(soreThroat: value));
                            }
                          });
                          Preferences.myPrefs.setSymptom('sore_throat', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Diarrea',
                      image: 'assets/diarrhoea.png',
                      checked: _symptom.diarrhoea,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.diarrhoea = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems.add(Symptom(diarrhoea: value));
                            }
                          });
                          Preferences.myPrefs.setSymptom('diarrhoea', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Conjuntivitis',
                      image: 'assets/conjuctivitis.png',
                      checked: _symptom.conjuctivitis,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.conjuctivitis = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems.add(Symptom(conjuctivitis: value));
                            }
                          });
                          Preferences.myPrefs
                              .setSymptom('conjuctivitis', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Dolor de Cabeza',
                      image: 'assets/headache.png',
                      checked: _symptom.headache,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.headache = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems.add(Symptom(headache: value));
                            }
                          });
                          Preferences.myPrefs.setSymptom('headache', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Perdida de Gusto o Olfato',
                      image: 'assets/loss-of-sense-of-smell.png',
                      checked: _symptom.lossSenseOfSmell,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.lossSenseOfSmell = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems
                                  .add(Symptom(lossSenseOfSmell: value));
                            }
                          });
                          Preferences.myPrefs
                              .setSymptom('loss_of_sense_of_smell', value);
                        });
                      },
                    ),
                    CheckBoxListTile(
                      symptom: 'Pérdida del color en los dedos de manos opies',
                      image: 'assets/loss-of-colour-in fingers.png',
                      checked: _symptom.lossColourInFingers,
                      onChanged: (bool value) {
                        setState(() {
                          _symptom.lossColourInFingers = value;
                          _symptom.toJson().forEach((key, value) {
                            if (value) {
                              selectedItems
                                  .add(Symptom(lossColourInFingers: value));
                            }
                          });
                          Preferences.myPrefs
                              .setSymptom('loss_of_colour_in_fingers', value);
                        });
                      },
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
}
