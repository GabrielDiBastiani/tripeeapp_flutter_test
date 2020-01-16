import 'package:flutter/material.dart';
import 'package:login_screen_1/screens/login_screen.dart';
import 'package:login_screen_1/util/request.dart';
// import 'package:http/http.dart' as http;

void main() => runApp(Request());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


