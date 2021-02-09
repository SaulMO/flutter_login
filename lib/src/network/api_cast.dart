import 'dart:convert';
import 'package:flutter_login/src/models/castDAO.dart';
import 'package:http/http.dart' show Client;

class ApiMovieCast {
  String url;
  String idPelicula;
  Client http = Client();

  ApiMovieCast({String id}) {
    this.idPelicula = id;
    //"https://api.themoviedb.org/3/movie/602211/videos?api_key=632febd594b02e1f0f33532ce968dd01&language=en-US&page=1"
    this.url = 'https://api.themoviedb.org/3/movie/' +
        idPelicula +
        '/credits?api_key=632febd594b02e1f0f33532ce968dd01&language=en-US&page=1';
  }

  Future<List<Cast>> getMovieCast() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var movieCast = jsonDecode(response.body)['cast'] as List;
      List<Cast> moviesCastList =
          movieCast.map((e) => Cast.fromMap(e)).toList();
      return moviesCastList;
    } else {
      return null;
    }
  }
}
