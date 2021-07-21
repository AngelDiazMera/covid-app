import 'package:flutter/material.dart';

import 'package:persistencia_datos/data/symptoms.dart';
import 'package:persistencia_datos/pages/my_account/widgets/covid_know_more.dart';
import 'package:persistencia_datos/pages/my_account/widgets/covid_know_more_conacyt.dart';
import 'package:persistencia_datos/pages/my_account/widgets/covid_know_more_mx.dart';
import 'package:persistencia_datos/pages/my_account/widgets/covid_prediction.dart';
import 'package:persistencia_datos/pages/my_account/widgets/symptoms_card.dart';
import 'package:persistencia_datos/pages/my_account/widgets/view_more_title.dart';

class MyAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _drawBody(),
    );
  }

  _drawBody() {
    return [
      SizedBox(height: 235),
      ViewMoreTitle(
        title: 'Síntomas',
        onPressed: () {},
      ),
      Container(
        height: 145,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _drawSymptoms(),
        ),
      ),
      SizedBox(height: 20),
      CovidKnowMore(),
      CovidKnowMoreMX(),
      CovidKnowMoreConacyt(),
      CovidPrediction(),
    ];
  }

  List _drawSymptoms() {
    List<Widget> symptomsCards = [];
    symptoms.forEach((symptom) {
      symptomsCards.add(SymptomsCard(symptom: symptom));
    });
    return symptomsCards;
  }
}
