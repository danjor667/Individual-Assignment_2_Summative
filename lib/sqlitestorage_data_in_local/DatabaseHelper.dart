import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /*Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'programme.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }*/
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'programme.db');
    return await openDatabase(
      path,
      version: 2,  // Incrémente la version pour déclencher l'upgrade
      onCreate: _createDB,
      onUpgrade: _upgradeDB,  // Ajoute cette méthode pour mettre à jour la base
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE programme (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calendrier_id INTEGER,
        data TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE journee (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calendrier_id INTEGER,
        data TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE matchs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        calendrier_id INTEGER,
        data TEXT
      )
    ''');

    //////////
    Future _createDB(Database db, int version) async {
      await db.execute('''
      CREATE TABLE equipe (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        page INTEGER,
        data TEXT
      )
    ''');

      await db.execute('''
    CREATE TABLE journee (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      calendrier_id INTEGER,
      data TEXT
    )
  ''');

      await db.execute('''
    CREATE TABLE matchs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      calendrier_id INTEGER,
      data TEXT
    )
  ''');

      // Ajouter la table pour les équipes
      await db.execute('''
    CREATE TABLE equipe (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      equipe_id INTEGER,
      data TEXT
    )
  ''');
    }
  }

  Future<int> insertProgramme(int calendrierId, String data, String table) async {
    final db = await database;
    return await db.insert(
      table,
      {'calendrier_id': calendrierId, 'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getProgramme(int calendrierId, String table) async {
    final db = await database;
    var res = await db.query(
      table,
      where: 'calendrier_id = ?',
      whereArgs: [calendrierId],
    );
    if (res.isNotEmpty) {
      return res.first;
    }
    return null;
  }

  Future<int> deleteProgramme(int calendrierId, String table) async {
    final db = await database;
    return await db.delete(
      table,
      where: 'calendrier_id = ?',
      whereArgs: [calendrierId],
    );
  }

  ///////////////
  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Ajouter la table 'equipe' lors de la mise à jour de la base
      await db.execute('''
      CREATE TABLE equipe (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        equipe_id INTEGER,
        data TEXT
      )
    ''');
    }
  }


// Insertion d'une équipe

  // Méthode pour insérer une équipe par page
  Future<int> insertEquipePage(int page, String data) async {
    final db = await database;
    return await db.insert(
      'equipe',
      {'page': page, 'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Méthode pour récupérer les équipes d'une page spécifique
  Future<List<Map<String, dynamic>>> getEquipesByPage(int page) async {
    final db = await database;
    return await db.query(
      'equipe',
      where: 'page = ?',
      whereArgs: [page],
    );
  }

  // Méthode pour supprimer toutes les équipes
  Future<int> clearEquipes() async {
    final db = await database;
    return await db.delete('equipe');
  }
}

