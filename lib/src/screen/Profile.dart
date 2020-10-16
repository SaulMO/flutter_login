import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final profile_image = CircleAvatar(
      radius: 75,
      backgroundImage: NetworkImage('https://thispersondoesnotexist.com/image'),
      backgroundColor: Colors.transparent,
    );
    final btnUpdateImage = RaisedButton(
      onPressed: () {},
      child: Text('Elegir Imágen', style: TextStyle(color: Colors.white)),
      color: Color.fromRGBO(67, 67, 67, 1),
    );
    final txtNombre = TextFormField(
      keyboardType: TextInputType.name,
      initialValue: 'Saúl Mondragón Ortega',
      decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Configuration.colorApp,
          ),
          hintText: 'Nombre'),
    );
    final txtEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: 'saulmondragonortega@gmail.com',
      decoration: InputDecoration(
          icon: Icon(Icons.email, color: Configuration.colorApp),
          hintText: 'E-mail'),
    );
    final txtTelefono = TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: '4111228661',
      decoration: InputDecoration(
        icon: Icon(Icons.phone_android, color: Configuration.colorApp),
        hintText: 'Teléfono',
      ),
    );
    final btnUpdate = RaisedButton(
      onPressed: () {},
      child: Text('Actualizar', style: TextStyle(color: Colors.white)),
      color: Color.fromRGBO(67, 67, 67, 1),
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/profile_background.png'),
                  fit: BoxFit.fitHeight)),
        ),
        Card(
          margin: EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                btnUpdateImage,
                Divider(),
                txtNombre,
                txtEmail,
                txtTelefono,
                Divider(),
                btnUpdate
              ],
            ),
          ),
        ),
        Positioned(
          child: profile_image,
          top: 115,
        ),
      ],
    );
  }
}
