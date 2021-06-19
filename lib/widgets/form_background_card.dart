import 'package:flutter/material.dart';

class FormBackgroundCard extends StatelessWidget {
  final double horizontalMargin;
  final Widget child;

  const FormBackgroundCard(
      {Key key, @required this.horizontalMargin, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double whiteBoxMargin = 0;
    return Stack(
      fit: StackFit.loose,
      children: [
        Positioned(
          top: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 395,
              width:
                  MediaQuery.of(context).size.width - whiteBoxMargin * 2 - 30,
              margin: EdgeInsets.symmetric(
                  vertical: 35, horizontal: whiteBoxMargin),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(250, 250, 250, 0.7),
                    Color.fromRGBO(250, 250, 250, 0.5)
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 0, blurRadius: 15)
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
          child: Form(
            child: child,
          ),
        )
      ],
    );
  }
}
