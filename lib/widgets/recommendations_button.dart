import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class RecommendationsButton extends StatelessWidget {
  const RecommendationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, '/recommendations'),
        child: Text(
          'Ver recomendaciones',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: applicationColors['medium_purple']),
        ),
        style: TextButton.styleFrom(
          primary: applicationColors['background_dark_2'],
        ));
  }
}
