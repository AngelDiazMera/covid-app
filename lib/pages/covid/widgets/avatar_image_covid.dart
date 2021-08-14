import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final double size;
  final bool isElevated;
  final String infection;

  const AvatarImage(
      {Key? key,
      required this.size,
      this.isElevated = true,
      this.infection = 'Bajo riesgo'})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(infection == 'En riesgo'
                ? 'assets/guy_sick.png'
                : 'assets/guy_health.png')),
        // color: Color.fromRGBO(239, 183, 97, 1),
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