import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarImage extends StatelessWidget {
  final double size;
  final bool? isElevated;
  final String? gender;

  const AvatarImage(
      {Key? key,
      required this.size,
      this.isElevated = true,
      this.gender = 'male'})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);

    String asset =
        'assets/${gender == 'female' ? 'girl' : 'guy'}_${hc.healthCondition == 'Sin riesgo' ? 'health' : 'sick'}.png';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(asset)),
        // color: Color.fromRGBO(239, 183, 97, 1),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: this.isElevated!
            ? [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 0, blurRadius: 15),
              ]
            : null,
      ),
    );
  }
}
