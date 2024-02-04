// candidate_database_helper.dart

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voting_app/models/candidate_model.dart';

class CandidateDatabaseHelper {
  static final CandidateDatabaseHelper instance =
      CandidateDatabaseHelper._init();
  static Database? _database;

  CandidateDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('candidates.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE candidates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        semester TEXT,
        postId TEXT,
        department TEXT,
        usn TEXT,
        phoneNumber TEXT,
        email TEXT,
        electionId TEXT,
        gender TEXT
      )
    ''');
  }

  Future<int> insertCandidate(Candidate candidate) async {
    final db = await instance.database;
    return await db.insert('candidates', candidate.toMap());
  }

  Future<List<Candidate>> getAllCandidates() async {
    final db = await instance.database;
    final maps = await db.query('candidates');

    return List.generate(maps.length, (index) {
      return Candidate(
        id: maps[index]['id'] as int?,
        name: maps[index]['name'] as String,
        semester: maps[index]['semester'] as String,
        postId: maps[index]['postId'] as String,
        department: maps[index]['department'] as String,
        usn: maps[index]['usn'] as String,
        phoneNumber: maps[index]['phoneNumber'] as String,
        email: maps[index]['email'] as String,
        electionId: maps[index]['electionId'] as String,
        gender: maps[index]['gender'] as String,
      );
    });
  }

  Future<void> deleteCandidate(int candidateId) async {
    final db = await instance.database;
    await db.delete('candidates', where: 'id = ?', whereArgs: [candidateId]);
  }

  Future<void> deleteAllCandidates() async {
    final db = await instance.database;
    await db.delete('candidates');
  }
}
