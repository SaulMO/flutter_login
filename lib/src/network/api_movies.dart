import 'dart:convert';
import 'package:flutter_login/src/models/trendingDAO.dart';
import 'package:http/http.dart' show Client;

class ApiMovies {
  final String URL_TRENDING =
      "https://api.themoviedb.org/3/movie/popular?api_key=632febd594b02e1f0f33532ce968dd01&language=en-US&page=1";
  Client http = Client();

  Future<List<Result2>> getTrending() async {
    final response = await http.get(URL_TRENDING);
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['results'] as List;
      List<Result2> moviesList =
          movies.map((movie) => Result2.fromJSON(movie)).toList();
      return moviesList;
    } else {
      return null;
    }
  }
}
