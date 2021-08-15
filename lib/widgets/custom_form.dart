import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:covserver/widgets/sex_button.dart';

import 'avatar_image.dart';
import 'custom_text_form_field.dart';

class CustomForm extends StatefulWidget {
  final List<Map> inputs; // Intputs to render
  final List<void Function(String)> callbacks; // Callbacks of inputs (ordered)
  final double horizontalMargin;
  final bool withBackground; // If it renders on a box
  final bool hasGenderSelection; // If it has gender selector
  final String? gender; // A gender is REQUIRED if hasGenderSelection is true
  final Function?
      onGenderChange; // callback is REQUIRED if hasGenderSelection is true
  final GlobalKey? formKey;

  const CustomForm({
    Key? key,
    required this.inputs,
    required this.callbacks,
    this.horizontalMargin = 35,
    this.withBackground = false,
    this.hasGenderSelection = false,
    this.gender,
    this.onGenderChange,
    this.formKey,
  }) : super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  double _avatarSize = 150; // To handle avatar picture animation

  @override
  void initState() {
    super.initState();
  }

  // BUILD method
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Column(
          children: [
            widget.hasGenderSelection ? SizedBox(height: 35) : SizedBox(),
            Form(
              child: _drawFormBody(widget.inputs),
              key: widget.formKey,
            ),
          ],
        ),
        widget.hasGenderSelection
            ? Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.fastOutSlowIn,
                  width: _avatarSize,
                  height: _avatarSize,
                  child: AvatarImage(
                    size: 150,
                    isElevated: false,
                    gender: widget.gender,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  // draws the body of the form
  Widget _drawFormBody(List inputs) {
    // If wants to decore it with a card background
    BoxDecoration? decoration = widget.withBackground
        ? BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.3, 1],
              colors: [
                Color.fromRGBO(250, 250, 250, 0.7),
                Color.fromRGBO(250, 250, 250, 0.5)
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 15)
            ],
          )
        : null;

    // Initialices the content of the form
    List content = <Widget>[];
    if (widget.hasGenderSelection)
      content = <Widget>[_drawFormHeader(), SizedBox(height: 50)];

    int callbackIndex = 0;
    // Each row
    inputs.asMap().forEach((rowIndex, row) {
      List<Widget> inputs = [];
      // Each input in List
      row['inputs'].asMap().forEach((int index, Map input) {
        // Calculating the width of each input
        double containerWidth = MediaQuery.of(context).size.width -
            2 * widget.horizontalMargin -
            30;
        double inputWidth = (containerWidth / row['inputs'].length) -
            (row['inputs'].length - 1) * 7.5;

        // If the row has a button, then change width of the input
        if (row['button'] != null) inputWidth -= 85;
        // Adding the input
        inputs.add(Flexible(
          child: CustomTextFormField(
            label: input['label'],
            enabled: input['enabled'],
            initialValue: input['value'].toString(),
            icon: index == 0 ? row['icon'] : null, // Icon in first elem. only
            keyboardType: input['keyboard'],
            onChanged: widget.callbacks[callbackIndex],
            obscureText: input['obscureText'],
            iconButton: input['iconButton'],
            width: inputWidth,
          ),
        ));
        callbackIndex += 1;
        // If the row has a button, then add it
        if (row['button'] != null)
          inputs.add(TextButton(
            onPressed: row['button']['callback'],
            child: Text(
              row['button']['text'],
              style: TextStyle(fontSize: 14),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              primary: Colors.white,
              minimumSize: Size(70, 20),
              backgroundColor: Color.fromRGBO(99, 109, 240, 1),
            ),
          ));
      });

      // Row which contains the inputs
      content.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: inputs,
      ));
    });

    // Form body itself
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: content as List<Widget>,
        ),
      ),
    );
  }

  // Sexbuttons
  Widget _drawFormHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SexButton(
            isSelected: widget.gender == 'male',
            onPressed: maleBtnOnChange,
            icon: Icons.male),
        SexButton(
            isSelected: widget.gender == 'female',
            onPressed: femaleBtnOnChange,
            icon: Icons.female),
      ],
    );
  }

  void maleBtnOnChange() {
    setState(() {
      _avatarSize = 0;
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        widget.onGenderChange!('male');
        _avatarSize = 150;
      });
    });
  }

  void femaleBtnOnChange() {
    setState(() {
      _avatarSize = 0;
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        widget.onGenderChange!('female');
        _avatarSize = 150;
      });
    });
  }
}
