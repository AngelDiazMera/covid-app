import 'dart:io';

import 'package:covserver/models/history.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  // HASTA AQUÍ TERMINA LA ESTRUCTURA DE UN SINGLETON

  Future<Database> initDb() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,
        'CovServer_history.db'); // Para unir pedazos del path
    print(path);
    // Crear nase de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE History(
              id        INTEGER PRIMARY KEY AUTOINCREMENT,
              time      TEXT,
              status    TEXT,
              symptoms  TEXT
            );
        ''');
        // await db.execute('''...''');
        print('Base de datos creada');
      },
    );
  }

  // INSERT
  Future<int> newSymptomHistory(HistoryModel history) async {
    final db = await database;
    final resMascota = await db.insert('History', history.toJson());
    return resMascota;
  }

  Future<List<Map<String, dynamic>>> getCompleteHistory() async {
    final db = await database;
    final res = await db.rawQuery('''SELECT * FROM History''');
    return res.isNotEmpty ? res : [];
  }

  // DELETE
  Future deleteHistory() async {
    final db = await database;
    await db.delete('History');
    return;
  }

  //DELETE
  Future<int> deleteBeforeThisMonth(int id) async {
    var monthBefore = DateTime.now().subtract(Duration(days: 31));

    final db = await database;
    final res = await db.delete('History',
        where: 'date(History.time) <= Date(?)',
        whereArgs: [monthBefore.toUtc()]);
    return res;
  }

  // SELECT
  /*Future<PersonaModel> getPersonaById(int id) async {
    final db = await database;
    // El símbolo '?' es para determinar los argumentos posicionales de la búsqueda
    final res = await db.query('Persona', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty
        ? PersonaModel.fromJson(res.first) // Obtiene el primer elemento
        : null;
  }
  
  // // UPDATE
  Future<int> updatePersona(PersonaModel nuevaPersona) async {
    final db = await database;
    final res = await db.update('Persona', nuevaPersona.toJson(),
        where: 'id = ?', whereArgs: [nuevaPersona.id]);
    return res;
  }

  // //DELETE
  Future<int> deletePersona(int id) async {
    final db = await database;
    final res = await db.delete('Persona', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllPersonas() async {
    final db = await database;
    final res = await db.delete('Persona');
    return res;
  }*/
}
