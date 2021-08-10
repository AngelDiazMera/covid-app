import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/symptoms/widgets/recomendation_symptom_list.dart';

class RecomendacionesPage extends StatefulWidget {
  @override
  _RecomendacionesPageState createState() => _RecomendacionesPageState();
}

class _RecomendacionesPageState extends State<RecomendacionesPage> {
  @override
  Widget build(BuildContext context) {
    return new Stack(children: [
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    RecommendationsList(
                      title: 'Lavarse las manos',
                      recomendation:
                          'Con agua y jabón por un tiempo mínimo de 40 a 60 segundos o bien usar un gel desinfectante a base de alcohol al 70%.',
                      asset: 'assets/washing-hands.png',
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
                      asset: 'assets/stay-home.png',
                    ),
                    RecommendationsList(
                      title: 'Busca atención médica',
                      recomendation:
                          'En caso de que tengas fiebre, tos o dificultad para respirar',
                      asset: 'assets/first_aid_kit.png',
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
