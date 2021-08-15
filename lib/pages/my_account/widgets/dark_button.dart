import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class DarkButton extends StatelessWidget {
  final Function changeToDarkMode;

  const DarkButton({Key? key, required this.changeToDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode? themeMode = EasyDynamicTheme.of(context).themeMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RawMaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, '/qr');
          },
          elevation: 2.0,
          child: Icon(
            Icons.qr_code_rounded,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
        ),
        RawMaterialButton(
          onPressed: changeToDarkMode as void Function()?,
          elevation: 2.0,
          child: Transform.rotate(
            angle: themeMode.toString() != 'ThemeMode.system' ? -90 : 0,
            child: Icon(
              themeMode.toString() == 'ThemeMode.dark'
                  ? Icons.brightness_high
                  : themeMode.toString() == 'ThemeMode.light'
                      ? Icons.nightlight_round
                      : Icons.brightness_auto,
              color: Colors.white,
            ),
          ),
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
