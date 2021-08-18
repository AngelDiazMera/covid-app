import 'package:covserver/pages/recomendation/widgets/recomendation_symptom_list.dart';
import 'package:flutter/material.dart';

class RecommendationPageBody extends StatefulWidget {
  @override
  _RecommendationPageBodyState createState() => _RecommendationPageBodyState();
}

class _RecommendationPageBodyState extends State<RecommendationPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(right: 25, left: 25, top: 15),
          child: Column(
            children: [
              RecommendationsList(
                title: 'Lavarse las manos',
                recomendation:
                    'Con agua y jabón por un tiempo mínimo de 40 a 60 segundos o bien usar un gel desinfectante a base de alcohol al 70%.',
                asset: 'assets/wash-hands.png',
              ),
              RecommendationsList(
                title: 'Mantener el distanciamiento físico',
                recomendation:
                    'Mantén una distancia de seguridad con personas que tosan o estornuden.',
                asset: 'assets/social-distancing.png',
              ),
              RecommendationsList(
                title: 'Adoptar medidas de higiene respiratorias',
                recomendation:
                    'Como toser o estornudar, cubrirse la boca y la nariz con el codo flexionado o con un pañuelo. Tire el pañuelo inmediatamente y lávese las manos.',
                asset: 'assets/cough.png',
              ),
              RecommendationsList(
                title: 'Quédate en casa si sus síntomas lo permiten',
                recomendation:
                    'Esto te ayudará a protegerte y a proteger a otras personas de posibles infecciones por el coronavirus COVID-19 u otros virus',
                asset: 'assets/stay-at-home.png',
              ),
              RecommendationsList(
                title: 'Busca atención médica',
                recomendation:
                    'En caso de que tengas fiebre, tos o dificultad para respirar',
                asset: 'assets/first_aid_kit.png',
              ),
            ],
          ),
        )
      ],
    );
  }
}
