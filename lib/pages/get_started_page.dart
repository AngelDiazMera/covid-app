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
          SizedBox(height: 70),
          Text(
            'Bienvenido',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
          SizedBox(height: 15),
          Text(
            'En esta aplicación podrás tener certeza de aquellos lugares en los que permaneciste y existió un contagio registrado de Covid-19.',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
