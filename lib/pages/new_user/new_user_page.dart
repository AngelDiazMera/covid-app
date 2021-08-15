import 'package:flutter/material.dart';

import 'package:covserver/pages/get_started/get_started_page.dart';
import 'package:covserver/pages/new_user/widgets/action_buttons.dart';

import 'package:covserver/pages/new_user/widgets/page_index_viewer.dart';
import 'package:covserver/widgets/violet_background.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  int _selectedIndex = 0;

  final List _selectedPages = <Widget>[
    GetStartedPage(),
    // ... More "Pages of information"
  ];

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: _selectedIndex);

    return Scaffold(
      body: Stack(
        children: [
          VioletBackground(),
          PageIndexViewer(
            selectedPage: this._selectedIndex,
            selectedPages: this._selectedPages,
          ),
          PageView(
            controller: controller,
            children: _selectedPages as List<Widget>,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          ActionButtons(),
        ],
      ),
    );
  }
}
