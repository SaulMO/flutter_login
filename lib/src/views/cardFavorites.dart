import 'package:flutter/material.dart';
import 'package:flutter_login/src/models/favoriteDAO.dart';

class CardFavoritos extends StatelessWidget {
  const CardFavoritos({Key key, @required this.favoritos}) : super(key: key);
  final FavoriteDAO favoritos;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 5.0), blurRadius: 1.0)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${favoritos.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 100),
                //height: 180,
              ),
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                height: 55.0,
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      favoritos.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
