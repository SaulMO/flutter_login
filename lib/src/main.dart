import 'package:flutter/material.dart';
import 'package:flutter_login/src/screen/Dashboard.dart';
import 'package:flutter_login/src/screen/Profile.dart';
import 'package:flutter_login/src/screen/Search.dart';
import 'package:flutter_login/src/screen/Favourites.dart';
import 'package:flutter_login/src/screen/Login.dart';
import 'package:flutter_login/src/screen/trending.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/trending': (BuildContext context) => Trending(),
        '/favourites': (BuildContext context) => Favourites(),
        '/profile': (BuildContext context) => Profile(),
        '/search': (BuildContext context) => Search(),
        '/login': (BuildContext context) => Login(),
        '/dashboard': (BuildContext context) => Dashboard()
      },
    );
  }
}

/*
class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _token;

  Future<void> _obtener_token() async {
    final SharedPreferences prefs = await _prefs;
    final String token = (prefs.getString('token') ?? "empty");
    _token = prefs.setString("token", token).then((bool success) {
      return token;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_token == "empty" || _token == null) {
      return MaterialApp(
        routes: {
          '/trending': (BuildContext context) => Trending(),
          '/favourites': (BuildContext context) => Favourites(),
          '/profile': (BuildContext context) => Profile(),
          '/search': (BuildContext context) => Search(),
          '/login': (BuildContext context) => Login(),
          '/dashboard': (BuildContext context) => Dashboard(),
        },
        home: Login(),
      );
    } else {
      return MaterialApp(
        routes: {
          '/trending': (BuildContext context) => Trending(),
          '/favourites': (BuildContext context) => Favourites(),
          '/profile': (BuildContext context) => Profile(),
          '/search': (BuildContext context) => Search(),
          '/login': (BuildContext context) => Login(),
        },
        home: Dashboard(),
      );
    }
    /*return MaterialApp(
      routes: {
        '/trending': (BuildContext context) => Trending(),
        '/favourites': (BuildContext context) => Favourites(),
        '/profile': (BuildContext context) => Profile(),
        '/search': (BuildContext context) => Search(),
      },
    );*/
  }
}*/
