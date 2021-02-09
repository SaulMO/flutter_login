import 'package:flutter/material.dart';
import 'package:flutter_login/src/screen/login.dart';
import 'package:splashscreen/splashscreen.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: Login(), //Login(),
      title: Text('Bienvenido'),
      image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      gradientBackground: LinearGradient(
          colors: [Colors.white, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      loaderColor: Colors.red,
    );
  }
}
