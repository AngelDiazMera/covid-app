import 'package:flutter/material.dart';
import 'package:persistencia_datos/widgets/home_tabs_page.dart';

class InfectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments ?? 'No data';

    return Scaffold(
      body: HomeTabsPage(),
    );
  }
}