import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class StateCovidPage extends StatefulWidget {
  final String estado;
  final Color estadoColor;

  StateCovidPage({Key key, this.estado, this.estadoColor}) : super(key: key);

  @override
  _StateCovidPageState createState() => _StateCovidPageState();
}

class _StateCovidPageState extends State<StateCovidPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? applicationColors['background_dark_2']
            : applicationColors['background_light_2'],
        border: Border.all(color: widget.estadoColor),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 15)
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85 / 2),
              color: widget.estadoColor,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
            ),
            width: 165,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.estado,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? applicationColors['lila']
                              : applicationColors['light_purple'],
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
