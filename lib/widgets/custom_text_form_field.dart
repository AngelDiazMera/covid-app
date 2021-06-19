import 'package:flutter/material.dart';
import 'package:persistencia_datos/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function onChanged;
  final IconData icon;
  final double width;
  final String initialValue;

  const CustomTextFormField(
      {Key key,
      @required this.label,
      @required this.keyboardType,
      @required this.onChanged,
      this.icon,
      this.width = double.infinity,
      this.initialValue = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: width,
      child: TextFormField(
        keyboardType: keyboardType,
        initialValue: initialValue,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? applicationColors['input_dark']
              : applicationColors['input_light'],
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.5, vertical: icon != null ? 12.5 : 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: icon != null ? Icon(icon) : null,
          labelText: label,
          errorStyle: TextStyle(fontSize: 0, height: 0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        cursorColor: Colors.black,
        onChanged: onChanged,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'El campo "$label" no puede estar vacío';
          }
          return null;
        },
      ),
    );
  }
}
