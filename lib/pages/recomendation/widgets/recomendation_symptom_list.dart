import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class RecommendationsList extends StatefulWidget {
  final String title;
  final String recomendation;
  final String asset;

  RecommendationsList({
    Key? key,
    required this.title,
    required this.recomendation,
    required this.asset,
  }) : super(key: key);
  @override
  _RecommendationsList createState() => _RecommendationsList();
}

class _RecommendationsList extends State<RecommendationsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? applicationColors['background_dark_2']
            : applicationColors['background_light_2'],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 15)
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85 / 2),
              image: DecorationImage(image: AssetImage(widget.asset)),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : Colors.black12,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? applicationColors['lila']
                        : applicationColors['light_purple'],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  widget.recomendation,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
