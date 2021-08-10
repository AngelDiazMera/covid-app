import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/covid/widgets/recomendation_covid_list.dart';

class RecomendationCovidPage extends StatefulWidget {
  @override
  _RecomendationCovidState createState() => _RecomendationCovidState();
}

class _RecomendationCovidState extends State<RecomendationCovidPage> {
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
                    RecommendationsCovidList(
                      title: 'Manténgase en contacto con su médico',
                      recomendation:
                          'Llame antes de recibir atención médica. Asegúrese de obtener atención médica si tiene problemas para respirar o tiene algún signo de advertencia de emergencia.',
                      asset: 'assets/first_aid_kit.png',
                    ),
                    RecommendationsCovidList(
                      title: 'Utiliza mascarilla',
                      recomendation:
                          'Evita contagiar a otras personas, manten una distancia de seguridad.',
                      asset: 'assets/face_mask.png',
                    ),
                    RecommendationsCovidList(
                      title: 'Manténgase alejado de otras personas',
                      recomendation:
                          'En la medida de lo posible, permanezca en una determinada habitación y alejado de otras personas y mascotas en su casa.',
                      asset: 'assets/door_delivery.png',
                    ),
                    RecommendationsCovidList(
                      title: 'Limpie y desinfecte',
                      recomendation:
                          'Superficies de contacto frecuente en las áreas comunes.',
                      asset: 'assets/disinfect.png',
                    ),
                    RecommendationsCovidList(
                      title: 'Evite aglomeraciones o espacios cerrados',
                      recomendation:
                          'Restriguen la actividad social y los encuentros con grupos de personas. ',
                      asset: 'assets/no_group.png',
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
