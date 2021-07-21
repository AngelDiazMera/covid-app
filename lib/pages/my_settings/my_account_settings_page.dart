import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/my_settings/widgets/settings_form.dart';

import 'package:persistencia_datos/pages/my_settings/widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  bool _updatePreferences() {
    // TODO: Implement the function to update the user
    // MyUser.mine.saveMyUser(newUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.only(top: 110),
          children: _drawSettingsBody(context),
        ),
        SettingsHeader(
          doneCallback: _updatePreferences,
        ),
      ],
    );
  }

  List<Widget> _drawSettingsBody(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: SettingsForm(),
      ),
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
                'Aquí debe aparecer una lista de los lugares donde trabaja y puede eliminarse de cada uno',
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
