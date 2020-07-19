import 'package:app_frequencia/pages/carro/home_page.dart';
import 'package:app_frequencia/utils/sql/db_helper.dart';
import 'package:app_frequencia/pages/login/login_page.dart';
import 'package:app_frequencia/pages/login/usuario.dart';
import 'package:app_frequencia/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future futureDb = DatabaseHelper.getInstance().db;
    Future futureDelay = Future.delayed(Duration(seconds: 3));
    Future<Usuario> futureUser = Usuario.get();

    Future.wait([futureDb, futureDelay, futureUser]).then((List values) {
      Usuario user = values[2];

      if(user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
