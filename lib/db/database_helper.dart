import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/celular.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE celular(id INTEGER PRIMARY KEY, nome TEXT, marca TEXT, cor TEXT, tamanho TEXT)');
  }

  Future<int> inserirCelular(Celular celular) async {
    var dbClient = await db;
    var result = await dbClient.insert("celular", celular.toMap());
    return result;
  }

  Future<List> getCelular() async {
    var dbClient = await db;
    var result = await dbClient.query("celular",
        columns: ["id", "nome", "marca", "cor", "tamanho"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM celular'));
  }

  Future<Celular> getCelulares(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("celular",
        columns: ["id", "nome", "marca", "cor", "tamanho"],
        where: 'ide = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Celular.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteCelular(int id) async {
    var dbClient = await db;
    return await dbClient.delete("celular", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCelular(Celular celular) async {
    var dbClient = await db;
    return await dbClient.update("celular", celular.toMap(),
        where: "id = ?", whereArgs: [celular.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
