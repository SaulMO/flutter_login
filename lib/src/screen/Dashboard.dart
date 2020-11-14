import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/network/api_movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);
  actualizarPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", "empty");
  }

  Future checarPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString("token") ?? "empty");
  }

  @override
  Widget build(BuildContext context) {
    DataBaseHelper dataBaseHelper = DataBaseHelper();
    Future<UserDAO> _objUser =
        dataBaseHelper.getUsuario('saulmondragonortega@gmail.com');
    ApiMovies apiMovies = ApiMovies();
    apiMovies.getTrending();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Configuration.colorApp,
          title: Text('Películas'),
        ),
        drawer: Drawer(
          child: FutureBuilder(
              future: _objUser,
              builder: (BuildContext context, AsyncSnapshot<UserDAO> snapshot) {
                return ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Configuration.colorApp,
                      ),
                      currentAccountPicture: snapshot.data == null
                          ? CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  'https://thispersondoesnotexist.com/image'),
                              backgroundColor: Colors.transparent,
                            )
                          : ClipOval(
                              child: Image.file(File('snapshot.data.foto'),
                                  fit: BoxFit.cover),
                            ),
                      accountName: Text('Saúl Mondragón Ortega JR Programmer'),
                      accountEmail: Text('saulmondragonortega@gmail.com'),
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

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
