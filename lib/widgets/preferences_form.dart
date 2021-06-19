import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/theme/theme.dart';
import 'package:persistencia_datos/widgets/form_background_card.dart';

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

  @override
  void initState() {
    widget.newUser.isFemale = false;
    super.initState();
    setState(() {
      newUser = widget.newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.withBackground
        ? FormBackgroundCard(
            horizontalMargin: widget.horizontalMargin, child: _drawFormBody())
        : Form(
            child: _drawFormBody(),
          );
  }

  Widget _drawFormBody() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SexButton(
                isSelected: !newUser.isFemale,
                onPressed: () {
                  setState(() {
                    newUser.isFemale = false;
                  });
                },
                icon: Foundation.male_symbol),
            AvatarImage(
              size: 150,
              isElevated: false,
            ),
            SexButton(
                isSelected: newUser.isFemale,
                onPressed: () {
                  setState(() {
                    newUser.isFemale = true;
                  });
                },
                icon: Foundation.female_symbol),
          ],
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextFormField(
              label: 'Nombre',
              initialValue: newUser.name,
              icon: Icons.person,
              keyboardType: TextInputType.name,
              onChanged: (String value) {
                setState(() {
                  newUser.name = value;
                });
              },
              width: (MediaQuery.of(context).size.width / 2) -
                  7.5 -
                  widget.horizontalMargin,
            ),
            CustomTextFormField(
              label: 'Apellidos',
              initialValue: newUser.lastName,
              keyboardType: TextInputType.name,
              onChanged: (String value) {
                setState(() {
                  newUser.lastName = value;
                });
              },
              width: (MediaQuery.of(context).size.width / 2) -
                  7.5 -
                  widget.horizontalMargin,
            )
          ],
        ),
        CustomTextFormField(
          label: 'Email',
          initialValue: newUser.email,
          icon: Icons.alternate_email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            setState(() {
              newUser.email = value;
            });
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextFormField(
              label: 'Grupo',
              initialValue:
                  newUser.group != null ? newUser.group.toString() : '',
              icon: Icons.vpn_key_rounded,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  newUser.group = int.parse(value);
                });
              },
              width: MediaQuery.of(context).size.width - 155,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Verificar',
                style: TextStyle(fontSize: 14),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                primary: Colors.white,
                minimumSize: Size(70, 20),
                backgroundColor: Color.fromRGBO(99, 109, 240, 1),
              ),
            )
          ],
        ),
        CustomTextFormField(
          label: 'Última temperatura',
          initialValue:
              newUser.temperature != null ? newUser.temperature.toString() : '',
          icon: Icons.thermostat_outlined,
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              newUser.temperature = double.parse(value);
            });
          },
        )
      ],
    );
  }
}

class SexButton extends StatelessWidget {
  bool isSelected;
  Function onPressed;
  IconData icon;

  SexButton(
      {Key key,
      @required this.isSelected,
      @required this.onPressed,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? applicationColors['light_purple']
        : Theme.of(context).brightness == Brightness.dark
            ? applicationColors['input_dark']
            : applicationColors['input_light'];

    return TextButton(
      onPressed: onPressed,
      child: Icon(icon),
      style: TextButton.styleFrom(
        primary: isSelected ? Colors.white : Colors.black54,
        backgroundColor: color,
        shape: CircleBorder(),
        minimumSize: Size(50, 50),
      ),
    );
  }
}
