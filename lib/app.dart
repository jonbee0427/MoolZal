import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moolzal/category.dart';
import 'package:moolzal/layout.dart';
import 'package:moolzal/myprofile.dart';
import 'package:moolzal/mycomment.dart';
import 'package:moolzal/myfavorite.dart';
import 'package:moolzal/mypost.dart';
import 'package:moolzal/search.dart';
import 'package:moolzal/login.dart';

class MoolZalApp extends StatelessWidget {
  const MoolZalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoolZal',
      home: SplashScreen(),
      //initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/category': (context) => Category(),
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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState () => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 2), value: 0.1, vsync: this, );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.bounceInOut);

    _controller!.forward();
    super.initState();
    Timer(Duration(seconds: 3),
            ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
          fit: StackFit.expand,
          children:<Widget>[
            //Image( image: AssetImage("background.png"), fit: BoxFit.cover, colorBlendMode: BlendMode.darken, ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScaleTransition(
                    scale: _animation!,
                    child: Image.asset('moolzal.png', width: 250,)
                ),
              ],
            ),]
      ),
    );
  }
}
