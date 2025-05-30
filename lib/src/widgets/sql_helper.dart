import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/sugerencia_model.dart'; // Ruta correcta al modelo

class SQLHelper {
  static const String _tableName = 'sugerencias';
  static const String _dbName = 'sugerencias.db';

  // Inicializar la base de datos
  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rating INTEGER,
            texto TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Insertar una nueva sugerencia
  static Future<void> insertSugerencia(Sugerencia sugerencia) async {
    final db = await _initDatabase();
    await db.insert(
      _tableName,
      sugerencia.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recuperar todas las sugerencias
  static Future<List<Sugerencia>> getAllSugerencias() async {
    final db = await _initDatabase();
    final List<Map<String, dynamic>> data = await db.query(_tableName);

    return data.map((map) => Sugerencia.fromMap(map)).toList();
  }
}
