import 'dart:io';

import 'package:http/http.dart' show Client;

class ApiLogin {
  final String ENDPOINT = "http://127.0.0.1:8888/login";
  Client httpClient = Client();

  Future<String> validar_usuario() async {}
}
