import 'dart:io';

import 'package:localdatabase/model/mobil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static Database _database;

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'collection.db';

    var collectionDatabase = openDatabase(path, version: 1, onCreate: createDB);
    return collectionDatabase;
  }

  void createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE koleksi(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    koleksi TEXT,
    jumlah INTEGER)
    ''');
    print('Database was Created');
  }

  Future<Database> get database async {
    if (database == null) {
      _database = await initDB();
    }
    return database;
  }

  Future<int> insert(Mobil object) async {
    Database db = await this.database;
    int count = await db.insert('mobil', object.toMap());
    return count;
  }

  Future<int> update(Mobil object) async {
    Database db = await this.database;
    int count = await db.update(
        'mobil', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(Mobil object) async {
    Database db = await this.database;
    int count = await db.delete('mobil', where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<Mobil> getMobil(int id) async {
    Database db = await this.database;
    Future<List<Map<String, dynamic>>> count = db.query(
        'mobil', where: 'id=?', whereArgs: [id]);
    var data = await count;

    if (data.length != 0) {
      return Mobil.fromMap(data.first);
    }
    return null;
  }

  Future<List<Mobil>> getMobilList()async{
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.query('mobil', orderBy: 'mobil');
    int count = mapList.length;

    List<Mobil> mobilList = List<Mobil>();
    for (int i = 0; i < count; i++) {
      mobilList.add(Mobil.fromMap(mapList[i]));
    }
    return null;
  }


}