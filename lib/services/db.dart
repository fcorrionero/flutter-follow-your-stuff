import 'dart:async';
import 'package:followyourstuff/models/BaseModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;

  static int get _version => 2;

  static Future<void> init() async {
    if(_db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'thing_database';
      _db = await openDatabase(_path, version:_version, onCreate: onCreate);
    }catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS things(id INTEGER PRIMARY KEY autoincrement, name TEXT, createdAt TEXT)");
    await db.execute("CREATE TABLE IF NOT EXISTS elements(id INTEGER PRIMARY KEY autoincrement, name TEXT, createdAt TEXT, thingId INTEGER)");
    await db.execute("CREATE TABLE IF NOT EXISTS properties(id INTEGER PRIMARY KEY autoincrement, name TEXT, createdAt TEXT, thingId INTEGER)");
  }

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Database getDB() {
    return _db;
  }

  static Future<int> insert(BaseModel model) async =>
      await _db.insert(model.getTable(), model.toMap());

  static Future<int> update(String table, BaseModel model) async =>
      await _db.update(model.getTable(), model.toMap(), where: 'id = ?', whereArgs: [model.getPrimaryKey()]);

  static Future<int> delete(BaseModel model) async =>
      await _db.delete(model.getTable(), where: 'id = ?', whereArgs: [model.getPrimaryKey()]);

  static Future<void> execute(String sql) async =>
      await _db.execute(sql);
}