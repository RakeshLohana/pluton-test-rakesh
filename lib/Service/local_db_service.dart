import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_project/Model/ApiModel.dart';

class LocalDbService {
  static final LocalDbService _instance = LocalDbService._internal();
  static Database? _database;

  LocalDbService._internal();

  factory LocalDbService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorites (
      id INTEGER PRIMARY KEY,         
      title TEXT,             
      body TEXT,                   
      tags TEXT,                 
      views INTEGER,                  
      userId INTEGER,               
      reactions INTEGER              
    )
  ''');
  }

  Future<int> addFavorite(Posts post) async {
    final db = await database;
    return await db.insert('favorites', post.toMap());
  }

  Future<List<Posts>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites');
    return result.map((e) => Posts.fromMap(e)).toList();
  }

  Future<int> removeFavorite(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
