import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:flutter_login/src/models/videoDAO.dart';

class ApiMovieVideo {
  String url;
  String idPelicula;
  Client http = Client();

  ApiMovieVideo({String id}) {
    this.idPelicula = id;
    //"https://api.themoviedb.org/3/movie/602211/videos?api_key=632febd594b02e1f0f33532ce968dd01&language=en-US&page=1"
    this.url = 'https://api.themoviedb.org/3/movie/' +
        idPelicula +
        '/videos?api_key=632febd594b02e1f0f33532ce968dd01&language=en-US&page=1';
  }

  Future<List<Result>> getMovieVideo() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var movieVideo = jsonDecode(response.body)['results'] as List;
      List<Result> moviesVideosList =
          movieVideo.map((e) => Result.fromJSON(e)).toList();
      return moviesVideosList;
    } else {
      return null;
    }
  }
}
