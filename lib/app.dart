import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistencia_datos/pages/register/register_page.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';

import 'package:persistencia_datos/pages/home_page/home_page.dart';
import 'package:persistencia_datos/pages/new_user/new_user_page.dart';

import 'config/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(53, 66, 235, 1),
        systemNavigationBarColor: Colors.black87,
        statusBarBrightness: Brightness.light,
      ),
    );

    // Ensure that the theme will always be light at the beginning
    if (EasyDynamicTheme.of(context).themeMode == ThemeMode.system)
      EasyDynamicTheme.of(context).changeTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid App',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomePage(
              changeToDarkMode: () {
                EasyDynamicTheme.of(context).changeTheme();

                bool isDark = Theme.of(context).brightness == Brightness.dark;
                MyUser.setTheme(isDark);
              },
            ),
        '/new_user': (BuildContext context) => NewUserPage(),
        '/signup': (BuildContext context) => RegisterPage(),
        // '/signin': (BuildContext context) => LoginPage(),
      },
    );
  }
}
