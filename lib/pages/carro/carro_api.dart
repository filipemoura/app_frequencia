import 'dart:convert' as convert;
import 'package:app_frequencia/pages/api_response.dart';
import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/carro_dao.dart';
import 'package:app_frequencia/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';

    var response = await http.get(url, headers: headers);

    print("GET >> $url");

    String json = response.body;
    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro car) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    print("POST >> $url");

    String json = car.toJson();

    var response = await http.post(url, body: json, headers: headers);

    if (response.statusCode == 201) {
      Map mapResponse = convert.json.decode(response.body);
      Carro carro = Carro.fromMap(mapResponse);
      return ApiResponse.ok(true);
    }

    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }
}