import 'package:app_frequencia/pages/login/login_page.dart';
import 'package:app_frequencia/pages/login/usuario.dart';
import 'package:app_frequencia/utils/nav.dart';
import 'package:app_frequencia/utils/prefs.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot) {
                Usuario user = snapshot.data;
                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Idioma"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
            accountName: Text(user.nome),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.urlFoto),
            ),
          );
  }

  _onClickLogout(BuildContext context) {
    pop(context);
    Prefs.setString("user.prefs", null);
    push(context, LoginPage(), replace: true);
  }
}