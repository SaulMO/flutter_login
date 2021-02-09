//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/assets/configuration.dart';
import 'package:flutter_login/src/database/database_helper.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/screen/dashboard.dart';
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
  TextEditingController contNom;
  TextEditingController contApP;
  TextEditingController contApM;
  TextEditingController contTel;
  TextEditingController contEma;
  UserDAO usuarioDAO;
  //Nos permite tomar la fotografia ImagePicker
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _imagePath = "";
  DataBaseHelper _dataBase;
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  _getUsuario() async {
    SharedPreferences preferences = await _preferences;
    Map usuarioMapeado = jsonDecode(preferences.getString('usuario'));
    usuarioDAO = UserDAO.fromJSON(usuarioMapeado);
    _nombre = (usuarioDAO.nomUser == null) ? "" : usuarioDAO.nomUser;
    _apeP = (usuarioDAO.apepUser == null) ? "" : usuarioDAO.apepUser;
    _apeM = (usuarioDAO.apemUser == null) ? "" : usuarioDAO.apemUser;
    _tel = (usuarioDAO.telUser == null) ? "" : usuarioDAO.telUser;
    _email = (usuarioDAO.mailUser == null) ? "" : usuarioDAO.mailUser;
    _imagePath = (usuarioDAO.foto == null) ? "" : usuarioDAO.foto;
    print(_nombre);
    print(_apeP);
    print(_apeM);
    print(_tel);
    print(_email);
    print(_imagePath);
  }

  @override
  void initState() {
    super.initState();
    _dataBase = DataBaseHelper();
    _getUsuario();
    contNom = TextEditingController(text: _nombre);
    contApP = TextEditingController(text: _apeP);
    contApM = TextEditingController(text: _apeM);
    contTel = TextEditingController(text: _tel);
    contEma = TextEditingController(text: _email);
  }

  Widget _buildNombreWidget() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: contNom,
      decoration: InputDecoration(
        labelText: 'Nombre',
        hintText: 'Nombre',
        icon: Icon(
          Icons.person,
          color: Configuration.colorApp,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "It is required to know the value";
        }
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _buildApellidoPaternoWidget() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: contApP,
      decoration: InputDecoration(
        labelText: 'Primer Apellido',
        hintText: 'Primer Apellido',
        icon: Icon(
          Icons.person,
          color: Configuration.colorApp,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "It is required to know the value";
        }
      },
      onSaved: (String value) {
        _apeP = value;
      },
    );
  }

  Widget _buildApellidoMaternoWidget() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: contApM,
      decoration: InputDecoration(
        labelText: 'Segundo Apellido',
        hintText: 'Segundo Apellido',
        icon: Icon(
          Icons.person,
          color: Configuration.colorApp,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "It is required to know the value";
        }
      },
      onSaved: (String value) {
        _apeM = value;
      },
    );
  }

  Widget _buildEmailWidget() {
    return TextFormField(
      controller: contEma,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'E-mail',
        icon: Icon(
          Icons.email,
          color: Configuration.colorApp,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "It is required to know the value";
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPhoneWidget() {
    return TextFormField(
      controller: contTel,
      decoration: InputDecoration(
        labelText: 'Tel',
        hintText: 'Tel',
        icon: Icon(
          Icons.phone,
          color: Configuration.colorApp,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "It is required to know the value";
        }
      },
      onSaved: (String value) {
        _tel = value;
      },
    );
  }

  void actualizarPreferences(UserDAO userDAO) async {
    final SharedPreferences preferences = await _preferences;
    String userJSON = jsonEncode(userDAO.toJSON());
    await preferences.setString('usuario', userJSON);
  }

  @override
  Widget build(BuildContext context) {
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
          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
          //margin: EdgeInsets.all(50.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _buildNombreWidget(),
                  _buildApellidoPaternoWidget(),
                  _buildApellidoMaternoWidget(),
                  _buildEmailWidget(),
                  _buildPhoneWidget(),
                  RaisedButton(
                    child: Text('Actualizar',
                        style: TextStyle(color: Colors.white)),
                    color: Color.fromRGBO(67, 67, 67, 1),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      usuarioDAO.nomUser = _nombre;
                      usuarioDAO.apepUser = _apeP;
                      usuarioDAO.apemUser = _apeM;
                      usuarioDAO.telUser = _tel + "";
                      usuarioDAO.mailUser = _email;
                      usuarioDAO.foto = _imagePath;
                      actualizarPreferences(usuarioDAO);
                      _dataBase.insertar(usuarioDAO.toJSON(), 'tbl_perfil');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()),
                          ModalRoute.withName('/login'));
                    },
                  ),
                ],
              ),
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
      ],
    );
  }
}
