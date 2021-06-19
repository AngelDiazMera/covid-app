import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistencia_datos/models/my_user.dart';

import 'package:persistencia_datos/pages/home_page.dart';
import 'package:persistencia_datos/pages/new_user_page.dart';
import 'package:persistencia_datos/theme/theme.dart';

void main() {
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      },
    );
  }
}
