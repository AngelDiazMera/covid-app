import 'package:flutter/material.dart';
import 'package:covserver/pages/recomendation/settings_header_recom.dart';
import 'package:covserver/pages/recomendation/widgets/recomendation_symptom.dart';

import '../settings_header_recom.dart';

class SymptomPage extends StatelessWidget {
  const SymptomPage({Key? key}) : super(key: key);
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
