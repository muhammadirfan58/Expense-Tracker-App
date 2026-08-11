import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  // In-memory fallback for Web/unsupported platforms
  final List<Map<String, dynamic>> _inMemoryDb = [];
  int _inMemoryIdCounter = 1;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (kIsWeb) return null;
    if (_database != null) {
      return _database!;
    }

    try {
      _database = await _initDB('expenses.db');
      return _database!;
    } catch (e) {
      debugPrint('SQLite initialization failed, falling back to in-memory: $e');
      return null;
    }
  }

  Future<Database> _initDB(String fileName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  Future<int> addExpense(Expense expense) async {
    final db = await database;
    if (db == null) {
      final id = _inMemoryIdCounter++;
      final expenseMap = expense.toMap();
      expenseMap['id'] = id;
      _inMemoryDb.add(expenseMap);
      return id;
    }

    return await db.insert(
      'expenses',
      expense.toMap(),
    );
  }

  // READ
  Future<List<Expense>> getExpenses() async {
    final db = await database;
    if (db == null) {
      final sortedList = List<Map<String, dynamic>>.from(_inMemoryDb)
        ..sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));
      return sortedList.map((map) => Expense.fromMap(map)).toList();
    }

    final result = await db.query(
      'expenses',
      orderBy: 'id DESC',
    );

    return result.map((map) => Expense.fromMap(map)).toList();
  }

  // UPDATE
  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    if (db == null) {
      final index = _inMemoryDb.indexWhere((map) => map['id'] == expense.id);
      if (index != -1) {
        _inMemoryDb[index] = expense.toMap();
        return 1;
      }
      return 0;
    }

    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  // DELETE
  Future<int> deleteExpense(int id) async {
    final db = await database;
    if (db == null) {
      _inMemoryDb.removeWhere((map) => map['id'] == id);
      return 1;
    }

    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    if (db != null) {
      await db.close();
    }
  }
}
