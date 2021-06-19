import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/symptom.dart';
import 'package:persistencia_datos/widgets/covid_know_more.dart';
import 'package:persistencia_datos/widgets/symptoms_card.dart';
import 'package:persistencia_datos/widgets/view_more_title.dart';

List symptoms = <Symptom>[
  Symptom(
    asset: '',
    name: 'Fiebre',
    description: 'Aumento de la temperatura corporal promedio (37 °C)',
  ),
  Symptom(
    asset: '',
    name: 'Tos seca',
    description: 'Tos que no produce flema ni moco',
  ),
  Symptom(
    asset: '',
    name: 'Cansancio',
    description: 'Poca energía y un fuerte deseo de dormir',
  ),
  Symptom(
    asset: '',
    name: 'Dolor corporal',
    description: 'Malestar o dolor de cabeza y corporal',
  ),
  Symptom(
    asset: '',
    name: 'Pérdida de sentidos',
    description: 'Pérdida del sentido del olfato o gusto',
  ),
];

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






// Table(
//   children: [
//     TableRow(children: [
//       _TableRowData(icon: Icons.thermostat_outlined, label: '37.6'),
//       _TableRowData(icon: Icons., label: '27-Nov-2000'),
//     ]),
//     TableRow(children: [
//       _TableRowData(icon: Icons.thermostat_outlined, label: '37.6'),
//       _TableRowData(icon: Icons.cake, label: '27-Nov-2000'),
//     ]),
//   ],
// ),
// SizedBox(height: 5),

// class _TableRowData extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const _TableRowData({Key key, @required this.icon, @required this.label})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon),
//         SizedBox(width: 5),
//         Text(
//           label,
//           style: TextStyle(fontSize: 16),
//         )
//       ],
//     );
//   }
// }
