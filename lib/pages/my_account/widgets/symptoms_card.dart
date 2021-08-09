import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';
import 'package:covserver/models/symptom.dart';

class SymptomsCard extends StatelessWidget {
  final Symptom symptom;

  const SymptomsCard({Key? key, required this.symptom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 35),
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
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : Colors.black12,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, top: 15),
            width: 165,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    symptom.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? applicationColors['lila']
                          : applicationColors['light_purple'],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  symptom.description,
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
