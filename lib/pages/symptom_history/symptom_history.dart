import 'package:covserver/config/theme.dart';
import 'package:covserver/models/history_model.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/widgets/avatar_image.dart';
import 'package:covserver/widgets/recommendations_button.dart';
import 'package:covserver/widgets/settings_header.dart';
import 'package:covserver/widgets/text_symptom.dart';
import 'package:flutter/material.dart';

class SymptomHistory extends StatefulWidget {
  final HistoryModel history;

  const SymptomHistory({Key? key, required this.history}) : super(key: key);

  @override
  _SymptomHistoryState createState() => _SymptomHistoryState();
}

class _SymptomHistoryState extends State<SymptomHistory> {
  String name = '';

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  void _loadUser() async {
    User user = await MyUser.mine.getMyUser();
    setState(() => name = '${user.name} ${user.lastName}');
  }

  Widget _buildIconText(
    String text,
    Icon icon, {
    bool reversed = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    List<Widget> children = [
      icon,
      SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 18))
    ];
    if (reversed) children = children.reversed.toList();
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    var splitedDate = widget.history.time.toString().split(' ');
    Map<String, Color> colorParser = {
      'none': Colors.green.shade700,
      'risk': Colors.amberAccent.shade700,
      'infected': Colors.red.shade400
    };
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: SettingsHeader(name: 'Registro de síntomas', needGoBack: true),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AvatarImage(size: 150, isElevated: false),
          ]),
          SizedBox(height: 25),
          Center(child: TextSymptomPage(txt: name)),
          SizedBox(height: 15),
          _buildIconText(
            widget.history.parsedStatus,
            Icon(
              Icons.radio_button_checked,
              color: colorParser[widget.history.status],
            ),
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: applicationColors['input_light'],
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconText(
                  splitedDate[0],
                  Icon(Icons.calendar_today_rounded),
                ),
                _buildIconText(splitedDate[1].substring(0, 5),
                    Icon(Icons.schedule_rounded),
                    reversed: true)
              ],
            ),
          ),
          SizedBox(height: 35),
          Opacity(
            opacity: 0.5,
            child: widget.history.symptoms.length == 0
                ? Text('No se registraron síntomas',
                    style: TextStyle(
                        fontSize: 18, color: applicationColors['font_light']))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Síntomas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 5),
                      Text(
                        widget.history.symptoms,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
          ),
          SizedBox(height: 10),
          RecommendationsButton(),
        ],
      ),
    );
  }
}
