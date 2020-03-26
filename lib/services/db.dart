import 'dart:async';
import 'package:followyourstuff/models/BaseModel.dart';
import 'package:followyourstuff/models/Thing.dart';
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
    await db.execute("CREATE TABLE things(id INTEGER PRIMARY KEY autoincrement, name TEXT, createdAt TEXT)");
  }

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert(BaseModel model) async =>
      await _db.insert(BaseModel.table, model.toMap());

  static Future<int> update(String table, BaseModel model) async =>
      await _db.update(model.getTable(), model.toMap(), where: 'id = ?', whereArgs: [model.getPrimaryKey()]);

  static Future<int> delete(BaseModel model) async =>
      await _db.delete(BaseModel.table, where: 'id = ?', whereArgs: [model.getPrimaryKey()]);
}