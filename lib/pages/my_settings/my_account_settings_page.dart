import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/pages/my_settings/widgets/settings_form.dart';
import 'package:persistencia_datos/services/api/requests.dart';
import 'package:persistencia_datos/pages/my_settings/widgets/settings_header.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  bool _updatePreferences(String name, String lastName, String email, String password, User newUser) {
    bool isUpdated= (updateUser(name, lastName, email, password, newUser)) as bool;
    if (isUpdated) {
      
      return true;
    }
    return false;

    // TODO: Implement the function to update the user
    // Instructions (spanish):
    // * Actualizar el usuario a través de la api
    // * Si la actualización fue exitosa (código 200), actualizar preferencias del usuario
    // * Manejar errores
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
            
          ],
        ),
      )
    ];
  }
}
