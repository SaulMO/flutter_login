import 'package:flutter/material.dart';
import 'package:flutter_login/src/screen/Profile.dart';
import 'package:flutter_login/src/screen/Search.dart';
import 'package:flutter_login/src/screen/Favourites.dart';
import 'package:flutter_login/src/screen/Login.dart';
import 'package:flutter_login/src/screen/trending.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/trending': (BuildContext context) => Trending(),
        '/favourites': (BuildContext context) => Favourites(),
        '/profile': (BuildContext context) => Profile(),
        '/search': (BuildContext context) => Search(),
      },
      home: Login(),
    );
  }
}
