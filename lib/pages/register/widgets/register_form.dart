import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/widgets/custom_form.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  Map<String, dynamic> _formData = {
    'name': '',
    'lastName': '',
    'gender': 'male',
    'access': {
      'email': '',
      'password': '',
    },
  };

  String _psw = '';
  String _repPsw = '';
  bool _isPswVisible = true;
  bool _isRepPswVisible = true;
  List<Map>? _inputs;

  @override
  void initState() {
    _inputs = [
      {
        'inputs': [
          {
            'label': 'Nombre',
            'value': _formData['name'],
            'keyboard': TextInputType.name,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': _formData['lastName'],
            'keyboard': TextInputType.name,
            'obscureText': false
          }
        ],
        'icon': Icons.person
      },
      {
        'inputs': [
          {
            'label': 'Email',
            'value': _formData['access']['email'],
            'keyboard': TextInputType.emailAddress,
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
            'obscureText': _isPswVisible,
            'iconButton': IconButton(
              icon:
                  Icon(_isPswVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isPswVisible = !_isPswVisible;
                });
              },
            ),
          }
        ],
        'icon': Icons.vpn_key_rounded
      },
      {
        'inputs': [
          {
            'label': 'Repetir contraseña',
            'value': _repPsw,
            'keyboard': TextInputType.visiblePassword,
            'obscureText': _isRepPswVisible,
            'iconButton': IconButton(
              icon: Icon(
                  _isRepPswVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isRepPswVisible = !_isRepPswVisible;
                });
              },
            ),
          }
        ],
        'icon': Icons.vpn_key_rounded
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

    return Column(
      children: [
        CustomForm(
          inputs: _inputs!,
          callbacks: [
            nameOnChange,
            lastNameOnChange,
            emailOnChange,
            pswOnChange,
            repPswOnChange
          ],
          horizontalMargin: formMargin,
          withBackground: true,
          hasGenderSelection: true,
          gender: _formData['gender'],
          onGenderChange: (value) {
            setState(() {
              _formData['gender'] = value;
            });
          },
        ),
        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: _signUp,
            child: Text(
              'Registrarme',
              style: TextStyle(fontSize: 14),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              primary: applicationColors['medium_purple'],
              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _signUp() {
    if (_psw != _repPsw) return;

    _formData['access']['password'] = _psw;

    User newUser = new User.fromJson(_formData);

    MyUser.mine.saveMyUser(newUser).then((bool isRegistered) {
      if (isRegistered) Navigator.pushNamed(context, '/');
    }).catchError((error) {
      print(error);
    });
  }

  void nameOnChange(String value) {
    setState(() {
      _formData['name'] = value;
    });
  }

  void lastNameOnChange(String value) {
    setState(() {
      _formData['lastName'] = value;
    });
  }

  void emailOnChange(String value) {
    setState(() {
      _formData['access']['email'] = value;
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

  void repPswOnChange(String value) {
    setState(() {
      var bytes = utf8.encode("_repPsw"); // data being hashed
      var digest = sha256.convert(bytes);
      value = digest as String;
      _repPsw = value;
    });
  }
}
