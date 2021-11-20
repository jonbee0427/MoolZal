import 'package:flutter/material.dart';
import 'package:moolzal/layout.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'login.dart';

class MoolZalApp extends StatelessWidget {
  const MoolZalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoolZal',
      home: Layout(),
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
