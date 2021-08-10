import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/pages/infected/widgets/checked_value.dart';

class CheckBoxListTile extends StatefulWidget {
  final String symptom;
  final String image;
  final bool checked;
  final Function onChanged;

  CheckBoxListTile(
      {Key key, this.symptom, this.image, this.checked, this.onChanged})
      : super(key: key);
  @override
  _CheckBoxListTile createState() => _CheckBoxListTile();
}

class _CheckBoxListTile extends State<CheckBoxListTile> {
  Color _color;
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
