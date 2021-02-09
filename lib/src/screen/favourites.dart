import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/favoriteDAO.dart';
import 'package:flutter_login/src/models/trendingDAO.dart';
import 'package:flutter_login/src/views/cardFavorites.dart';
import 'package:flutter_login/src/views/card_trending.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  DataBaseHelper _database;

  @override
  void initState() {
    super.initState();
    _database = DataBaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Configuration.colorApp,
        title: Text('Favourites Movies'),
      ),
      body: FutureBuilder(
        future: getFavoritas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<FavoriteDAO>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error at request time ;('));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listViewFavorites(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _listViewFavorites(List<FavoriteDAO> movies) {
    return ListView.builder(
      itemBuilder: (context, index) {
        FavoriteDAO favoritos = movies[index];
        return CardFavoritos(favoritos: favoritos);
      },
      itemCount: 20,
    );
  }

  Future<List<FavoriteDAO>> getFavoritas() async {
    List<FavoriteDAO> moviesList = await _database.getPeliculas();
    return moviesList;
  }
}
