import 'package:flutter/material.dart';
import 'package:persistencia_datos/pages/login/widgets/login_form.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/violet_background.dart';

class LoginPage extends StatelessWidget {
  final User newUser = User();
  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    // Separation between title and form
    double separation = 25;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          VioletBackground(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: formMargin),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Ingresa con tu cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: separation),
                  Container(
                    constraints: BoxConstraints(maxHeight: 250, minHeight: 100),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/facemask_girl.png'))),
                  ),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
