import 'package:flutter/material.dart';
import 'package:persistencia_datos/config/theme/theme.dart';
import 'package:persistencia_datos/pages/covid/widgets/covid_form_page.dart';
import 'package:persistencia_datos/pages/infected/widgets/infected_form_page.dart';

class HomeTabsPage extends StatefulWidget {
  @override
  _HomeTabsPageState createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments ?? 'No data';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Infectados'),
        bottom: getTabBar(),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? applicationColors['medium_purple']
            : applicationColors['medium_purple'],
      ),
      body: getTabBarView(<Widget>[
        InfectedFormPage(),
        SymptomFormPage(),
      ]),
    );
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          text: 'Sintomas',
        ),
        Tab(
          text: 'Covid',
        )
      ],
      controller: _controller,
    );
  }

  TabBarView getTabBarView(var displays) {
    return TabBarView(
      children: displays,
      controller: _controller,
    );
  }
}
