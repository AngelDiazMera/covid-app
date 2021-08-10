import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/covid/widgets/recomendation_covid.dart';
import 'package:persistencia_datos/pages/recomendaciones/settings_header_recom.dart';

class CovidPage extends StatelessWidget {
  const CovidPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(top: 80),
            children: _drawSettingsBody(context),
          ),
          SettingsHeader(),
        ],
      ),
    );
  }

  List<Widget> _drawSettingsBody(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: RecomendationCovidPage(), //Sustituir
      ),
    ];
  }
}
