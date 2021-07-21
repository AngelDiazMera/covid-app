import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';

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

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

    List<Map> _inputs = [
      {
        'inputs': [
          {
            'label': 'Nombre',
            'value': _formData['name'],
            'keyboard': TextInputType.name,
            'onChanged': nameOnChange,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': _formData['lastName'],
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
            'value': _formData['access']['email'],
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
            'onChanged': repPswOnChange,
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

    return Column(
      children: [
        CustomForm(
          inputs: _inputs,
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
      _psw = value;
    });
  }

  void repPswOnChange(String value) {
    setState(() {
      _repPsw = value;
    });
  }
}
