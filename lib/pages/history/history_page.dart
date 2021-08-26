import 'package:covserver/config/theme.dart';
import 'package:covserver/pages/home_page/widgets/new_register_button.dart';
import 'package:covserver/widgets/settings_header.dart';
import 'package:covserver/widgets/text_symptom.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: SettingsHeader(name: 'Historial'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25, left: 35, right: 35, bottom: 85),
        children: [
          TextSymptomPage(
            txt: 'Historial de síntomas',
          ),
          SizedBox(height: 10),
          Text('Seleccione un registro para ver más detalles.',
              style: TextStyle(
                  color: applicationColors['font_light']!.withOpacity(0.7),
                  fontSize: 16)),
          SizedBox(height: 15),
          NewRegisterButton(
            onPressed: () {},
            risk: 'no',
            time: DateTime.now(),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 85),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/symptoms_register'),
          child: Icon(Icons.add),
          backgroundColor: applicationColors['light_purple'],
        ),
      ),
    );
  }
}
