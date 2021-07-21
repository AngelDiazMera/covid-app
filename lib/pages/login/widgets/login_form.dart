import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/services/api/requests.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/services/preferences/preferences.dart';
import 'package:persistencia_datos/widgets/custom_form.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email = '';
  String _psw = '';
  bool _isPswVisible = false;
  List<Map> _inputs;

  @override
  void initState() {
    _inputs = [
      {
        'inputs': [
          {
            'label': 'Email',
            'value': _email,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double formMargin = 25;

    return Column(
      children: [
        CustomForm(
          inputs: _inputs,
          horizontalMargin: formMargin,
        ),
        SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: _signIn,
            child: Text(
              'Ingresar',
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

  void _signIn() async {
    if (_email.isEmpty || _psw.isEmpty) return;
    User signedUser = await signIn(_email, _psw);
    if (signedUser != null) {
      await MyUser.mine.savePrefs(signedUser);
      Navigator.pushNamed(context, '/');
    }
  }

  void _pswOnChange(String value) {
    setState(() {
      _psw = value;
    });
  }

  void _emailOnChange(String value) {
    setState(() {
      _email = value;
    });
  }

  void _setPswVisible() {
    setState(() {
      _isPswVisible = !_isPswVisible;
    });
    print(_isPswVisible);
  }
}
