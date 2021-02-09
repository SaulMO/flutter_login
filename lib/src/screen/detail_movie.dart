import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/castDAO.dart';
import 'package:flutter_login/src/models/favoriteDAO.dart';
import 'package:flutter_login/src/models/videoDAO.dart';
import 'package:flutter_login/src/network/api_cast.dart';
import 'package:flutter_login/src/network/api_movie_video.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final DataBaseHelper _database = DataBaseHelper();

class DetailMovie extends StatelessWidget {
  const DetailMovie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    ApiMovieVideo apiMovieVideo = ApiMovieVideo(id: movie['id'].toString());
    ApiMovieCast apiMovieCast = ApiMovieCast(id: movie['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
        backgroundColor: Configuration.colorApp,
        actions: <Widget>[
          MaterialButton(
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () async {
              FavoriteDAO favoriteDAO = FavoriteDAO(
                  posterPath: movie['posterPath'],
                  backdropPath: movie['backdropPath'],
                  title: movie['title'],
                  adult: 0,
                  voteAverage: 10.0,
                  overview: movie['overview'],
                  releaseDate: movie['releaseDate'],
                  favorite: 1);
              await _database.insertar(favoriteDAO.toJSON(), 'tbl_favoritas');
              final snackbar = SnackBar(
                content: Text('Agregada a Favoritos'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ),
              );
            },
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(1), BlendMode.dstATop),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie['posterPath']}'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Card(
            color: Colors.black.withOpacity(0.7),
            margin: EdgeInsets.fromLTRB(05, 05, 05, 05), //left,top,right,bottom
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  //Trailer
                  Row(
                    children: <Widget>[
                      Icon(Icons.tv, color: Colors.white),
                      Text(
                        ' Trailer',
                        style: GoogleFonts.openSansCondensed(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white),
                  //Description
                  Row(
                    children: <Widget>[
                      Icon(Icons.description, color: Colors.white),
                      Text(
                        ' Overview',
                        style: GoogleFonts.openSansCondensed(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    '${movie['overview']}',
                    style: GoogleFonts.openSansCondensed(color: Colors.white),
                  ),
                  Divider(color: Colors.white),
                  //Release Date
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white),
                      Text(
                        ' Release Date',
                        style: GoogleFonts.openSansCondensed(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${movie['releaseDate']}',
                    style: GoogleFonts.openSansCondensed(color: Colors.white),
                  ),
                  Divider(color: Colors.white),
                  //Casting
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      Text(
                        ' Casting',
                        style: GoogleFonts.openSansCondensed(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listViewVideos(List<Result> videos) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Result video = videos[index];
        YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: video.key,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
            loop: true,
            isLive: true,
          ),
        );
        return YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        );
      },
      itemCount: 2,
    );
  }

  Widget _listViewCast(List<Cast> casts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Cast cast = casts[index];
        return CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(
              'https://image.tmdb.org/t/p/w500/' + cast.profilePath),
          backgroundColor: Colors.transparent,
        );
      },
      itemCount: 2,
    );
  }
}
