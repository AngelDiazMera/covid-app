import 'package:covserver/models/user.dart';
import 'package:covserver/pages/my_settings/widgets/alert_update.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/utils/hash_value.dart';
import 'package:covserver/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:covserver/pages/my_settings/widgets/settings_form.dart';

import 'package:covserver/widgets/settings_header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? _user; // User of the form

  @override
  void initState() {
    // Once user is set, the inputs are assigned and stop loading
    _setUser();
    super.initState();
  }

  // Set the user from preferences
  Future<void> _setUser() async {
    User user = await MyUser.mine.getMyUser();
    setState(() {
      _user = new User(
          name: user.name,
          lastName: user.lastName,
          email: user.email,
          gender: user.gender);
    });
  }

  void _makeUpdate() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertUpdate(
        newUser: _user!,
        onAccepted: () async {
          User prev = await MyUser.mine.getMyUser();
          // Deep copy
          await MyUser.mine.savePrefs(new User(
              name: _user!.name!.trim().length > 0 ? _user!.name : prev.name,
              lastName: _user!.lastName!.trim().length > 0
                  ? _user!.lastName
                  : prev.lastName,
              gender:
                  _user!.gender.trim().length > 0 ? _user!.gender : prev.gender,
              email: prev.email));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null)
      return Center(
        child: Loader(),
      );

    return Stack(
      children: <Widget>[
        ListView(
          padding: EdgeInsets.only(top: 110),
          children: _drawSettingsBody(context),
        ),
        SettingsHeader(
          doneCallback: _user == null ? () {} : _makeUpdate,
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
        child: SettingsForm(
          user: _user!,
          callbacks: [
            nameOnChange,
            lastNameOnChange,
            emailOnChange,
            pswOnChange
          ],
        ),
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

  void nameOnChange(String value) {
    print('Nombre: $value');
    setState(() {
      _user!.name = value;
    });
  }

  void lastNameOnChange(String value) {
    print('Apellido: $value');
    setState(() {
      _user!.lastName = value;
    });
  }

  void emailOnChange(String value) {
    print('Email: $value');
    setState(() {
      _user!.email = value;
    });
  }

  void pswOnChange(String value) {
    print('Password: $value');
    setState(() {
      _user!.psw = value;
    });
  }
}
