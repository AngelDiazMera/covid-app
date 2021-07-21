import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/pages/register/widgets/register_form.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';

class RegisterPage extends StatelessWidget {
  final User newUser = User();
  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    // Separation between title and form
    double separation = 25;

    return Scaffold(
      body: SafeArea(
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
              SizedBox(height: separation),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: RegisterForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
