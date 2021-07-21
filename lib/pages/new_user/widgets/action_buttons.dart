import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double marginTop = MediaQuery.of(context).size.height - 75;
    // Draw the buttons 'Ingresar' and 'Registrarme'
    // Their actions just push to the stablished route
    return Positioned(
      top: marginTop,
      child: Container(
        // Width of the screen with padding
        width: MediaQuery.of(context).size.width - 70,
        margin: EdgeInsets.symmetric(horizontal: 35),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/signin');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  applicationColors['medium_purple'],
                ),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                    applicationColors['font_dark']),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                        width: 2, color: applicationColors['input_light']),
                  ),
                ),
              ),
              child: const Text("Ingresar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    applicationColors['input_light']),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    applicationColors['medium_purple']),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: const Text("Registrarme"),
            ),
          ],
        ),
      ),
    );
  }
}
