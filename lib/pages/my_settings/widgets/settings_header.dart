import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:covserver/config/theme.dart';

class SettingsHeader extends StatelessWidget {
  final void Function()? doneCallback;
  final String name;
  final String doneButtonLabel;

  SettingsHeader({
    Key? key,
    this.doneCallback,
    this.doneButtonLabel = '',
    required this.name,
  }) : super(key: key);

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
                this.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              this.doneCallback != null
                  ? TextButton(
                      onPressed: this.doneCallback,
                      child: Text(this.doneButtonLabel),
                      style: TextButton.styleFrom(primary: Colors.white),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
