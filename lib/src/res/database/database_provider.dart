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
      onUpgrade: upgradeDB,
    );

    return db;
  }

  upgradeDB(Database db, int oldVersion, int newVersion) {
    /*
     * method to upgrade database if version of currnet database 
     * is higher than the one exist
     * 
     * @params Database, int, int
     */

    initDB(db, newVersion);
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
    await db.execute("CREATE TABLE IF NOT EXISTS accounts ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, "
        "initalAmount INT, "
        "cardNumber INT"
        ")");

    // create expenses table
    await db.execute("CREATE TABLE IF NOT EXISTS expenses ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, "
        "amount INT, "
        "account_id INT, "
        "descriptions TEXT, "
        "created_at DATETIME, "
        "FOREIGN KEY (account_id) REFERENCES accounts(id)"
        ")");

    // create incomes table
    await db.execute("CREATE TABLE IF NOT EXISTS incomes ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title TEXT, "
        "amount INT, "
        "account_id INT, "
        "descriptions TEXT, "
        "created_at DATETIME, "
        "FORIGEN KEY (account_id) REFERENCES accounts(id)"
        ")");

    // enable forigen keys
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
