import 'package:flutter/material.dart';

class VioletBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(102, 49, 167, 1),
            Color.fromRGBO(126, 56, 183, 1),
          ],
        ),
      ),
    );
  }
}
