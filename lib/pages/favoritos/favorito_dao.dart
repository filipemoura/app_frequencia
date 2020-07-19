import 'package:app_frequencia/utils/sql/base_dao.dart';
import 'package:app_frequencia/pages/favoritos/favorito.dart';

class FavoritoDao extends BaseDAO<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}