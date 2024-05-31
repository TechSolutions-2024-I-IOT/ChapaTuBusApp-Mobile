import 'package:chapa_tu_bus_app/account_management/infrastructure/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseDatasource {
  static const _databaseName = 'account_management.db'; 
  static const _databaseVersion = 1;
  static const _tableName = 'users';

  LocalDatabaseDatasource._privateConstructor();
  static final LocalDatabaseDatasource instance =
      LocalDatabaseDatasource._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            photoURL TEXT
          )
        ''');
  }

  // CRUD operations

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert(_tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUserById(String id) async {
    final db = await database;
    final maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]); 
    });
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(_tableName, user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(String id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}