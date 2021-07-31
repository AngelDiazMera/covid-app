import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/models/symptom_register.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';

class CheckBoxListTile extends StatefulWidget {
  final String symptom;
  final String image;

  CheckBoxListTile({Key key, this.symptom, this.image}) : super(key: key);
  @override
  _CheckBoxListTile createState() => _CheckBoxListTile();
}

class _CheckBoxListTile extends State<CheckBoxListTile> {
  Symptom _symptom = new Symptom();
  bool _checked = false;
  Color _color;

  @override
  void initState() {
    // Once user is set, the inputs are assigned and stop loading
    _setSymptom();
    super.initState();
  }

  Future<void> _setSymptom() async {
    Symptom symptom = await Preferences.myPrefs.getCheck();
    setState(() {
      _symptom = symptom;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_symptom.checked == true) {
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
      value: _symptom.checked,
      onChanged: (bool value) {
        setState(() {
          _symptom.checked = value;
        });
      },
      activeColor: _color,
      checkColor: Colors.white,
    );
  }
}
