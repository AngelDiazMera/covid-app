import 'package:covserver/services/providers/new_user_provider.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:covserver/services/api/requests.dart';
import 'package:covserver/services/auth/my_user.dart';
import 'package:covserver/models/user.dart';
import 'package:covserver/config/theme.dart';

import 'package:covserver/pages/my_account/my_account.dart';
import 'package:covserver/pages/new_user/new_user_page.dart';
import 'package:covserver/pages/home_page/widgets/custom_bottom_nav.dart';
import 'package:covserver/pages/home_page/widgets/alert_no_internet.dart';
import 'package:covserver/pages/infected/infected_page.dart';
import 'package:covserver/widgets/violet_background.dart';
import 'package:provider/provider.dart';

import '../my_settings/my_account_settings_page.dart';

class HomePage extends StatefulWidget {
  // Callback to change the theme
  final Function changeToDarkMode;

  const HomePage({Key? key, required this.changeToDarkMode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(this.changeToDarkMode);
}

class _HomePageState extends State<HomePage> {
  // State variables due to the Page View
  int _selectedIndex = 1; // Selected page of PageView
  static List<Widget> _selectedPages = <Widget>[];
  // State variables of the widget
  bool _loading = true; // When data is retrieved, changes to false
  User? myUser; // Stored user

  bool _requestMade = false;

  _HomePageState(Function changeToDarkMode);

  /// Load preferences of the user
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _getDataByAPI() async {
    if (_requestMade) return;
    bool hasError = false;
    User? tempUser = await getMyData(onError: (String err) => hasError = true);

    if (hasError) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            AlertNoInternet(onAccepted: () => setState(() => _loading = false)),
      );
      return;
    }
    if (tempUser != null) setState(() => myUser = tempUser);
    setState(() {
      _loading = false;
      _requestMade = true;
    });
  }

  /// Gets the user from the preferences
  _loadPreferences() async {
    User tempUser = await MyUser.mine.getMyUser();
    bool isNew = tempUser.email == '';
    setState(() {
      myUser = tempUser;
    });
    // Ensure that the theme will always be light at the beginning
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.system && isNew)
      EasyDynamicTheme.of(context).changeTheme();

    print('ES NUEVO USUARIO? $isNew');

    if (!isNew)
      await _getDataByAPI();
    else
      setState(() => _loading = false);
  }

  /// BUILD method
  @override
  Widget build(BuildContext context) {
    final newUserHandler = Provider.of<NewUserHandler>(context);

    if (!_loading) {
      return _drawHomeBody(context, newUserHandler);
    }
    return Scaffold(
      body: Stack(
        children: [
          VioletBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SpinKitCubeGrid(
                  color: applicationColors['input_light'],
                  size: 64,
                ),
              ),
              SizedBox(height: 35),
              Image(
                image: AssetImage('assets/covserver_text.png'),
                width: 275,
              ),
              SizedBox(height: 10),
              Text(
                'Cargando...',
                style: TextStyle(
                    color: applicationColors['input_light']!.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Draws the body of this page of the page
  Widget _drawHomeBody(BuildContext context, NewUserHandler newUserHandler) {
    final PageController controller =
        PageController(initialPage: _selectedIndex);
    // If the user is not registered, draws the Welcome page
    if (newUserHandler.isNew && myUser!.email == '') return NewUserPage();
    _getDataByAPI();
    _selectedPages = <Widget>[
      InfectedPage(),
      MyAccountPage(changeToDarkMode: widget.changeToDarkMode),
      SettingsPage(),
    ];
    // Page of the user
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: _selectedPages,
          onPageChanged: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        _drawNavigation(controller)
      ]),
    );
  }

  Widget _drawNavigation(PageController controller) => SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomButtonNavigationBar(
            onItemTapped: (int index) {
              setState(() {
                _selectedIndex = index;
                controller.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            selectedIndex: _selectedIndex,
          ),
        ),
      );
}
