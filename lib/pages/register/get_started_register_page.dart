import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/preferences_form.dart';

class RegisterPage extends StatelessWidget {
  final User newUser = User();
  static final PreferencesForm con = PreferencesForm();
  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

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
                  MyUser.mine.saveMyUser(newUser).then((value) {
                    print('Cambiando pantallas');
                    Navigator.pushNamed(context, '/');
                  }).catchError((error) {
                    print(error);
                  });
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
