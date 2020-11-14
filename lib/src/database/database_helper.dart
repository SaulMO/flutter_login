import 'dart:io';
import 'package:flutter_login/src/models/userDAO.dart';
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
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path), nombreDB;
    return await openDatabase(
      rutaDB,
      version: _versionDB,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_perfil(id INTEGER PRIMARY,nomUser varchar(25),apepUser varchar(25),apemUser varchar(25),telUser char(10),mailUser varchar(40),foto varchar(200),user varchar(30),passwd varchar(30))");
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
}
