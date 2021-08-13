import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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
            'onChanged': nameOnChange,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': _user.lastName,
            'keyboard': TextInputType.name,
            'onChanged': lastNameOnChange,
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
            'onChanged': emailOnChange,
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
            'onChanged': pswOnChange,
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

  void nameOnChange(String value) {
    setState(() {
      _user.name = value;
    });
  }

  void lastNameOnChange(String value) {
    setState(() {
      _user.lastName = value;
    });
  }

  void emailOnChange(String value) {
    setState(() {
      _user.email = value;
    });
  }

  void pswOnChange(String value) {
    setState(() {
      var bytes = utf8.encode("_psw"); // data being hashed
      var digest = sha256.convert(bytes);
      value = digest as String;
      _psw = value;
    });
  }

  void _setPswVisible() {
    setState(() {
      _isPswVisible = !_isPswVisible;
    });
  }
}
