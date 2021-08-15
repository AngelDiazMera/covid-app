import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class CheckBoxListTile extends StatefulWidget {
  final String symptom;
  final String image;
  final bool checked;
  final void Function(bool?) onChanged;

  CheckBoxListTile({
    Key? key,
    required this.symptom,
    required this.image,
    required this.checked,
    required this.onChanged,
  }) : super(key: key);
  @override
  _CheckBoxListTile createState() => _CheckBoxListTile();
}

class _CheckBoxListTile extends State<CheckBoxListTile> {
  Color? _color;
  @override
  Widget build(BuildContext context) {
    if (widget.checked == true) {
      _color = Theme.of(context).brightness == Brightness.dark
          ? applicationColors['lila']
          : applicationColors['light_purple'];
    } else {
      _color = Theme.of(context).brightness == Brightness.dark
          ? applicationColors['background_dark_2']
          : Colors.black45;
    }

    return CheckboxListTile(
      title: Text(widget.symptom),
      secondary: Image(
        image: AssetImage(widget.image),
        width: 35,
        height: 35,
      ),
      controlAffinity: ListTileControlAffinity.platform,
      value: widget.checked,
      onChanged: widget.onChanged,
      activeColor: _color,
      checkColor: Colors.white,
    );
  }
}
