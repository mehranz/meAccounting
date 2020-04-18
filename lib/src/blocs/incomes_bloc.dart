import 'dart:async';

import 'package:rxdart/rxdart.dart';
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
  final _incomesController = BehaviorSubject<List<IncomeModel>>();

  final _titleController = BehaviorSubject<String>();
  final _amountController = BehaviorSubject<int>();
  final _accountIdController = BehaviorSubject<int>();
  final _descriptionsController = BehaviorSubject<String>();

  final StreamController<List<int>> _todayTotalIncomesController =
      StreamController<List<int>>();

  // setter and getter for each controller's stream and its sink
  //
  Stream<List<IncomeModel>> get incomes => _incomesController.stream;
  Stream<List<int>> get incomesOfToday => _todayTotalIncomesController.stream;

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

  // Getter for Validate Submit Stream
  Stream<bool> get validateSubmit => Rx.combineLatest3(
      title, amount, accountId, (title, amount, accountId) => true);

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
  }

  updateIncome(IncomeModel income) {
    /*
     * helper method to update given income inside database
     *
     * @params IncomeModel
     */

    income.title = _titleController.value;
    income.amount = _amountController.value;
    income.descriptions = _descriptionsController.value;
    income.account_id = _accountIdController.value;

    _repo.updateIncome(income);
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
    var _totalIncomesOfYesterday = await _repo.getTotalIncomesFrom('-1 day');
    _todayTotalIncomesController.sink.add([
      _totalIncomesOfToday,
      _totalIncomesOfYesterday - _totalIncomesOfToday,
    ]);
  }

  submitToDB() {
    /*
     * method to create an income model and submit it to database
     */

    final IncomeModel _incomeToSubmit = IncomeModel(
      title: _titleController.value,
      amount: _amountController.value,
      account_id: _accountIdController.value,
      created_at: DateTime.now().toString(),
      descriptions: _descriptionsController.value,
    );

    addNewIncome(_incomeToSubmit);
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
