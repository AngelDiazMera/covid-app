import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:persistencia_datos/models/my_user.dart';
import 'package:persistencia_datos/models/user.dart';
import 'package:persistencia_datos/pages/my_account.dart';
import 'package:persistencia_datos/pages/new_user_page.dart';
import 'package:persistencia_datos/pages/settings_page.dart';
import 'package:persistencia_datos/widgets/custom_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Function changeToDarkMode;

  const HomePage({Key key, @required this.changeToDarkMode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(this.changeToDarkMode);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool _isNew = false;
  bool _loading = true;
  static List<Widget> _selectedPages = <Widget>[];
  User myUser;

  _HomePageState(Function changeToDarkMode) {
    _selectedPages = <Widget>[
      Container(child: Text('Sintomas')),
      MyAccountPage(changeToDarkMode: changeToDarkMode),
      SettingsPage(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    print('Es nuevo? $_isNew');
  }

  _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    bool tempDark = await MyUser.getTheme();
    setState(() {
      myUser = tempUser;
      _isNew = myUser.name == '';
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Scaffold();
    return _drawHomeBody(context);
  }

  Widget _drawHomeBody(BuildContext context) {
    final PageController controller =
        PageController(initialPage: _selectedIndex);

    if (_isNew) return NewUserPage();

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
      // _selectedPages.elementAt(_selectedIndex),
      bottomNavigationBar: CustomButtonNavigationBar(
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
            controller.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
