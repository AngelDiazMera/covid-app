import 'package:flutter/material.dart';

class AlertIcon extends StatelessWidget {
  final bool loading;

  const AlertIcon({Key? key, this.loading = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 750),
      top: loading
          ? (screenHeight / 2) - (125 / 2)
          : (screenHeight * 3 / 7) - (125 / 2),
      child: Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/alert_icon.png'))),
      ),
    );
  }
}
