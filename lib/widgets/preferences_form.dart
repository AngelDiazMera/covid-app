import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/sex_button.dart';

import 'avatar_image.dart';
import 'custom_text_form_field.dart';

class PreferencesForm extends StatefulWidget {
  final double horizontalMargin;
  final bool isNew;
  final User newUser;
  final bool withBackground;

  const PreferencesForm(
      {Key key,
      this.horizontalMargin = 35,
      this.isNew = false,
      this.newUser,
      this.withBackground = false})
      : super(key: key);
  @override
  _PreferencesFormState createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  User newUser;
  double _avatarSize = 150;
  bool vis = true;
  @override
  void initState() {
    super.initState();
    setState(() {
      newUser = widget.newUser;
    });
  }

  // BUILD method
  @override
  Widget build(BuildContext context) {
    //#region form_definition
    List inputs = [
      {
        'inputs': [
          {
            'label': 'Nombre',
            'value': newUser.name ?? '',
            'keyboard': TextInputType.name,
            'onChanged': nameOnChange,
            'obscureText': false
          },
          {
            'label': 'Apellidos',
            'value': newUser.lastName ?? '',
            'keyboard': TextInputType.name,
            'onChanged': lastNameOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.person
      },
      {
        'inputs': [
          {
            'label': 'Email',
            'value': newUser.email ?? '',
            'keyboard': TextInputType.emailAddress,
            'onChanged': emailOnChange,
            'obscureText': false
          }
        ],
        'icon': Icons.alternate_email
      },
      {
        'inputs': [
          {
            'label': 'Contraseña',
            'value': newUser.psw ?? '',
            'keyboard': TextInputType.visiblePassword,
            'onChanged': groupOnChange,
            'obscureText': vis,
            'iconButton': IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
          }
        ],
        //'button': {'text': 'Verificar', 'callback': () {}},
        'icon': Icons.vpn_key_rounded
      },
    ];
    //#endregion
    return Stack(
      fit: StackFit.loose,
      children: [
        Column(
          children: [
            SizedBox(height: 35),
            Form(child: _drawFormBody(inputs)),
          ],
        ),
        Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            width: _avatarSize,
            height: _avatarSize,
            child: AvatarImage(
              size: 150,
              isElevated: false,
              gender: newUser.gender,
            ),
          ),
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
    List content = <Widget>[_drawFormHeader(), SizedBox(height: 50)];

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

        // If the row has a button, then change width of the input
        if (row['button'] != null) inputWidth -= 85;

        // Adding the input
        inputs.add(Flexible(
          child: CustomTextFormField(
            label: input['label'],
            initialValue: input['value'].toString(),
            icon: index == 0 ? row['icon'] : null, // Icon in first elem. only
            keyboardType: input['keyboard'],
            onChanged: input['onChanged'],
            obscureText: input['obscureText'],
            iconButton: input['iconButton'],
            width: inputWidth,
          ),
        ));

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
          children: content,
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
            isSelected: newUser.gender == 'male',
            onPressed: maleBtnOnChange,
            icon: Foundation.male_symbol),
        SexButton(
            isSelected: newUser.gender == 'female',
            onPressed: femaleBtnOnChange,
            icon: Foundation.female_symbol),
      ],
    );
  }

  //#region onChange_state_functions
  void maleBtnOnChange() {
    setState(() {
      _avatarSize = 0;
    });
    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        newUser.gender = 'male';
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
        newUser.gender = 'female';
        _avatarSize = 150;
      });
    });
  }

  void nameOnChange(String value) {
    setState(() {
      newUser.name = value;
    });
  }

  void lastNameOnChange(String value) {
    setState(() {
      newUser.lastName = value;
    });
  }

  void emailOnChange(String value) {
    setState(() {
      newUser.email = value;
    });
  }

  void groupOnChange(String value) {
    setState(() {
      newUser.psw = value;
    });
  }

  //#endregion
}
