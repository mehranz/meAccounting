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
  final StreamController _incomesController = StreamController<List<IncomeModel>>();
  final StreamController _titleController = StreamController<String>();
  final StreamController _amountController = StreamController<int>();
  final StreamController _accountIdController = StreamController<int>();
  final StreamController _descriptionsController = StreamController<String>();

  // setter and getter for each controller's stream and its sink
  //
  Stream<List<IncomeModel>> get incomes => _incomesController.stream;

  // Getters for Title Controller
  Stream<String> get title => _titleController.stream.transform(titleValidator);
  Function(String) get addTitle => _titleController.sink.add;

  // Getters for Amount Controller
  Stream<int> get amount => _amountController.stream.transform(amountValidator);
  Function(int) get addAmount => _amountController.sink.add;

  // Getters for Account Controller
  Stream<int> get accountId => _accountIdController.stream.transform(accountIdValidator);
  Function(int) get addAccountId => _accountIdController.sink.add;

  // Getters for Descriptions Controller
  Stream<String> get descriptions => _descriptionsController.stream;
  Function(String) get addDescriptions => _descriptionsController.sink.add;

  dispose() {
    /*
     * method to close open streams
     * 
     */
    _titleController.close();
    _amountController.close();
    _accountIdController.close();
    _descriptionsController.close();
  }
}
