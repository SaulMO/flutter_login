import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          'https://maryza.gnomio.com/pluginfile.php/2/course/section/1/logoTecNM.png'),
      backgroundColor: Colors.transparent,
    );
    final txtEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "ejem@mail.com",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
    final txtPass = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'contraseña',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
    );
    final loginButton = RaisedButton(
      onPressed: () {},
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
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
