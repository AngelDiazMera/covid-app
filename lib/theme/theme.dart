import 'package:flutter/material.dart';

Map<String, Color> applicationColors = <String, Color>{
  // Dark theme color palette
  'background_dark_1': Color.fromRGBO(46, 46, 46, 1),
  'background_dark_2': Color.fromRGBO(79, 79, 79, 1),
  'input_dark': Colors.white24,
  'font_dark': Color.fromRGBO(245, 245, 245, 1),
  'yellow_dark': Color.fromRGBO(239, 183, 97, 1),
  // Light theme color palette
  'background_light_1': Color.fromRGBO(250, 250, 250, 1),
  'background_light_2': Color.fromRGBO(255, 255, 255, 1),
  'input_light': Color.fromRGBO(235, 235, 235, 1),
  'font_light': Color.fromRGBO(38, 38, 38, 1),
  'yellow_light': Color.fromRGBO(252, 227, 196, 1),
  //Common
  'dark_purple': Color.fromRGBO(53, 66, 235, 1),
  'medium_purple': Color.fromRGBO(57, 72, 235, 1),
  'light_purple': Color.fromRGBO(99, 109, 240, 1),
  'lila': Color.fromRGBO(129, 137, 243, 1),
};

var lightThemeData = new ThemeData(
    primaryColor: Colors.blue,
    textTheme: new TextTheme(
        button: TextStyle(color: Colors.white70),
        bodyText2: TextStyle(color: applicationColors['font_light'])),
    brightness: Brightness.light,
    accentColor: Colors.blue);

var darkThemeData = ThemeData(
    primaryColor: Colors.blue,
    textTheme: new TextTheme(button: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
    accentColor: Colors.blue);
