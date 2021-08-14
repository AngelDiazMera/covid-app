import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persistencia_datos/pages/infected/infected_page.dart';
import 'package:persistencia_datos/pages/login/login_page.dart';
import 'package:persistencia_datos/pages/register/register_page.dart';
import 'package:persistencia_datos/services/auth/my_user.dart';

import 'package:persistencia_datos/pages/home_page/home_page.dart';
import 'package:persistencia_datos/pages/new_user/new_user_page.dart';
import 'package:persistencia_datos/services/firebase/push_notification_service.dart';

import 'config/theme/theme.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State variables to navigate to a page and send args when a
  // notification is tapped
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // Context!
    PushNotificationService.messageStream.listen((message) {
      // print('MyApp: $message');
      // Push to the infected page with the args of the push notification
      navigatorKey.currentState.pushNamed('/infected', arguments: message);
      // Show the snackbar into this context
      final snackBar = SnackBar(content: Text('Hubo un infectado'));
      messengerKey.currentState.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the theme of the elments of the OS
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(53, 66, 235, 1),
        systemNavigationBarColor: Colors.black87,
        statusBarBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      // General
      debugShowCheckedModeBanner: false,
      title: 'Covid App',
      // Theme
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      // Redirection by notifications
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      // Routes definition
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
        '/signin': (BuildContext context) => LoginPage(),
        '/infected': (_) => InfectedPage()
      },

      localizationsDelegates: [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
