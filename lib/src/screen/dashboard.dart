import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);
  Widget imagePath;

  actualizarPreferencias() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", "empty");
    await preferences.setString("usuario", "");
  }

  Future<UserDAO> getUsuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map usuarioMapeado = jsonDecode(preferences.getString('usuario'));
    UserDAO usuarioReturn = UserDAO.fromJSON(usuarioMapeado);
    imagePath = (usuarioReturn.foto == null || usuarioReturn.foto == "")
        ? CircleAvatar(
            radius: 35,
            backgroundImage:
                NetworkImage('https://thispersondoesnotexist.com/image'),
            backgroundColor: Colors.transparent,
          )
        : ClipOval(
            child: Image.file(File(usuarioReturn.foto), fit: BoxFit.cover),
          );

    return UserDAO.fromJSON(usuarioMapeado);
  }

  @override
  Widget build(BuildContext context) {
    DataBaseHelper dataBaseHelper = DataBaseHelper();
    ApiMovies apiMovies = ApiMovies();
    apiMovies.getTrending();
    Future<UserDAO> usuario = getUsuario();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Configuration.colorApp,
          title: Text('Películas'),
        ),
        drawer: Drawer(
          child: FutureBuilder(
              future: usuario,
              builder: (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
                return ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Configuration.colorApp,
                      ),
                      currentAccountPicture: imagePath,
                      /*(snapshot.data.foto == null ||
                              snapshot.data.foto ==
                                  'https://thispersondoesnotexist.com/image')
                          ? CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  'https://thispersondoesnotexist.com/image'),
                              backgroundColor: Colors.transparent,
                            )
                          : ClipOval(
                              child: Image.file(File('snapshot.data.foto'),
                                  fit: BoxFit.cover),
                            ),*/
                      accountName: Text(snapshot.data != null
                          ? "${snapshot.data.nomUser} ${snapshot.data.apepUser}"
                          : "NO DATA"),
                      accountEmail: Text(snapshot.data != null
                          ? "${snapshot.data.mailUser}"
                          : "NO DATA"),
                      onDetailsPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      title: Text('Trending'),
                      leading: Icon(
                        Icons.trending_up,
                        color: Configuration.colorItem,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/trending');
                      },
                    ),
                    ListTile(
                      title: Text('Favourites'),
                      leading: Icon(
                        Icons.favorite_border_outlined,
                        color: Configuration.colorItem,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/favourites');
                      },
                    ),
                    ListTile(
                      title: Text('Search'),
                      leading: Icon(
                        Icons.search,
                        color: Configuration.colorItem,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                    ListTile(
                      title: Text('Profile'),
                      leading: Icon(
                        Icons.edit,
                        color: Configuration.colorItem,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      title: Text('Sign out'),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Configuration.colorItem,
                      ),
                      onTap: () {
                        actualizarPreferencias();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
/*
class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/
