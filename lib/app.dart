import 'package:flutter/material.dart';
import 'package:moolzal/category.dart';
import 'package:moolzal/layout.dart';
import 'package:moolzal/myprofile.dart';
import 'package:moolzal/mycomment.dart';
import 'package:moolzal/myfavorite.dart';
import 'package:moolzal/mypost.dart';
import 'package:moolzal/search.dart';

// import 'package:moolzal/layout.dart';
// import 'package:flutter/services.dart';

// import 'home.dart';
import 'login.dart';

class MoolZalApp extends StatelessWidget {
  const MoolZalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoolZal',
      home: Category(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/profile': (context) => myprofile(),
        '/mycomment': (context) => mycomment(),
        '/myfavorite': (context) => myfavorite(),
        '/mypost': (context) => mypost(),
        '/search': (context) => search(),
        '/layout': (context) => Layout(),
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
