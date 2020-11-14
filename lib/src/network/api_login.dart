import 'package:flutter_login/src/models/userDAO.dart';
import 'package:http/http.dart' show Client;

class ApiLogin {
  final String ENDPOINT = "http://192.168.1.65:8888/signup";
  Client httpClient = Client();
  Future<String> validar_usuario(UserDAO userDAO) async {
    final response = await httpClient.post('$ENDPOINT',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: userDAO.userToJSON());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
