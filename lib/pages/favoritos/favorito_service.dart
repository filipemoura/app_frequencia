import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_dao.dart';
import 'package:app_frequencia/pages/favoritos/favorito.dart';
import 'package:app_frequencia/pages/favoritos/favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro carro) async {
    Favorito favorito = Favorito.fromCarro(carro);
    final dao = FavoritoDao();

    final bool exists = await dao.exists(favorito.id);

    if(exists) {
      dao.delete(favorito.id);
      return false;
    } else {
      dao.save(favorito);
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