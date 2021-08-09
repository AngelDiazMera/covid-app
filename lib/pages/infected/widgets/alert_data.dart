import 'package:flutter/material.dart';

class AlertData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      width: screenWidth,
      height: (screenHeight * 4 / 7) - (125 / 2) - 80,
      top: (screenHeight * 3 / 7) + (125 / 2),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(
            'Juanito Pérez',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Reportó síntomas el \n30 de julio del 2020',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(child: SizedBox()),
          Text(
            'Pudo haber tenido contacto en',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5),
          Text(
            'Grupo CovServer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'El día 30 de julio del 2021 a las 07:45 p.m.',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
