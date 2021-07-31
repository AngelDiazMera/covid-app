import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/recomendaciones/widgets/settings_header_recom.dart';
import 'package:persistencia_datos/pages/recomendaciones/widgets/recomendation.dart';
import 'package:persistencia_datos/pages/infected/widgets/list_severe_symptoms.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);
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
        child: RecomendacionesPage(), //Sustituir
      ),
    ];
  }
}
