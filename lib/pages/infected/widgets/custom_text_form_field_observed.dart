import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;

  final IconData icon;
  final double width;

  final bool enabled;

  CustomTextFormField({
    Key key,
    @required this.label,
    @required this.keyboardType,
    this.icon,
    this.width = double.infinity,
    this.enabled,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focusNode = FocusNode();
  bool vis = true;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus)
      setState(() {
        _focusNode.unfocus();
      });
    else
      setState(() {
        _focusNode.requestFocus();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  Color _getInputColor() {
    if (Theme.of(context).brightness == Brightness.dark)
      return _focusNode.hasFocus ? applicationColors['lila'] : Colors.white60;
    return _focusNode.hasFocus ? applicationColors['lila'] : Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    Color fontColor = widget.enabled == false
        ? Theme.of(context).brightness == Brightness.dark
            ? Color.fromRGBO(180, 180, 180, 1)
            : Color.fromRGBO(125, 125, 125, 1)
        : null;

    return Container(
      margin: EdgeInsets.only(top: 15),
      width: widget.width,
      child: TextFormField(
        style: TextStyle(color: fontColor),
        enabled: widget.enabled,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? applicationColors['input_dark']
              : applicationColors['input_light'],
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12.5, vertical: widget.icon != null ? 12.5 : 14),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: _getInputColor(),
                )
              : null,
          labelText: widget.label,
          errorStyle: TextStyle(fontSize: 0, height: 0),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          labelStyle: TextStyle(
            color: _getInputColor(),
          ),
        ),
        cursorColor: Colors.black,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'El campo "${widget.label}" no puede estar vacío';
          }
          return null;
        },
      ),
    );
  }
}