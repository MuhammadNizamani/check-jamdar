import 'dart:io';
import 'dart:async';
import 'package:check_mazdor/models/mazdor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "MazdorTestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE MazdorCheck ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "tarikh DOUBLE,"
          "numberOfTarikh INTERGER,"
          "phoneNO TEXT"
          ")");
    });
  }

  newMazdor(Mazdor newMazdor) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO MazdorCheck(name, phoneNO) "
        "VALUES(?,?)",
        [newMazdor.name, newMazdor.phoneNO]);

    return raw;
  }

  updateMazdor(Mazdor newMazdor) async {
    final db = await database;
    var res = await db.update("MazdorCheck", newMazdor.toMap(),
        where: "id = ?", whereArgs: [newMazdor.id]);

    return res;
  }

  getMazdor(int id) async {
    final db = await database;
    var res = await db.query("MazdorCheck", where: "id=?", whereArgs: [id]);

    return res.isNotEmpty ? Mazdor.fromMap(res.first) : null;
  }

  Future<List<Mazdor>> getAllMazdor() async {
    final db = await database;
    var res = await db.query("MazdorCheck");
    List<Mazdor> list =
        res.isNotEmpty ? res.map((e) => Mazdor.fromMap(e)).toList() : [];
    return list;
  }

  deleteMazdor(int id) async {
    final db = await database;
    return db.delete("MazdorCheck", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    return db.rawDelete("DELETE * FROM MazdorCheck");
  }

  updateMyTarikh(double tarikh, int id) async {
    final db = await database;
    int count = await db.rawUpdate('''
    UPDATE MazdorCheck
    SET tarikh = ?, 
    WHERE id = ?
    ''', 
    [tarikh,id]);
    print(count);
  }
}
