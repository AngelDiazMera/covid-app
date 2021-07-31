import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/infected/widgets/checkbox_list_tile_symptoms.dart';

class ListSevereSymptomPage extends StatefulWidget {
  @override
  _ListSevereSymptomPageState createState() => _ListSevereSymptomPageState();
}

class _ListSevereSymptomPageState extends State<ListSevereSymptomPage> {
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
                    ),
                    CheckBoxListTile(
                      symptom: 'Dolor o presión en el pecho',
                      image: 'assets/chest-pain-or-pressure.png',
                    ),
                    CheckBoxListTile(
                      symptom: 'Incapacidad para hablar o moverse',
                      image: 'assets/inability-to speak.png',
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
