import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_api.dart';
import 'package:app_frequencia/pages/carro/simple_bloc.dart';
import 'package:app_frequencia/pages/carro/carro_dao.dart';
import 'package:app_frequencia/pages/favoritos/favorito_service.dart';
import 'package:app_frequencia/utils/network.dart';
import 'package:app_frequencia/widgets/text_error.dart';

class FavoritoBloc extends SimpleBloc<List<Carro>>{
  Future<List<Carro>> loadData() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}