import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final double size;
  final bool isElevated;

  const AvatarImage({Key key, @required this.size, this.isElevated = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/guy_health.png')),
        color: Color.fromRGBO(239, 183, 97, 1),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: this.isElevated
            ? [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 0, blurRadius: 15),
              ]
            : null,
      ),
    );
  }
}
