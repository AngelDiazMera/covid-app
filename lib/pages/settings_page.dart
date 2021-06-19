import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/preferences_form.dart';
import 'package:persistencia_datos/widgets/settings_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User newUser;
  bool loading = true;

  void _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    setState(() {
      newUser = tempUser;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.only(top: 110, right: 35, left: 35),
          children: _drawSettingsBody(),
        ),
        SettingsHeader(newUser: newUser),
      ],
    );
  }

  List<Widget> _drawSettingsBody() {
    return <Widget>[
      !loading
          ? PreferencesForm(
              newUser: newUser,
            )
          : Container(),
      SizedBox(height: 35),
      Row(
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
      )
    ];
  }
}
