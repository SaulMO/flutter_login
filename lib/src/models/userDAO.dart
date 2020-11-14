import 'dart:convert';

class UserDAO {
  String user;
  String passwd;

  int id;
  String nomUser;
  String apepUser;
  String apemUser;
  String telUser;
  String mailUser;
  String foto;

//id INTEGER PRIMARY,nomUser varchar(25),apepUser varchar(25),apemUser varchar(25),telUser char(10),mailUser varchar(40),foto varchar(200))

  UserDAO(
      {this.id,
      this.user,
      this.passwd,
      this.nomUser,
      this.apepUser,
      this.apemUser,
      this.telUser,
      this.mailUser,
      this.foto});
  factory UserDAO.fromJSON(Map<String, dynamic> map) {
    return UserDAO(
        id: map['id'],
        nomUser: map['nomUser'],
        apepUser: map['apepUser'],
        apemUser: map['apemUser'],
        telUser: map['telUser'],
        mailUser: map['mailUser'],
        foto: map['foto'],
        user: map['user'],
        passwd: map['passwd']);
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "nomUser": nomUser,
      "apepUser": apepUser,
      "apemUser": apemUser,
      "teluser": telUser,
      "mailUser": mailUser,
      "foto": foto,
      "user": user,
      "passwd": passwd
    };
  }

  String userToJSON() {
    final mapUser = this.toJSON();
    return json.encode(mapUser);
  }
}
