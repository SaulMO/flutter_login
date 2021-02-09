import 'dart:io';
import 'package:flutter_login/src/models/favoriteDAO.dart';
import 'package:flutter_login/src/models/userDAO.dart';
import 'package:flutter_login/src/models/trendingDAO.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final _nombreDB = "ventas_db";
  static final _versionDB = 1;

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, _nombreDB);
    return await openDatabase(
      path,
      version: _versionDB,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY,nomUser varchar(25),apepUser varchar(25),apemUser varchar(25),telUser char(10),mailUser varchar(40),foto varchar(200),user varchar(30),passwd varchar(30))");
    await db.execute(
        "CREATE TABLE tbl_favoritas(id INTEGER PRIMARY KEY, posterPath text, backdropPath text, title text, adult integer, voteAverage float, overview text, releaseDate text, favorite integer)");
  }
  /*
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalTitle;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;
  */

  _createTableMovie(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_favoritas(id INTEGER PRIMARY KEY, posterPath text, backdropPath text, title text, adult integer, voteAverage numeric, overview text, releaseDate text, favorite integer)");
  }

  Future<int> insertar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient.insert(tabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient
        .update(tabla, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> eliminar(int id, String tabla) async {
    var dbClient = await database;
    return await dbClient.delete(tabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<UserDAO> getUsuario(String mailUser) async {
    var dbClient = await database;
    var result = await dbClient
        .query('tbl_perfil', where: 'mailUser = ?', whereArgs: [mailUser]);
    var lista = (result).map((item) => UserDAO.fromJSON(item)).toList();
    return lista.length > 0 ? lista[0] : null;
  }

  Future<FavoriteDAO> getPelicula(int id) async {
    var cliente = await database;
    var result =
        await cliente.query("tbl_favoritas", where: "id = ?", whereArgs: [id]);

    var list = (result).map((e) => FavoriteDAO.fromJSON(e)).toList();
    return list[0];
  }

  Future<List<FavoriteDAO>> getPeliculas() async {
    var cliente = await database;
    var result = await cliente.query("tbl_favoritas");
    var list = (result).map((e) => FavoriteDAO.fromJSON(e)).toList();
    return list;
  }
}
