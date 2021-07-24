import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'package:persistencia_datos/pages/infected/infected_page.dart';
import 'package:persistencia_datos/pages/login/login_page.dart';
import 'package:persistencia_datos/pages/register/register_page.dart';
import 'package:persistencia_datos/pages/home_page/home_page.dart';
import 'package:persistencia_datos/pages/new_user/new_user_page.dart';

import 'package:persistencia_datos/services/auth/my_user.dart';

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
    '/infected': (_) => InfectedPage()
  };
}
