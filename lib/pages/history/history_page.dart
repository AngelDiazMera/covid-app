import 'package:covserver/config/theme.dart';
import 'package:covserver/pages/history/widgets/history_page_body.dart';
import 'package:covserver/widgets/settings_header.dart';
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
      body: HistoryPageBody(),
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
