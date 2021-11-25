// 21-2 MAD Project (MoolZal)
// 21700339 Jonghyun Baek
// 21700557 Eunji Lee
// 21900318 Chanyoung Park

import 'package:flutter/material.dart';
import 'package:moolzal/myprofile.dart';
import 'package:moolzal/mycomment.dart';
import 'package:moolzal/myfavorite.dart';
import 'package:moolzal/mypost.dart';
import 'package:moolzal/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoolZal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
      routes:{
        '/profile': (context) => myprofile(),
        '/mycomment': (context) => mycomment(),
        '/myfavorite': (context) => myfavorite(),
        '/mypost': (context) => mypost(),
        '/search': (context) => search(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MoolZal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: const Text('MoolZal'),
                onPressed:() {
                  Navigator.pushNamed(context, '/profile');
                }
            ),
          ],
        ),
      ),
    );
  }
}
