// admin_database_helper.dart
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voting_app/models/admin_model.dart';

class AdminDatabaseHelper {
  static final AdminDatabaseHelper instance =
      AdminDatabaseHelper._privateConstructor();

  static Database? _database;

  AdminDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // if _database is null, instantiate it
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'admin_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE admins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        adminName TEXT,
        department TEXT,
        adminID TEXT,
        phoneNo TEXT,
        profilePicPath TEXT
      )
    ''');
  }

  Future<int> insertAdmin(Admin admin) async {
    Database db = await instance.database;
    return await db.insert('admins', admin.toMap());
  }

  Future<Admin?> getAdmin(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.query('admins', where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Admin.fromMap(maps.first);
    }

    return null;
  }

  Future<int> updateAdmin(Admin admin) async {
    Database db = await instance.database;
    return await db.update('admins', admin.toMap(),
        where: 'id = ?', whereArgs: [admin.id]);
  }

  Future<void> deleteAdmin(int id) async {
    Database db = await instance.database;
    await db.delete('admins', where: 'id = ?', whereArgs: [id]);
  }
}
