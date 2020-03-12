import 'dart:async';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/res/repo.dart';

import 'validators/incomes_validator.dart';

class IncomesBloc extends Object with IncomesValidator {
  /*
   * Class to provide business logic in order to handle states releated to Incomes
   * 
   */

  // create an instance of repo in order to deal with database
  final Repo _repo = Repo();

  // create stream for each state wanted to be controlled
  final StreamController _incomesController =
      StreamController<List<IncomeModel>>();
  final StreamController _titleController = StreamController<String>();
  final StreamController _amountController = StreamController<int>();
  final StreamController _accountIdController = StreamController<int>();
  final StreamController _descriptionsController = StreamController<String>();

  final StreamController _todayTotalIncomesController = StreamController<int>();

  // setter and getter for each controller's stream and its sink
  //
  Stream<List<IncomeModel>> get incomes => _incomesController.stream;
  Stream<int> get incomesOfToday => _todayTotalIncomesController.stream;

  // Getters for Title Controller
  Stream<String> get title => _titleController.stream.transform(titleValidator);
  Function(String) get addTitle => _titleController.sink.add;

  // Getters for Amount Controller
  Stream<int> get amount => _amountController.stream.transform(amountValidator);
  Function(int) get addAmount => _amountController.sink.add;

  // Getters for Account Controller
  Stream<int> get accountId => _accountIdController.stream;
  Function(int) get addAccountId => _accountIdController.sink.add;

  // Getters for Descriptions Controller
  Stream<String> get descriptions => _descriptionsController.stream;
  Function(String) get addDescriptions => _descriptionsController.sink.add;

  getAllIncomes() async {
    /*
      * method to get all incomes and add them to incomes controller sink
      */

    List<IncomeModel> _incomes = await _repo.getAllIncomes();
    _incomesController.sink.add(_incomes);
  }

  addNewIncome(IncomeModel income) async {
    /*
     * method to add new income to database and increase amount of account
     * 
     * @params IncomeModel
     */

    _repo.createIncome(income);

    // Sum the account's amount which received income, by income's amount
    await _repo.getAccountByID(income.account_id).then((account) {
      account.initalAmount += income.amount;
      _repo.updateAccount(account);
    });

    getAllIncomes();
  }

  deleteIncome(IncomeModel income) {
    /*
     * method to delete income from data base 
     * and get all new incomes inside incomes sink
     * 
     * @params IncomeModel
     */

    _repo.deleteIncome(income);

    getAllIncomes();
  }

  getIncomesOfToday() async {
    /*
     * method to get total incomes of today and add the value 
     * to total incomes of day stream 
     */

    var _totalIncomesOfToday = await _repo.getTotalIncomesFrom('start of day');
    _todayTotalIncomesController.sink.add(_totalIncomesOfToday);
  }

  dispose() {
    /*
     * method to close open streams
     * 
     */

    _incomesController.close();
    _titleController.close();
    _amountController.close();
    _accountIdController.close();
    _descriptionsController.close();
    _todayTotalIncomesController.close();
  }
}
