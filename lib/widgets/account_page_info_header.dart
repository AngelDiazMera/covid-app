import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/widgets/avatar_image.dart';

class AccountPageInfoHeader extends StatefulWidget {
  final double width;

  AccountPageInfoHeader({Key key, @required this.width}) : super(key: key);

  @override
  _AccountPageInfoHeaderState createState() => _AccountPageInfoHeaderState();
}

class _AccountPageInfoHeaderState extends State<AccountPageInfoHeader> {
  User myUser;
  bool loading = true;

  void _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    setState(() {
      myUser = tempUser;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Container();
    return Row(
      children: [
        // Avatar is shown on the left
        Container(
            margin: EdgeInsets.only(left: 15),
            width: (widget.width / 3) - 15,
            child: AvatarImage(
                isFemale: myUser.isFemale, size: (widget.width / 3) - 15)),
        // Information is shown on the right
        Container(
          width: 2 * widget.width / 3,
          child: _drawAccountInfo(),
        )
      ],
    );
  }

  Widget _drawAccountInfo() {
    TextStyle textStyle = TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white);
    return Column(
      children: [
        SizedBox(height: 15),
        Text(
          myUser.name ?? '',
          style: textStyle,
        ),
        Text(
          myUser.lastName ?? '',
          style: textStyle,
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.coronavirus,
              size: 24,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Sin reportes',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}
