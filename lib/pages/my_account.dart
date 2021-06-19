import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/widgets/custom_header.dart';
import 'package:persistencia_datos/widgets/account_page_info_header.dart';
import 'package:persistencia_datos/widgets/dark_button.dart';
import 'package:persistencia_datos/widgets/my_account_body.dart';

class MyAccountPage extends StatelessWidget {
  final Function changeToDarkMode;

  const MyAccountPage({Key key, @required this.changeToDarkMode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyAccountBody(),
        CustomHeader(
          top: -50,
          header: DarkButton(changeToDarkMode: changeToDarkMode),
          child: AccountPageInfoHeader(
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}
