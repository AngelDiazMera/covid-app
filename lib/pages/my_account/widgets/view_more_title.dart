import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ViewMoreTitle extends StatelessWidget {
  final String title;
  final Function? onPressed;

  const ViewMoreTitle({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode? themeMode = EasyDynamicTheme.of(context).themeMode;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          this.onPressed != null
              ? TextButton(
                  onPressed: onPressed as void Function()?,
                  child: Text(
                    'Ver todos',
                    style: TextStyle(
                        color: themeMode.toString() == 'ThemeMode.dark'
                            ? Colors.white54
                            : Colors.black45),
                  ),
                  style: TextButton.styleFrom(primary: Colors.black26),
                )
              : Container(),
        ],
      ),
    );
  }
}
