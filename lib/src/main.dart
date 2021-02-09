import 'package:flutter/material.dart';
import 'package:flutter_login/src/screen/dashboard.dart';
import 'package:flutter_login/src/screen/detail_movie.dart';
import 'package:flutter_login/src/screen/profile.dart';
import 'package:flutter_login/src/screen/search.dart';
import 'package:flutter_login/src/screen/favourites.dart';
import 'package:flutter_login/src/screen/login.dart';
import 'package:flutter_login/src/screen/trending.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<MyApp> {
  String token;
  Widget ventana;
  Future<SharedPreferences> _preferencias = SharedPreferences.getInstance();

  getToken() async {
    final SharedPreferences _prefs = await _preferencias;
    token = _prefs.getString('token' ?? " ");
    if (token == " ") {
      ventana = SplashScreen();
    } else {
      ventana = Dashboard();
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      //'/': (BuildContext context) => Login(),
      '/login': (BuildContext context) => new Login(),
      '/trending': (BuildContext context) => new Trending(),
      '/favourites': (BuildContext context) => new Favourites(),
      '/profile': (BuildContext context) => new Profile(),
      '/search': (BuildContext context) => new Search(),
      '/dashboard': (BuildContext context) => new Dashboard(),
      '/detail': (BuildContext context) => new DetailMovie()
    }, home: Dashboard());
  }
}
