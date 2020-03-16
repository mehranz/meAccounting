import 'dart:async';

import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/res/repo.dart';

class ExpensesBloc {
  /*
   * ExpensesBloc Class to provide business logic in order to handle states of app
   */

  // create an instance of repository in order to intract with database
  // inside expenses bloc class
  final _repo = Repo();

// create streams for every state wanted to be controlled
  final StreamController _expensesController =
      StreamController<List<ExpenseModel>>();

  final StreamController _titleController = StreamController();
  final StreamController _amountController = StreamController();
  final StreamController _descriptionsController = StreamController();
  final StreamController _accountIdController = StreamController();

  final StreamController _todayTotalExpensesController =
      StreamController<int>();

  Stream<List<ExpenseModel>> get expenses => _expensesController.stream;
  Stream<int> get totalExpenseOfDay => _todayTotalExpensesController.stream;

  Function(int) get addAccountId => _accountIdController.sink.add;

  getAllExpenses() async {
    /*
     * getAllExpenses method to get all expenses from database and
     * add them to expenses stream sink.
     */

    var _expenses = await _repo.getAllExpenses();
    _expensesController.sink.add(_expenses);
  }

  addNewExpenseToDB(ExpenseModel expense) async {
    /*
     * method to add new expense to database and update needed streams.
     * 
     * @param ExpenseModel
     */

    _repo.createExpense(expense);

    // Subtract the account's amount which paid expense, by expense amount
    await _repo.getAccountByID(expense.accountId).then((account) {
      account.initalAmount -= expense.amount;
      _repo.updateAccount(account);
    });

    getAllExpenses();
  }

  updateExpense(ExpenseModel expense) {
    /*
     * method to update an specific expense inside database
     * and update expenses stream.
     * 
     * @params ExpenseModel 
     */
    
    _repo.updateExpense(expense);

    getAllExpenses();
  }

  deleteExpense(ExpenseModel expense) {
    /*
     * method to delete expense from data base
     * and get all new expenses inside expenses sink
     * 
     * @params ExpenseModel
     */
    
    _repo.deleteExpense(expense);
    
    getAllExpenses();
  }

  getTotalExpensesOfToday() async {
    /*
     * method to get total expenses of today from database,
     * and add them to _totalExpensesOfToday stream sink
     */

    var _totalExpensesOfToday =
        await _repo.getTotalExpensesFrom('start of day');
    _todayTotalExpensesController.sink.add(_totalExpensesOfToday);
  }

  void dispose() {
    /*
     * method to close open streams
     */

    _expensesController.close();
    _titleController.close();
    _amountController.close();
    _descriptionsController.close();
    _accountIdController.close();
    _todayTotalExpensesController.close();
  }
}
