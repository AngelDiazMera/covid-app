import 'package:flutter/material.dart';

class VioletBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(57, 72, 235, 1),
            Color.fromRGBO(99, 109, 240, 1),
          ],
        ),
      ),
    );
  }
}
