import 'dart:async';

import 'package:app_frequencia/pages/api_response.dart';
import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_api.dart';
import 'package:app_frequencia/pages/carro/carro_form_page.dart';
import 'package:app_frequencia/pages/favoritos/favorito_service.dart';
import 'package:app_frequencia/utils/alert.dart';
import 'package:app_frequencia/utils/event_bus.dart';
import 'package:app_frequencia/utils/nav.dart';
import 'package:app_frequencia/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  Color color = Colors.grey;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(widget.carro).then((bool favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopUpMenu(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(widget.carro.urlFoto ??
              "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Tucker.png"),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(
              widget.carro.nome,
              fontSize: 20,
              bold: true,
            ),
            text(
              widget.carro.tipo,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
          ],
        )
      ],
    );
  }

  _onClickMapa() {}

  _onClickVideo() {}

  _onClickPopUpMenu(String value) {
    switch (value) {
      case "Editar":
        push(context, CarroFormPage(carro: widget.carro));
        break;
      case "Deletar":
        deletar();
        break;
      case "Share":
        print("Share!");
        break;
    }
  }

  _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(context, widget.carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(
          widget.carro.descricao,
          bold: true,
        ),
        SizedBox(
          height: 5,
        ),
        text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
      ],
    );
  }

  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(widget.carro);
    if (response.ok) {
      alert(context, "Carro deletado com sucesso", callback: () {
        EventBus.get(context).sendEvent("carro deletado");
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }
}
