import 'dart:async';
import 'database_provider.dart';
import '../../models/income_model.dart';

class IncomesDao {
  /*
   * Incomes Data Access Object Class to intract with database
   */

  // create an instance of database provider
  // to get database object to use it's methods
  // in order to intract with database
  final databaseProvider = DatabaseProvider.databaseProvider;

  Future<int> createIncome(IncomeModel income) async {
    /*
     * method to insert new income inside databse
     * 
     * @params IncomeModel
     * @return Future<int>
     */

    final db = await databaseProvider.database;

    var result = await db.insert("incomes", income.toMap());

    return result;
  }

  Future<List<IncomeModel>> getAllIncomes() async {
    /*
     * method to get all income objects from database
     * and convert them to a list of IncomeModels
     * 
     * @return Future<List<IncomeModel>>
     */
    final db = await databaseProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.rawQuery("SELECT DISTINCT incomes.*, accounts.title AS accountTitle FROM incomes LEFT JOIN accounts ON incomes.account_id = accounts.id");

    List<IncomeModel> incomes =
        result.map((income) => IncomeModel.fromDbMap(income)).toList();

    return incomes;
  }
}
