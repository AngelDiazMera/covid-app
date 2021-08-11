import 'package:covserver/services/preferences/preferences.dart';
import 'package:covserver/services/providers/health_condition_provider.dart';
import 'package:covserver/services/providers/need_hc_update_provider.dart';
import 'package:covserver/widgets/alert_no_infection.dart';
import 'package:flutter/material.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/widgets/avatar_image.dart';
import 'package:provider/provider.dart';

class AccountPageInfoHeader extends StatefulWidget {
  final double width;

  AccountPageInfoHeader({Key? key, required this.width}) : super(key: key);

  @override
  _AccountPageInfoHeaderState createState() => _AccountPageInfoHeaderState();
}

class _AccountPageInfoHeaderState extends State<AccountPageInfoHeader> {
  late User myUser;
  bool loading = true;
  bool needUpdState = false;

  bool hasAlertShown = false;

  void _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    setState(() {
      myUser = tempUser;
      loading = false;
    });
  }

  Future reloadDelayed(int duration, NeedHcUpdate needUpd) async {
    // if (makeRequest) return false;
    // makeRequest = true;
    // return new Future.delayed(Duration(seconds: duration), () async {
    //   bool newUpdate = await Preferences.myPrefs.getNeedHCUpdate();
    //   bool needReload = newUpdate == needUpd.isUpdateNeeded;
    //   if (needReload) print('Necesita actualizar ($newUpdate)');
    //   needUpd.isUpdateNeeded = newUpdate;

    //   if (needUpd.isUpdateNeeded) {
    //     print('Mostrando diálgo');
    //     showDialog(
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (context) => AlertNoInfection(),
    //     );
    //   }
    //   makeRequest = false;
    //   return needReload;
    // });
  }

  void _loadHC(HealthCondition hc, NeedHcUpdate needUpd) async {
    if (hasAlertShown) return;
    hc.healthCondition = await Preferences.myPrefs.getHealthCondition();
    needUpd.isUpdateNeeded = await Preferences.myPrefs.getNeedHCUpdate();

    if (needUpd.isUpdateNeeded) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertNoInfection(),
      );
      setState(() => hasAlertShown = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final hc = Provider.of<HealthCondition>(context);
    final needUpd = Provider.of<NeedHcUpdate>(context);

    _loadHC(hc, needUpd);

    if (loading) return Container();

    return Row(
      children: [
        // Avatar is shown on the left
        Container(
            margin: EdgeInsets.only(left: 15),
            width: (widget.width / 3) - 15,
            child: AvatarImage(
                gender: myUser.gender, size: (widget.width / 3) - 15)),
        // Information is shown on the right
        Container(
          width: 2 * widget.width / 3,
          child: _drawAccountInfo(hc.healthCondition),
        )
      ],
    );
  }

  Widget _drawAccountInfo(String healthCondition) {
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
              healthCondition,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}
