import 'dart:async';

import 'package:app_frequencia/pages/api_response.dart';
import 'package:app_frequencia/pages/carro/simple_bloc.dart';
import 'package:app_frequencia/pages/login/login_api.dart';
import 'package:app_frequencia/pages/login/usuario.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    add(false);

    return response;
  }
}