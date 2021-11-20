import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class MoolZalApp extends StatelessWidget {
  const MoolZalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoolZal',
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => const LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const LoginPage(),
      fullscreenDialog: true,
    );
  }
}

