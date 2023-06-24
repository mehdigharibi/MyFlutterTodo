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
}
