import 'dart:io';

import 'package:mimamu/core/core.dart';
import 'package:mimamu/src/login/model/login_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  deleteDB() async {
    final db = await database;

    db.delete("Mimamu_USER");
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MimamuDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Mimamu_USER ("
            "id INTEGER PRIMARY KEY,"
            "account_name TEXT,"
            "account_password TEXT,"
            "student_id INTEGER,"
            "student_name TEXT,"
            "is_default_password INTEGER,"
            "access_token TEXT,"
            "refresh_token TEXT"
            ")");
      },
    );
  }

  createUser(LoginData newUser) async {
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Mimamu_USER");
    int id = table.first['id'];

    var raw = await db.rawInsert(
      "INSERT INTO Mimamu_USER (id, account_name, account_password, student_id, student_name, is_default_password, access_token, refresh_token)"
      "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        id,
        newUser.account_name,
        newUser.account_password,
        newUser.student_id,
        newUser.student_name,
        newUser.is_default_password,
        newUser.access_token,
        newUser.refresh_token
      ],
    );

    return raw;
  }

  getUser(String getUser) async {
    final db = await database;
    var raw = await db.query(
      "Mimamu_USER",
      where: "account_name = ?",
      whereArgs: [getUser],
    );

    return raw.isNotEmpty ? LoginData.fromJson(raw.first) : null;
  }

  Future<List<LoginData>> getAllUser() async {
    final db = await database;
    var raw = await db.query("Mimamu_USER");
    List<LoginData> listUser =
        raw.isNotEmpty ? raw.map((e) => LoginData.fromJson(e)).toList() : [];

    return listUser;
  }

  updateUser(LoginData updateUser) async {
    final db = await database;
    var raw = await db.update(
      'Mimamu_USER',
      updateUser.toJson(),
      where: "account_name = ?",
      whereArgs: [updateUser.account_name],
    );

    return raw;
  }

  deleteUser(LoginData deleteUser) async {
    final db = await database;
    return db.delete(
      "Mimamu_USER",
      where: "account_name = ?",
      whereArgs: [deleteUser.account_name],
    );
  }

  deleteAllUser() async {
    final db = await database;
    db.rawDelete("DELETE * FROM Mimamu_USER");
  }
}
