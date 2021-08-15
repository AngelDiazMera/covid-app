import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/providers/new_user_provider.dart';
import 'package:covserver/utils/hash_value.dart';
import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/widgets/custom_form.dart';
import 'package:provider/provider.dart';

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

  int restingFields = 5;
  final _formKey = GlobalKey<FormState>();

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
    final newUserHandler = Provider.of<NewUserHandler>(context);
    double formMargin = 25;

    return Column(
      children: [
        CustomForm(
          formKey: _formKey,
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
            onPressed: () => _validate(newUserHandler),
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

  void _validate(NewUserHandler newUserHandler) async {
    if (_formKey.currentState!.validate()) {
      print('COMPARANDO: $_psw y $_repPsw');
      if (_psw != _repPsw) {
        SnackBar snackBar =
            SnackBar(content: Text('Las contraseñas no coinciden'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      await _signUp(newUserHandler);
      return;
    }
    // If the form is not valid, display a snackbar.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Debe llenar todos los campos.')),
    );
  }

  Future _signUp(NewUserHandler newUserHandler) async {
    // Hash password
    _formData['access']['password'] = hashValue(_psw);
    User newUser = new User.fromJson(_formData);

    print(newUser);
    // Handling variables
    bool hasError = false;
    String msg = 'Error';
    // Api request
    bool isRegistered = await signUp(newUser, onError: (String val) {
      hasError = true;
      msg = val;
    });
    // If request was wrong
    if (hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
      return;
    }
    // If everything's ok
    if (isRegistered) {
      await MyUser.mine.savePrefs(newUser);
      newUserHandler.isNew = false;
      Navigator.pop(context);
    }
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
    setState(() => _psw = value);
  }

  void repPswOnChange(String value) {
    setState(() => _repPsw = value);
  }
}
