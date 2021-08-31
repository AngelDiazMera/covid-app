import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final void Function()? doneCallback;
  final String name;
  final String doneButtonLabel;
  final bool needGoBack;

  SettingsHeader({
    Key? key,
    this.doneCallback,
    this.doneButtonLabel = '',
    this.needGoBack = false,
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
              Color.fromRGBO(102, 49, 167, 1),
              Color.fromRGBO(126, 56, 183, 1),
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
              this.needGoBack
                  ? IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: applicationColors['background_light_1'],
                      ))
                  : Container(),
              Expanded(
                child: Text(
                  this.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
