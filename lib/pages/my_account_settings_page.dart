import 'package:flutter/material.dart';

import 'package:persistencia_datos/models/user.dart';

import 'package:persistencia_datos/widgets/preferences_form.dart';
import 'package:persistencia_datos/widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  final User newUser;

  const SettingsPage({Key key, @required this.newUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.only(top: 110),
          children: _drawSettingsBody(context),
        ),
        SettingsHeader(newUser: this.newUser),
      ],
    );
  }

  List<Widget> _drawSettingsBody(BuildContext context) {
    return <Widget>[
      PreferencesForm(
        horizontalMargin: 15,
        newUser: this.newUser,
      ),
      SizedBox(height: 35),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          children: [
            SizedBox(width: 15),
            Icon(Icons.work,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white30
                    : Colors.black38),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Universidad Politécnica de Pachuca',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white30
                        : Colors.black38),
              ),
            )
          ],
        ),
      )
    ];
  }
}
