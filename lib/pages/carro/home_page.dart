import 'package:app_frequencia/drawerList.dart';
import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_api.dart';
import 'package:app_frequencia/pages/carro/carro_form_page.dart';
import 'package:app_frequencia/pages/carro/carro_listView.dart';
import 'package:app_frequencia/pages/favoritos/favorito_page.dart';
import 'package:app_frequencia/utils/nav.dart';
import 'package:app_frequencia/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 4, vsync: this);

    int tabIdx = await Prefs.getInt("tabIdx");

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Esportivos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Favoritos",
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
          FavoritoPage(),
        ],
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAddCarro,
      ),
    );
  }

  _onClickAddCarro() {
    push(context, CarroFormPage());
  }
}
