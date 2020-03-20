import 'dart:async';

import 'package:meAccounting/src/models/account_model.dart';
import './database_provider.dart';

class AccountsDAO {
  /*
   * DAO class to provide Data Access Object
   * in order to intract with database 
   */

  // create an instance of database provider
  // to get database object in order to use it's methods
  // in order to intract with database
  final DatabaseProvider databaseProvider = DatabaseProvider.databaseProvider;

  Future<int> createAccount(AccountModel account) async {
    /*
     * createAccount method will add account model to database
     * 
     * @params AccountModel
     * @return Future<int>
     */

    final db = await databaseProvider.database;

    var result = db.insert("accounts", account.toMap());

    return result;
  }

  Future<List<AccountModel>> getAllAccounts() async {
    /*
     * getAllAccounts method will get all accounts from database
     * and make an AccountModel List of database results
     * 
     * @params 
     * @return Future<List<AccountModel>> 
     */
    final db = await databaseProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.query("accounts");

    // get every item of database result and create an AccountModel
    // and create a List of AccountModels by getting together all account models created
    List<AccountModel> accounts =
        result.map((item) => AccountModel.fromDBMap(item)).toList();

    return accounts;
  }

  Future<AccountModel> getAccountByID(int id) async {
    /*
     * getAccountsByID method will get account from database by given ID 
     * 
     * @param int
     * @return Future<AccountModel>
     */

    final db = await databaseProvider.database;

    List<Map<String, dynamic>> databaseResult =
        await db.query("accounts", where: "id = ?", whereArgs: [id]);

    // if query doesn't have any result returns null
    if (databaseResult.length < 1) return null;

    // id column is unique in database so we're gonna have just one item per id
    // inside databaseResult List and that's because index is always 0
    AccountModel _account = AccountModel.fromDBMap(databaseResult[0]);

    return _account;
  }

  Future<int> updateAccount(AccountModel account) async {
    /*
     * updateAccount method will update account object inside database
     * with value of edited fields inside app
     * 
     * @params AccountModel
     * @return Future<int>
     */

    final db = await databaseProvider.database;
    var result = await db.update("accounts", account.toMap(),
        where: "id = ?", whereArgs: [account.id]);

    return result;
  }

  Future<int> deleteAccount(int id) async {
    /*
     * deleteAccount method will delete account by given id from database 
     * 
     * @params int
     * @return Future<int>
     */

    final db = await databaseProvider.database;

    var result = await db.delete("accounts", where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<int> getAllAccountsAmount() async {
    /*
     * getAllAccountsAmount gonna give you total amounts of all accounts,
     * for using in summary screen
     * @params
     * @return Future<int>
     */
    final db = await databaseProvider.database;

    int allAccountsAmount = 0;

    List<Map<String, dynamic>> result =
        await db.rawQuery("SELECT initalAmount FROM accounts");

    result.forEach((obj) => allAccountsAmount += obj['initalAmount']);

    return allAccountsAmount;
  }
}
