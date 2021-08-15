import 'package:flutter/material.dart';

import 'package:covserver/models/user.dart';
import 'package:covserver/widgets/custom_form.dart';

class SettingsForm extends StatefulWidget {
  final User user;
  final List<void Function(String)> callbacks;

  const SettingsForm({Key? key, required this.user, required this.callbacks})
      : super(key: key);
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  bool _isPswVisible = false; // To handle password visibility

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

    // Inputs of the form
    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Nombre',
            'value': widget.user.name,
            'keyboard': TextInputType.name,
            // 'onChanged': nameOnChange,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': widget.user.lastName,
            'keyboard': TextInputType.name,
            // 'onChanged': lastNameOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.person
      },
      {
        'inputs': [
          {
            'label': 'Email',
            'value': widget.user.email,
            'enabled': false,
            'keyboard': TextInputType.emailAddress,
            // 'onChanged': emailOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.alternate_email
      },
      {
        'inputs': [
          {
            'label': 'Contraseña',
            'value': widget.user.psw,
            'keyboard': TextInputType.visiblePassword,
            // 'onChanged': pswOnChange,
            'obscureText': _isPswVisible,
            'iconButton': IconButton(
              icon:
                  Icon(_isPswVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: _setPswVisible,
            ),
          }
        ],
        'icon': Icons.vpn_key_rounded
      },
    ];

    return Column(
      children: [
        CustomForm(
          inputs: _inputs,
          callbacks: widget.callbacks,
          horizontalMargin: formMargin,
          hasGenderSelection: true,
          gender: widget.user.gender,
          onGenderChange: (value) {
            setState(() {
              widget.user.gender = value;
            });
          },
        ),
      ],
    );
  }

  void _setPswVisible() {
    setState(() {
      _isPswVisible = !_isPswVisible;
    });
  }
}
