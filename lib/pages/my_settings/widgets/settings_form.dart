import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  User _user = new User(); // User of the form

  String _psw = ''; // Password (it will be hashed before being asigned)
  bool _isPswVisible = false; // To handle password visibility

  @override
  void initState() {
    // Once user is set, the inputs are assigned and stop loading
    _setUser();
    super.initState();
  }

  // Set the user from preferences
  Future<void> _setUser() async {
    User user = await MyUser.mine.getMyUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

    // Inputs of the form
    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Nombre',
            'value': _user.name,
            'keyboard': TextInputType.name,
            'onChanged': _nameOnChange,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': _user.lastName,
            'keyboard': TextInputType.name,
            'onChanged': _lastNameOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.person
      },
      {
        'inputs': [
          {
            'label': 'Email',
            'value': _user.email,
            'enabled': false,
            'keyboard': TextInputType.emailAddress,
            'onChanged': _emailOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.alternate_email
      },
      {
        'inputs': [
          {
            'label': 'Contraseña',
            'value': _psw,
            'keyboard': TextInputType.visiblePassword,
            'onChanged': _pswOnChange,
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
          horizontalMargin: formMargin,
          hasGenderSelection: true,
          gender: _user.gender,
          onGenderChange: (value) {
            setState(() {
              _user.gender = value;
            });
          },
        ),
      ],
    );
  }

  // State handlers
  void _nameOnChange(String value) => setState(() => _user.name = value);
  void _lastNameOnChange(String value) =>
      setState(() => _user.lastName = value);
  void _emailOnChange(String value) => setState(() => _user.email = value);
  void _pswOnChange(String value) => setState(() => _psw = value);
  void _setPswVisible() => setState(() => _isPswVisible = !_isPswVisible);
}
