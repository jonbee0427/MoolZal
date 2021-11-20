// 21-2 MAD Project (MoolZal)
// 21700339 Jonghyun Baek
// 21700557 Eunji Lee
// 21900318 Chanyoung Park

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moolzal/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MoolZalApp());
}
