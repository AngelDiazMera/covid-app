import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class SettingsHeader extends StatelessWidget {
  final Function doneCallback;

  SettingsHeader({Key key, @required this.doneCallback}) : super(key: key);

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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Preferencias',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  bool isUpdated = doneCallback();
                  _mostrarAlert(context, isUpdated);
                },
                child: Text('Hecho'),
                style: TextButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Llamado desde onpressed
  void _mostrarAlert(BuildContext context, bool isUpdated) {
    showDialog(
        context: context,
        barrierDismissible: true, //Para el clikc afuera y salir
        builder: (context) {
          return AlertDialog(
            //Para los bordes redondeados
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // configuración del diálogo
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize:
                  MainAxisSize.min, // se adapta al tamaño del contenido
              children: <Widget>[
                Icon(
                  isUpdated ? Ionicons.md_happy : Ionicons.md_sad,
                  size: 48,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? applicationColors['font_dark']
                      : applicationColors['font_light'],
                ),
                SizedBox(width: 15),
                Flexible(
                    child: isUpdated
                        ? Text('Su información se actualizó correctamente.')
                        : Text('Hubo un problema con la actualización.')),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Ok',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).brightness == Brightness.dark
                          ? applicationColors['lila']
                          : applicationColors['medium_purple'])),
            ],
          );
        });
  }
}
