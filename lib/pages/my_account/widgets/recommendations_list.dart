import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({Key? key}) : super(key: key);

  Widget buildImage(BuildContext context, double size, String asset) =>
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? applicationColors['background_dark_2']
                : applicationColors['background_light_2'],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 15)
            ]),
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(asset), fit: BoxFit.contain)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const config = [
      'assets/recommendations/distance.png',
      'assets/recommendations/medical-assistance.png',
      'assets/recommendations/mouth-mask.png',
      'assets/recommendations/stay-home.png',
      'assets/recommendations/washing-hands.png',
    ];

    double cardSize =
        (MediaQuery.of(context).size.width - 70) / config.length - 10;

    List<Widget> recBuilder =
        config.map((asset) => buildImage(context, cardSize, asset)).toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: recBuilder,
      ),
    );
  }
}
