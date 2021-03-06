import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/models/favoriteDAO.dart';
import 'package:flutter_login/src/models/trendingDAO.dart';

class CardTrending extends StatelessWidget {
  const CardTrending({Key key, @required this.trending}) : super(key: key);
  final Result2 trending;
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
                    'https://image.tmdb.org/t/p/w500/${trending.backdropPath}'),
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
                      trending.title,
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'popularity': trending.popularity,
                          'voteCount': trending.voteCount,
                          'video': trending.video,
                          'posterPath': trending.posterPath,
                          'id': trending.id,
                          'backdropPath': trending.backdropPath,
                          'title': trending.title,
                          'voteAverage': trending.voteAverage,
                          'overview': trending.overview,
                          'releaseDate': trending.releaseDate,
                        });
                      },
                    )
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
