import 'dart:async';
import 'package:meAccounting/src/blocs/validators/expenses_validator.dart';
import 'package:rxdart/rxdart.dart';

import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/res/repo.dart';

class ExpensesBloc  with ExpensesValidator {
  /*
   * ExpensesBloc Class to provide business logic in order to handle states of app
   */

  // create an instance of repository in order to intract with database
  // inside expenses bloc class
  final _repo = Repo();

// create streams for every state wanted to be controlled
  final StreamController _expensesController =
      StreamController<List<ExpenseModel>>();

  final _titleController = BehaviorSubject<String>();
  final _amountController = BehaviorSubject<int>();
  final _descriptionsController = BehaviorSubject<String>();
  final _accountIdController = BehaviorSubject<int>();

  final StreamController _todayTotalExpensesController =
      StreamController<int>();

  Stream<List<ExpenseModel>> get expenses => _expensesController.stream;

  Stream<int> get totalExpenseOfDay => _todayTotalExpensesController.stream;

  Stream<String> get titleStream => _titleController.stream.transform(validateTitle);
  Function(String) get addTitle => _titleController.sink.add;

  Stream<int> get amountStream => _amountController.stream.transform(validateAmount);
  Function(int) get addAmount => _amountController.sink.add;

  Stream<String> get descriptionsStream => _descriptionsController.stream;
  Function(String) get addDescriptions => _descriptionsController.sink.add;

  Stream<int> get accountIdStream => _accountIdController.stream;
  Function(int) get addAccountId => _accountIdController.sink.add;

  Stream<bool> get validSubmit => Rx.combineLatest3(titleStream, amountStream, accountIdStream,
      (title, amount, accountId) => true);

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
  }

  updateExpense(ExpenseModel expense) {
    /*
     * method to update an specific expense inside database
     * and update expenses stream.
     * 
     * @params ExpenseModel 
     */
   
    expense.title = _titleController.value;
    expense.amount = _amountController.value;
    expense.descriptions = _descriptionsController.value;
    expense.accountId = _accountIdController.value;

    _repo.updateExpense(expense);
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

  void submitToDB() {
    /*
     * helper method to create an expense and submit it
     * to database. 
     * 
     * NOTE: this method should run when just all needed streams have value
     */

    final ExpenseModel _expenseToSubmit = ExpenseModel(
      title: _titleController.value,
      amount: _amountController.value,
      accountId: _accountIdController.value,
      descriptions: _descriptionsController.value,
      createdAt: DateTime.now().toString(),
    );

    addNewExpenseToDB(_expenseToSubmit);
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
