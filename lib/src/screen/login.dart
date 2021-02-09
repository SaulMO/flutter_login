import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/network/api_login.dart';
import 'package:flutter_login/src/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  ApiLogin httpLogin = ApiLogin();
  bool _mantenersesion = false;
  //Variable para controlar la visualización del indicador de progreso
  bool isValidating = false;
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  guardarPreferencias(String token, UserDAO user) async {
    final SharedPreferences preferences = await _preferences;
    String userJSON = jsonEncode(user.toJSON());
    await preferences.setString("usuario", userJSON);
    if (_mantenersesion) {
      await preferences.setString("token", token);
    } else {
      await preferences.setString("token", " ");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmailController = TextEditingController();
    TextEditingController txtPasswdController = TextEditingController();
    //final labelTest = Labe
    final logo = CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          'https://maryza.gnomio.com/pluginfile.php/2/course/section/1/logoTecNM.png'),
      backgroundColor: Colors.transparent,
    );
    final txtEmail = TextFormField(
      controller: txtEmailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "ejem@mail.com",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
    final txtPass = TextFormField(
      controller: txtPasswdController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'contraseña',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
    );
    final cajaRecordarSesion = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("NO"),
        Radio(
          value: false,
          groupValue: _mantenersesion,
          onChanged: (bool value) {
            setState(() {
              _mantenersesion = value;
            });
          },
        ),
        Text("SI"),
        Radio(
          value: true,
          groupValue: _mantenersesion,
          onChanged: (bool value) {
            setState(() {
              _mantenersesion = value;
            });
          },
        ),
      ],
    );

    final loginButton = RaisedButton(
      onPressed: () async {
        setState(() {
          isValidating = true;
        });
        //Con el pushReplacementNamed quita todo el login, es decir no va a poder regresar atras
        //Navigator.pushReplacementNamed(context, routeName)
        //Navigator.pushNamed(context, '/dashboard');
        UserDAO userDAO =
            UserDAO.login(txtEmailController.text, txtPasswdController.text);
        httpLogin.validar_usuario(userDAO).then((token) => {
              if (token != null)
                {
                  guardarPreferencias(token, userDAO),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()))
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Incorrect Credentials"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('close'),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        );
                      })
                }
            });
      },
      child: Text('Validar usuario', style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color.fromRGBO(67, 67, 67, 1),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.fitHeight)),
        ),
        Card(
            margin: EdgeInsets.all(15.0),
            color: Colors.white70,
            elevation: 8.0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  txtEmail,
                  SizedBox(height: 10),
                  txtPass,
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text("Mantener Sesión Iniciada?")],
                  ),
                  cajaRecordarSesion,
                  loginButton,
                ],
              ),
            )),
        Positioned(
          child: logo,
          top: 240,
        ),
        Positioned(
            top: 320,
            child: isValidating ? CircularProgressIndicator() : Container())
      ],
    );
  }
}
