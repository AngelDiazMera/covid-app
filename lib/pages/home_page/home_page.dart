import 'package:flutter/material.dart';

import 'package:persistencia_datos/services/auth/my_user.dart';
import 'package:persistencia_datos/models/user.dart';

import 'package:persistencia_datos/pages/my_account/my_account.dart';
import 'package:persistencia_datos/pages/new_user/new_user_page.dart';

import 'package:persistencia_datos/pages/home_page/widgets/custom_bottom_nav.dart';

import '../my_settings/my_account_settings_page.dart';

class HomePage extends StatefulWidget {
  // Callback to change the theme
  final Function changeToDarkMode;

  const HomePage({Key key, @required this.changeToDarkMode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(this.changeToDarkMode);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Selected page of PageView
  bool _isNew = false; // Is the user register?
  bool _loading = true; // When data is retrieved, changes to false
  static List<Widget> _selectedPages = <Widget>[];
  User myUser; // Stored user

  _HomePageState(Function changeToDarkMode);

  // Load preferences of the user
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Gets the user from the preferences
  _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    setState(() {
      myUser = tempUser;
      _isNew = tempUser.name == '';
      _loading = false;
    });
  }

  // BUILD method
  @override
  Widget build(BuildContext context) {
    if (_loading) return Scaffold();
    return _drawHomeBody(context);
  }

  // Body of the page
  Widget _drawHomeBody(BuildContext context) {
    final PageController controller =
        PageController(initialPage: _selectedIndex);
    // If the user is not registered, draws the Welcome page
    if (_isNew) return NewUserPage();
    _selectedPages = <Widget>[
      Container(child: Text('Sintomas')),
      MyAccountPage(changeToDarkMode: widget.changeToDarkMode),
      SettingsPage(newUser: myUser),
    ];
    // Page of the user
    return Scaffold(
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _selectedPages,
      ),
      bottomNavigationBar: CustomButtonNavigationBar(
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
            controller.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          });
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}