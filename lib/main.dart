import 'package:flutter/material.dart';
import 'package:login_screen_1/screens/login_screen.dart';
import 'package:login_screen_1/util/estimateRequest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: EstimateRequest(),
    );
  }
}
