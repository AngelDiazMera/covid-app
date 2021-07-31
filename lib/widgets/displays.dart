import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final sintoma;
  DisplayWidget(this.sintoma);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(sintoma),
      ),
    );
  }
}
