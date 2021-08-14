import 'package:covserver/config/theme.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  TextEditingController? controller;
  Function selectDate;
  DateWidget({Key? key, this.controller, required this.selectDate})
      : super(key: key);
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: TextField(
        controller: widget.controller,
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
          hintText: 'Fecha de inicio',
          labelText: 'Fecha de inicio',
          suffixIcon: Icon(
            Icons.calendar_today,
          ),
          prefixIcon: Icon(Icons.perm_contact_calendar),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          widget.selectDate(context);
        },
      ),
    );
  }
}
