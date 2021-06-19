import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/models/user.dart';

class SettingsHeader extends StatelessWidget {
  User newUser;

  SettingsHeader({Key key, @required this.newUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromRGBO(57, 72, 235, 1),
              Color.fromRGBO(99, 109, 240, 1),
            ],
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 15)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Cancelar'),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
            Text(
              'Preferencias',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextButton(
              onPressed: _saveChanges,
              child: Text('Hecho'),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    MyUser.mine.myUser = newUser;
    print('Guardado');
  }
}
