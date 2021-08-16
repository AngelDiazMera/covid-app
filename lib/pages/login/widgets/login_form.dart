import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/new_user_provider.dart';
import 'package:covserver/utils/hash_value.dart';
import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/widgets/custom_form.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // State variables of the form
  String _email = '';
  String _psw = '';
  bool _isPswVisible = false; // Handle the password visibility
  // State variables of the request
  bool _isRequesting = false; // If it's requesting
  String _reqError = ''; // When request has error, this will be the message

  late List<Map<String, dynamic>> _inputs;

  void initList() {
    setState(() {
      this._inputs = [
        {
          'inputs': [
            {
              'label': 'Email',
              'value': _email,
              'keyboard': TextInputType.emailAddress,
              // 'onChanged': _emailOnChange,
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
              // 'onChanged': _pswOnChange,
              'obscureText': !_isPswVisible,
              'iconButton': IconButton(
                icon: Icon(
                    _isPswVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: _setPswVisible,
              ),
            }
          ],
          'icon': Icons.vpn_key_rounded
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final newUserHandler = Provider.of<NewUserHandler>(context);
    double formMargin = 25;
    // Inputs of the form
    initList();

    return Column(
      children: [
        // Form
        CustomForm(
            inputs: _inputs,
            horizontalMargin: formMargin,
            callbacks: [_emailOnChange, _pswOnChange]),
        SizedBox(height: 20),
        // Button 'Ingresar'
        Center(
          child: TextButton(
            onPressed: () =>
                _isRequesting ? null : _signIn(context, newUserHandler),
            child: Text(
              'Ingresar',
              style: TextStyle(fontSize: 14),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              primary: applicationColors['medium_purple'],
              backgroundColor:
                  applicationColors['background_light_1']!.withOpacity(
                _isRequesting ? 0.75 : 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Sign the user into the app (it is used as an "onTap" event action)
  void _signIn(BuildContext contextn, NewUserHandler newUserHandler) async {
    print('Enviando: \n$_email\n$_psw');
    // Email and password can't be null
    if (_email.isEmpty || _psw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No puede dejar campos vacíos'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } // Request
    setState(() => _isRequesting = true);
    User? signedUser =
        await signIn(_email, hashValue(_psw), onError: _handleSignInError);
    setState(() => _isRequesting = false);
    // If something goes wrong, the error must have a message
    // because of the _handleSignInError callback
    if (_reqError != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_reqError),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _reqError = '';
      });
      return;
    }
    // If everything is ok
    if (signedUser != null) {
      await MyUser.mine.savePrefs(signedUser);
      await Preferences.myPrefs.setHealthCondition(signedUser.healthCondition!);
      newUserHandler.isNew = false;
      Navigator.pop(context);
    }
  }

  /// Callback if something goes wrong
  void _handleSignInError(String error) {
    setState(() {
      _reqError = error;
    });
  }

  // Onchange functions
  void _pswOnChange(String value) => setState(() => _psw = value);
  void _emailOnChange(String value) {
    setState(() => _email = value);
    print(value);
  }

  void _setPswVisible() => setState(() => _isPswVisible = !_isPswVisible);
}
