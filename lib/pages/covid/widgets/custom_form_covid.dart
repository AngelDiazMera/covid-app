import 'package:flutter/material.dart';
import 'avatar_image_covid.dart';
import 'covid_button.dart';

class CustomFormSymptom extends StatefulWidget {
  // Intputs to render
  final double horizontalMargin;
  final bool withBackground; // If it renders on a box
  final bool hasInfectionSelection; // If it has gender selector
  final String infection; // A gender is REQUIRED if hasGenderSelection is true
  final Function
      onInfectionChange; // callback is REQUIRED if hasGenderSelection is true

  const CustomFormSymptom({
    Key? key,
    this.horizontalMargin = 35,
    this.withBackground = false,
    this.hasInfectionSelection = false,
    required this.infection,
    required this.onInfectionChange,
  }) : super(key: key);
  @override
  _CustomFormSymptomState createState() => _CustomFormSymptomState();
}

class _CustomFormSymptomState extends State<CustomFormSymptom> {
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
            widget.hasInfectionSelection ? SizedBox(height: 35) : SizedBox(),
            Form(child: _drawFormBody()),
          ],
        ),
        widget.hasInfectionSelection
            ? Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.fastOutSlowIn,
                  width: _avatarSize,
                  height: _avatarSize,
                  child: AvatarImage(
                    size: 150,
                    isElevated: false,
                    infection: widget.infection,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  // draws the body of the form
  Widget _drawFormBody() {
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
    List<Widget> content = [];
    if (widget.hasInfectionSelection)
      content = <Widget>[_drawFormHeader(), SizedBox(height: 50)];

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

  // Covidbuttons
  Widget _drawFormHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CovidButton(
            isSelected: widget.infection == 'Bajo riesgo',
            onPressed: bajoRiesgoBtnOnChange,
            icon: Icons.clear),
        CovidButton(
            isSelected: widget.infection == 'En riesgo',
            onPressed: enRiesgoBtnOnChange,
            icon: Icons.done),
      ],
    );
  }

  void bajoRiesgoBtnOnChange() {
    setState(() {
      _avatarSize = 0;
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        widget.onInfectionChange('Bajo riesgo');
        _avatarSize = 150;
      });
    });
  }

  void enRiesgoBtnOnChange() {
    setState(() {
      _avatarSize = 0;
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        widget..onInfectionChange('En riesgo');
        _avatarSize = 150;
      });
    });
  }
}
