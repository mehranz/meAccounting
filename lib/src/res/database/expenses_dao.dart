import 'dart:async';

import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/res/database/database_provider.dart';

class ExpensesDAO {
  /*
   * Expenses Data Access Object Class to intract with database
   */

  // create an instance of database provider
  // to get database object in order to use it's methods
  // in order to intract with database
  final DatabaseProvider dbProvider = DatabaseProvider.databaseProvider;

  Future<int> createNewExpense(ExpenseModel expense) async {
    /*
     * method to insert new expense inside database
     * 
     * @params ExpenseModel
     * @returns Future<int> 
     */

    final db = await dbProvider.database;

    var result = db.insert("expenses", expense.toMap());

    return result;
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    /*
     * method to get all expense objects from database
     * and convert them to a List of ExpenseModels
     * 
     * @return Future<List<ExpenseModel>>
     */

    final db = await dbProvider.database;

    List<Map<String, dynamic>> dbResult;

    dbResult = await db.rawQuery(
        "SELECT DISTINCT expenses.*, accounts.title AS accountTitle FROM expenses LEFT JOIN accounts ON expenses.account_id = accounts.id");

    // get every item of database result and create an ExpenseModel
    // and make a list of ExpenseModels
    List<ExpenseModel> expenses = dbResult
        .map((dbQueryResult) => ExpenseModel.fromDbMap(dbQueryResult))
        .toList();

    return expenses;
  }

  Future<int> getTotalExpensesFrom(String from) async {
    /*
       * method to get total expenses from an specific day until now
       * NOTE: parameter of this method is the second parameter of an sqlite function date()
       * 
       * @params String
       * @return Future<int>
       */

    final db = await dbProvider.database;

    List<Map<String, dynamic>> dbResult;

    dbResult = await db.rawQuery(
        "SELECT amount FROM expenses WHERE created_at >= date('now', ?)",
        [from]);

    int totalExpenses = 0;
    dbResult.forEach((item) => totalExpenses += item['amount']);

    return totalExpenses;
  }
}
