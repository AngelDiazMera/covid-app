import 'package:flutter/material.dart';

import 'package:persistencia_datos/pages/infected/widgets/custom_text_form_field_observed.dart';

class CustomForm extends StatefulWidget {
  final List<Map> inputs; // Intputs to render
  final double horizontalMargin;
  final bool withBackground; // If it renders on a box
  // A gender is REQUIRED if hasGenderSelection is true
  // callback is REQUIRED if hasGenderSelection is true

  const CustomForm({
    Key key,
    @required this.inputs,
    this.horizontalMargin = 35,
    this.withBackground = false,
  }) : super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
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
            Form(child: _drawFormBody(widget.inputs)),
          ],
        ),
      ],
    );
  }

  // draws the body of the form
  Widget _drawFormBody(List inputs) {
    // If wants to decore it with a card background
    BoxDecoration decoration = widget.withBackground
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
    if (widget.withBackground)
      content = <Widget>[_drawFormBody(inputs), SizedBox(height: 50)];

    // Each row
    inputs.forEach((row) {
      List<Widget> inputs = [];
      // Each input in List
      row['inputs'].asMap().forEach((index, input) {
        // Calculating the width of each input
        double containerWidth = MediaQuery.of(context).size.width -
            2 * widget.horizontalMargin -
            30;
        double inputWidth = (containerWidth / row['inputs'].length) -
            (row['inputs'].length - 1) * 7.5;

        // Adding the input
        inputs.add(Flexible(
          child: CustomTextFormField(
            label: input['label'],
            icon: index == 0 ? row['icon'] : null, // Icon in first elem. only
            keyboardType: input['keyboard'],
            width: inputWidth,
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
          children: content,
        ),
      ),
    );
  }
}
