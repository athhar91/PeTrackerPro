import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gymtrack.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        notes TEXT,
        mediaPath TEXT,
        mediaType TEXT,
        timestamp TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE weights (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
