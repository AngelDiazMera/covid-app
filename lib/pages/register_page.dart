import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/theme/theme.dart';
import 'package:persistencia_datos/widgets/preferences_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatelessWidget {
  final User newUser = User();

  @override
  Widget build(BuildContext context) {
    double whiteBoxMargin = 15;
    double formMargin = 35;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: formMargin),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Vamos a empezar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: PreferencesForm(
                horizontalMargin: formMargin,
                isNew: true,
                newUser: newUser,
                withBackground: true,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  MyUser.mine.myUser = newUser;
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  'Registrarme',
                  style: TextStyle(fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  primary: applicationColors['font_light'],
                  backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
