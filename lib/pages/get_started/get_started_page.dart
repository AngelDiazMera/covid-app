import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 300, minHeight: 100),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/man_with_mask.png'))),
          ),
          SizedBox(height: 30),
          Text(
            'CovServer',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
          SizedBox(height: 15),
          Text(
            'Tu nuevo asistente de observación de infectados por Covid-19',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
