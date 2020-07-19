import 'package:app_frequencia/pages/login/login_page.dart';
import 'package:app_frequencia/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashPage(),
    );
  }
}