// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/election_model.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'election_database.db');

    _database = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE elections(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          electionId TEXT,
          electionDate TEXT,
          electionName TEXT
        )
      ''');
    });
  }

  Future<void> insertElection(Election election) async {
    if (!_database.isOpen) {
      await initializeDatabase();
    }
    await _database.insert('elections', election.toMap());
  }

  Future<List<Election>> getElections() async {
    if (!_database.isOpen) {
      await initializeDatabase();
    }
    final List<Map<String, dynamic>> maps = await _database.query('elections');
    return List.generate(maps.length, (index) {
      return Election(
        id: int.parse(maps[index]['id'].toString()),
        electionId: maps[index]['electionId'] as String,
        electionDate: DateTime.parse(maps[index]['electionDate'] as String),
        electionName: maps[index]['electionName'] as String,
      );
    });
  }

  Future<void> deleteElection(int id) async {
    if (!_database.isOpen) {
      await initializeDatabase();
    }
    await _database.delete('elections', where: 'id = ?', whereArgs: [id]);
  }
}
