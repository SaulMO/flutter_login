import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/models/trendingDAO.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'package:flutter_login/src/views/card_trending.dart';

class Trending extends StatefulWidget {
  const Trending({Key key}) : super(key: key);
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  ApiMovies apiMovies;
  @override
  void initState() {
    super.initState();
    apiMovies = ApiMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Configuration.colorApp,
        title: Text('Trending Movies'),
      ),
      body: FutureBuilder(
        future: apiMovies.getTrending(),
        builder: (BuildContext context, AsyncSnapshot<List<Result2>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error at request time ;('));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listViewTrending(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listViewTrending(List<Result2> movies) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Result2 trending = movies[index];
        return CardTrending(trending: trending);
      },
      itemCount: 20,
    );
  }
}
