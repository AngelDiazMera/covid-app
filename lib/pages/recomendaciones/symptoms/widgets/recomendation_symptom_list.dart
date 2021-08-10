import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class RecommendationsList extends StatefulWidget {
  final String title;
  final String recomendation;
  final String asset;

  RecommendationsList({Key key, this.title, this.recomendation, this.asset})
      : super(key: key);
  @override
  _RecommendationsList createState() => _RecommendationsList();
}

class _RecommendationsList extends State<RecommendationsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      margin: EdgeInsets.only(top: 15, bottom: 15),
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
            margin: EdgeInsets.all(15),
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
          Container(
            margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
            width: 200,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? applicationColors['lila']
                          : applicationColors['light_purple'],
                    ),
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
          )
        ],
      ),
    );
  }
}
