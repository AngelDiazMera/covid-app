import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final IconData? icon;
  final double width;
  final String initialValue;
  final bool? obscureText;
  final IconButton? iconButton;
  final bool? enabled;
  final Color? backgroundColor;

  CustomTextFormField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.onChanged,
    this.icon,
    this.width = double.infinity,
    this.initialValue = '',
    this.obscureText = false,
    this.iconButton,
    this.enabled,
    this.backgroundColor,
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

  Color? _getInputColor() {
    if (Theme.of(context).brightness == Brightness.dark)
      return _focusNode.hasFocus ? applicationColors['lila'] : Colors.white60;
    return _focusNode.hasFocus ? applicationColors['lila'] : Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    Color? fontColor = widget.enabled == false
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
        initialValue: widget.initialValue,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          fillColor: widget.backgroundColor != null
              ? widget.backgroundColor
              : Theme.of(context).brightness == Brightness.dark
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
          suffixIcon: widget.iconButton != null ? widget.iconButton : null,
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
        onChanged: widget.onChanged,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'El campo "${widget.label}" no puede estar vacío';
          }
          return null;
        },
        obscureText: widget.obscureText!,
      ),
    );
  }
}
