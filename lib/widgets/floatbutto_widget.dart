import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    @required this.onClicked,
  });

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
            onPressed: onClicked,
          ),
        ));
  }
}
