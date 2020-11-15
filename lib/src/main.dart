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

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  InicioState createState() => InicioState();
  /*
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
      home: Login(),
    );
  }*/
}

class InicioState extends State<MyApp> {
  String _token;
  String _email;
  String _contrasena;

  @override
  void initState() {
    super.initState();
    _obtenerTodo();
    /*_token = _prefs.then((SharedPreferences preferences) async {
      return (preferences.getString('token'));
    });
    _email = _prefs.then((SharedPreferences preferences) async {
      return (preferences.getString('email'));
    });
    _contrasena = _prefs.then((SharedPreferences preferences) async {
      return (preferences.getString('contrasena'));
    });*/
  }

  _obtenerTodo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('token');
    _email = _prefs.getString('email');
    _contrasena = _prefs.getString('contrasena');
  }

  @override
  Widget build(BuildContext context) {
    print("TOKEN");
    print(_token);
    print("E-MAIL");
    print(_email);
    print("TOKEN");
    print(_contrasena);
    return MaterialApp(
      routes: {
        '/trending': (BuildContext context) => Trending(),
        '/favourites': (BuildContext context) => Favourites(),
        '/profile': (BuildContext context) => Profile(),
        '/search': (BuildContext context) => Search(),
        '/login': (BuildContext context) => Login(),
        '/dashboard': (BuildContext context) => Dashboard()
      },
      home: ((_token == "empty" || _token == null) ? Login() : Dashboard()),
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
