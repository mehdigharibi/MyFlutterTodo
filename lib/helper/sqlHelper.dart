import 'dart:ffi';

import 'package:mytodo/model/todo.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //Create Table
  static Future<void> createTable(sql.Database database) async {
    await database.execute(""" 
    create table items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      todotext TEXT,
      isdone BOOL
    )
    """);
  }

//open Database If not Exist Create it
  static Future<sql.Database> db() async {
    return sql.openDatabase('mytodo4.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('create DB');
      await createTable(database);
    });
  }

  //Create Todo Function
  static Future<int> createItem(Todo todo) async {
    final db = await SQLHelper.db();

    final data = {
      'todotext': todo.todoText,
      'isdone': todo.isDone,
    };

    final id = await db.insert('items', data);
    print('The inserted id : ${id}');
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.rawQuery('Select * from items');
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

  static Future<void> updateItem(Todo todo) async {
    final db = await SQLHelper.db();

    final data = {
      'todotext': todo.todoText,
      'isdone': todo.isDone == true ? '1' : '0'
    };

    await db.update('items', data, where: "id=?", whereArgs: [todo.id]);
  }
}
