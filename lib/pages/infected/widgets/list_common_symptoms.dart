import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';

class ListCommonSymptomPage extends StatefulWidget {
  @override
  _ListCommonSymptomPageState createState() => _ListCommonSymptomPageState();
}

class _ListCommonSymptomPageState extends State<ListCommonSymptomPage> {
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
                    ),
                    CheckBoxListTile(
                      symptom: 'Tos Seca',
                      image: 'assets/dry-cough.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Cansancio',
                      image: 'assets/fatigue.png',
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
