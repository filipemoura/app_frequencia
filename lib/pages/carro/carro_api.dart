import 'dart:convert' as convert;
import 'dart:io';
import 'package:app_frequencia/pages/api_response.dart';
import 'package:app_frequencia/pages/carro/carro.dart';
import 'package:app_frequencia/pages/carro/upload_api.dart';
import 'package:app_frequencia/utils/http_helper.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipoCarro) async {
    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';

    var response = await http.get(url);

    print("GET >> $url");

    String json = response.body;
    List list = convert.json.decode(json);

    final carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro car, File file) async {
    try {
      if (file != null) {
        ApiResponse<String> response = await UploadApi.upload(file);
        if (response.ok) {
          String urlFoto = response.result;
          car.urlFoto = urlFoto;
        }
      }

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (car.id != null) {
        url += "/${car.id}";
      }

      print("POST >> $url");

      String json = car.toJson();

      var response = await (car.id == null
          ? http.post(url, body: json)
          : http.put(url, body: json));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);
        Carro carro = Carro.fromMap(mapResponse);
        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro");
      }

      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível salvar o carro");
    }
  }

  static delete(Carro car) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${car.id}';

      print("DELETE >> $url");

      var response = await http.delete(url);

      print('Response status: ${response.statusCode}');
      print('Response status: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possível deletar o crro");
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível deletar o carro");
    }
  }
}
