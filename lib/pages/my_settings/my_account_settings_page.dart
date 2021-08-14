import 'package:covserver/models/user.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:flutter/material.dart';
import 'package:covserver/pages/my_settings/widgets/settings_form.dart';

import 'package:covserver/pages/my_settings/widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Future<User?> _updatePreferences(
      String name, String lastName, String email, String password) async {
    User? updatedUser = await updateUser(name, lastName, email, password);
    return updatedUser;
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
          doneButtonLabel: 'Hecho',
          name: 'Preferencias',
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
          ],
        ),
      )
    ];
  }
}
