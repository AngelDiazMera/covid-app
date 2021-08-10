import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class TextSymptomPage extends StatefulWidget {
  final String txt;
  TextSymptomPage({Key key, this.txt}) : super(key: key);
  @override
  _TextSymptomPageState createState() => _TextSymptomPageState();
}

class _TextSymptomPageState extends State<TextSymptomPage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.txt,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? applicationColors['lila']
            : applicationColors['light_purple'],
      ),
    );
  }
}
