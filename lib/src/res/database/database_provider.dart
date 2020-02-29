import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  /*
   * DatabaseProivder is providing database connection for whole project
   */

  static final DatabaseProvider databaseProvider = DatabaseProvider();

  Database _database;

  // getter to get database
  // if _database was null (or closed) it's gonna open or create it
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await createDatabase();

    return _database;
  }

  createDatabase() async {
    /*
     * createDatabase method tries to open the database
     * if database not exist it's gonna create it
     * 
     * @params 
     * @return Future<Database>
     */

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "meaccouting.db");

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
    );

    return db;
  }

  initDB(Database db, int version) async {
    /*
     * initDB method is gonna create database tables 
     * inside new databases
     * 
     * @params Database, int
     * @return 
     */

    // create accounts table
    await db.execute("CREATE TABLE accounts ("
      "id INTEGER PRIMARY KEY, "
      "title TEXT, "
      "initalAmount INT, "
      "cardNumber INT"
    ")");
  }
}