import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/widgets/recomendatio_list.dart';

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
                      title: 'Lavate las manos con frecuencia',
                      recomendation:
                          'Usa agua y jabón o un desinfectante de manos a base de alcohol.',
                      asset: 'assets/washing-hands.png',
                    ),
                    RecommendationsList(
                      title: 'Sana distancia',
                      recomendation:
                          'Mantén una distancia de seguridad con personas que tosan o estornuden',
                      asset: 'assets/social-distancing.png',
                    ),
                    RecommendationsList(
                      title: 'Utiliza mascarilla',
                      recomendation:
                          'Cuando no sea posible mantener el distanciamiento físico',
                      asset: 'assets/face_mask.png',
                    ),
                    RecommendationsList(
                      title: 'Cuando tosas o estornudes',
                      recomendation:
                          'Cúbrete la nariz y la boca con el codo flexionado o con un pañuelo',
                      asset: 'assets/cough.png',
                    ),
                    RecommendationsList(
                      title: 'Quédate en casa',
                      recomendation: 'Si te cuidas tú, nos cuidamos todos',
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
