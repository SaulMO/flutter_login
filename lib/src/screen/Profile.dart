//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/screen/Dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _nombre;
  String _apeP;
  String _apeM;
  String _tel;
  String _email;
  _getEmailPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _email = (preferences.getString("email") ?? "NO DATA");
    print("EMAIL " + _email);
  }

  //Nos permite tomar la fotografia ImagePicker
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _imagePath = "";
  DataBaseHelper _dataBase;

  @override
  void initState() {
    super.initState();
    _getEmailPreferences();
    _dataBase = DataBaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    _getEmailPreferences();
    final imgFinal = _imagePath == ""
        ? CircleAvatar(
            radius: 75,
            backgroundImage:
                NetworkImage('https://thispersondoesnotexist.com/image'),
            backgroundColor: Colors.transparent,
          )
        : ClipOval(
            child: Image.file(
              File(_imagePath),
              fit: BoxFit.cover,
            ),
          );

    /*final profile_image = CircleAvatar(
      radius: 75,
      backgroundImage: NetworkImage('https://thispersondoesnotexist.com/image'),
      backgroundColor: Colors.transparent,
    );*/
    final btnUpdateImage = RaisedButton(
      child: Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
      color: Color.fromRGBO(67, 67, 67, 1),
      onPressed: () async {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        _imagePath = pickedFile != null ? pickedFile.path : "";
        setState(() {
          //Aqui Cambia la Imagen
        });
      },
    );
    final txtNombre = TextFormField(
      keyboardType: TextInputType.name,
      initialValue: 'Saúl Mondragón Ortega',
      validator: (String value) {
        if (value.isEmpty) {
          return ("Campo Necesario");
        }
      },
      onSaved: (newValue) => _nombre,
      decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Configuration.colorApp,
          ),
          hintText: 'Nombre'),
    );
    final txtApP = TextFormField(
      keyboardType: TextInputType.name,
      initialValue: 'Mondragón',
      validator: (String value) {
        if (value.isEmpty) {
          return ("Campo Necesario");
        }
      },
      onSaved: (newValue) => _apeP,
      decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Configuration.colorApp,
          ),
          hintText: 'Apellido Paterno'),
    );
    final txtApM = TextFormField(
      keyboardType: TextInputType.name,
      initialValue: 'Ortega',
      validator: (String value) {
        if (value.isEmpty) {
          return ("Campo Necesario");
        }
      },
      onSaved: (newValue) => _apeM,
      decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: Configuration.colorApp,
          ),
          hintText: 'Apellido Materno'),
    );
    final txtEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: _email,
      validator: (String value) {
        if (value.isEmpty) {
          return ("Campo Necesario");
        }
      },
      onSaved: (newValue) => _email,
      decoration: InputDecoration(
          icon: Icon(Icons.email, color: Configuration.colorApp),
          hintText: 'E-mail'),
    );
    final txtTelefono = TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: '4111228661',
      validator: (String value) {
        if (value.isEmpty) {
          return ("Campo Necesario");
        }
      },
      onSaved: (newValue) => _tel,
      decoration: InputDecoration(
        icon: Icon(Icons.phone_android, color: Configuration.colorApp),
        hintText: 'Teléfono',
      ),
    );
    final btnUpdate = RaisedButton(
      child: Text('Actualizar', style: TextStyle(color: Colors.white)),
      color: Color.fromRGBO(67, 67, 67, 1),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        UserDAO userDAO = UserDAO(
            nomUser: _nombre,
            apepUser: _apeP,
            apemUser: _apeM,
            telUser: _tel,
            mailUser: _email,
            foto: _imagePath);
        _dataBase.insertar(userDAO.toJSON(), 'tbl_perfil');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
            ModalRoute.withName('/login'));
      },
    );
    /*return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/profile_background.png"),
                fit: BoxFit.cover)),
        child: ListView(
          children: <Widget>[
            profile_image,
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
    );*/
    /*
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/profile_background.png"),
                fit: BoxFit.cover)),
        child: Card(
          margin: EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              profile_image,
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
    );*/
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/profile_background.png'),
                  fit: BoxFit.fitWidth)),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 50),
          //margin: EdgeInsets.all(50.0),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                txtNombre,
                txtApP,
                txtApM,
                txtEmail,
                txtTelefono,
              ],
            ),
          ),
        ),
        Positioned(
          top: 115.0,
          child: Container(
            height: 130.0,
            width: 130.0,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: imgFinal,
          ),
        ),
        Positioned(
          child: btnUpdateImage,
          top: 225,
        ),
        Positioned(
          child: btnUpdate,
          bottom: 0,
        )
      ],
    );
  }
}
