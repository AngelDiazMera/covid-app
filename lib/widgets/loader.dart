import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16),
              width: 32,
              height: 32,
              child: SpinKitSquareCircle(
                color: applicationColors['lila'],
                size: 28,
              ),
            ),
            Text(
              'Cargando...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ],
    );
  }
}
