import 'dart:ffi';

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //Create Table
  static Future<void> createTable(sql.Database database) async {
    await database.execute(""" 
    carate table items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      todotext TEXT,
      isdone BOOL,
      createat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

//open Database If not Exist Create it
  static Future<sql.Database> db() async {
    return sql.openDatabase('mytodo.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  //Create Todo Function
  static Future<int> createItem(String TodoText, Bool isDone) async {
    final db = await SQLHelper.db();

    final data = {'todotext': TodoText, 'isdone': isDone};

    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();

    try {
      db.delete('items', where: "id=?", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }
}
