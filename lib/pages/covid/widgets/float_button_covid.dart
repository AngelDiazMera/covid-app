import 'package:flutter/material.dart';

class FloatButtonPage extends StatefulWidget {
  @override
  _FloatButtonPageState createState() => _FloatButtonPageState();
}

class _FloatButtonPageState extends State<FloatButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 40,
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            child: Icon(Icons.done),
            backgroundColor: Color.fromRGBO(53, 66, 235, 1),
            onPressed: () {},
          ),
        ));
  }
}
