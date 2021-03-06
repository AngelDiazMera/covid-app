import 'package:covserver/pages/my_account/widgets/recommendations_list.dart';
import 'package:flutter/material.dart';

import 'package:covserver/data/symptoms.dart';
import 'package:covserver/pages/my_account/widgets/covid_know_more.dart';
import 'package:covserver/pages/my_account/widgets/symptoms_card.dart';
import 'package:covserver/pages/my_account/widgets/view_more_title.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        onPressed: () => launchURL(
            'https://www.who.int/es/news-room/q-a-detail/coronavirus-disease-covid-19'),
      ),
      Container(
        height: 145,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _drawSymptoms() as List<Widget>,
        ),
      ),
      ViewMoreTitle(title: 'Enlaces de interés'),
      SizedBox(
        height: 180,
        child: CarouselSlider(
          items: <Widget>[
            CovidKnowMore(
                asset: "assets/facemask_guy.png",
                url:
                    "https://www.who.int/es/emergencies/diseases/novel-coronavirus-2019",
                description: "Quédate en casa para combatir al coronavirus"),
            CovidKnowMore(
                asset: "assets/mexico.png",
                url: "https://coronavirus.gob.mx/",
                description: "Portal informativo nacional"),
            CovidKnowMore(
                asset: "assets/conacyt.png",
                url: "https://datos.covid-19.conacyt.mx/#DOView",
                description: "Portal informativo CONACYT"),
            CovidKnowMore(
                asset: "assets/facemask_guy.png",
                url:
                    "https://www.zeit.de/wissen/gesundheit/2020-11/coronavirus-aerosols-infection-risk-hotspot-interiors?utm_referrer=https%3A%2F%2Fwww.rtve.es%2F",
                description: "Herramienta de probabilidad de contagios"),
          ],
          options: CarouselOptions(autoPlay: true),
        ),
      ),
      ViewMoreTitle(
        title: 'Recomendaciones',
        onPressed: () => launchURL(
            'https://www.who.int/es/emergencies/diseases/novel-coronavirus-2019/advice-for-public/when-and-how-to-use-masks'),
      ),
      RecommendationsList(),
      SizedBox(height: 85)
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
