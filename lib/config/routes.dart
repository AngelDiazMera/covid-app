import 'package:covserver/pages/qr_scanner/general_code_scan_page.dart';
import 'package:covserver/pages/symptoms_temporal/symptoms_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'package:covserver/pages/infected/infected_page.dart';
import 'package:covserver/pages/login/login_page.dart';
import 'package:covserver/pages/register/register_page.dart';
import 'package:covserver/pages/home_page/home_page.dart';
import 'package:covserver/pages/new_user/new_user_page.dart';

import 'package:covserver/services/auth/my_user.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  var homePage = HomePage(
    changeToDarkMode: () {
      EasyDynamicTheme.of(context).changeTheme();

      bool isDark = Theme.of(context).brightness == Brightness.dark;
      MyUser.setTheme(isDark);
    },
  );
  return {
    '/': (BuildContext context) => homePage,
    '/new_user': (BuildContext context) => NewUserPage(),
    '/signup': (BuildContext context) => RegisterPage(),
    '/signin': (BuildContext context) => LoginPage(),
    '/infected': (_) => InfectedPage(),
    '/qr': (_) => GeneralCodeScan(),
    '/symptoms_register': (_) => SymptomsPage()
  };
}
