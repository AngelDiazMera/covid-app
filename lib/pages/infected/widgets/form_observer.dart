import 'package:flutter/material.dart';
import 'custom_form_observer.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    double formMargin = 25;
    // Inputs of the form
    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Observaciones',
            'keyboard': TextInputType.text,
          }
        ],
        'icon': Icons.library_books
      },
    ];

    return Column(
      children: [
        CustomForm(
          inputs: _inputs,
          horizontalMargin: formMargin,
        ),
      ],
    );
  }
}
