import 'package:flutter/material.dart';
import 'package:covserver/pages/register/widgets/register_form.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/widgets/violet_background.dart';

class RegisterPage extends StatelessWidget {
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
        ],
      ),
    );
  }
}
