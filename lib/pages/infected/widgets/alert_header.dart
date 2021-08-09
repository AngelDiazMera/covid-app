import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

class AlertHeader extends StatelessWidget {
  final bool loading;

  const AlertHeader({Key? key, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: 0,
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        height: loading ? screenHeight : screenHeight * 3 / 7,
        color: applicationColors['medium_purple']!.withOpacity(0.1),
        width: screenWidth,
        // constraints: BoxConstraints(maxHeight: screenHeight * 3 / 7),
        child: Padding(
          padding: EdgeInsets.all(35.0),
          child: AnimatedOpacity(
            curve: Curves.easeInQuart,
            opacity: loading ? 0.0 : 1.0,
            duration: Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Alerta de contagio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: applicationColors['dark_purple'],
                      height: 3),
                ),
                Text(
                  'Parece que alguien con quien posiblemente tuviste contacto se infectó con Covid-19.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, color: applicationColors['medium_purple']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
