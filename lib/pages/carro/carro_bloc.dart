import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_api.dart';
import 'package:app_frequencia/pages/carro/simple_bloc.dart';
import 'package:app_frequencia/pages/carro/carro_dao.dart';
import 'package:app_frequencia/utils/network.dart';
import 'package:app_frequencia/widgets/text_error.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{
  Future<List<Carro>> loadData(String tipoCarro) async {
    try {
      bool networkOn = await isNetworkOn();

      if(!networkOn) {
        TextError("Verifique sua conexão.");
//        List<Carro> carros = await CarroDAO().findAllByTipo(tipoCarro);
//        add(carros);
//        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipoCarro);

      final dao = CarroDAO();
      carros.forEach(dao.save);

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}