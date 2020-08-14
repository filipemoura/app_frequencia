import 'package:app_frequencia/main.dart';
import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_dao.dart';
import 'package:app_frequencia/pages/favoritos/favorito.dart';
import 'package:app_frequencia/pages/favoritos/favorito_bloc.dart';
import 'package:app_frequencia/pages/favoritos/favorito_dao.dart';
import 'package:provider/provider.dart';

class FavoritoService {
  static Future<bool> favoritar(context, Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro);
    final dao = FavoritoDao();

    final bool exists = await dao.exists(favorito.id);

    if(exists) {
      dao.delete(favorito.id);
      Provider.of<FavoritoBloc>(context, listen: false).loadData();
      return false;
    } else {
      dao.save(favorito);
      Provider.of<FavoritoBloc>(context, listen: false).loadData();
      return true;
    }
  }

  static Future<List<Carro>> getCarros() {
    return  CarroDAO().query('select * from carro c, favorito f where c.id = f.id');
  }

  static isFavorito(carro) {
    final dao = FavoritoDao();
    return dao.exists(carro.id);
  }
}