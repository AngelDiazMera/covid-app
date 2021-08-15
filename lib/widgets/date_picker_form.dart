import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function selectDate;
  final String? label;
  final String? helper;

  DateWidget(
      {Key? key,
      this.controller,
      required this.selectDate,
      this.label,
      this.helper})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? applicationColors['input_dark']
            : applicationColors['input_light'],
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        labelText: this.label,
        helperText: this.helper,
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        selectDate(context);
      },
    );
  }
}
