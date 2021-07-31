import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';

class ListLessCommonSymptomPage extends StatefulWidget {
  @override
  _ListLessCommonSymptomPageState createState() =>
      _ListLessCommonSymptomPageState();
}

class _ListLessCommonSymptomPageState extends State<ListLessCommonSymptomPage> {
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
                    ),
                    CheckBoxListTile(
                      symptom: 'Diarrea',
                      image: 'assets/diarrhoea.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Conjuntivitis',
                      image: 'assets/conjuctivitis.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Dolor de Cabeza',
                      image: 'assets/headache.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Perdida de Gusto o Olfato',
                      image: 'assets/loss-of-sense-of-smell.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Pérdida del color en los dedos de manos opies',
                      image: 'assets/loss-of-colour-in fingers.png',
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
