import 'dart:async';

import 'package:meAccounting/src/blocs/validators/account_validator.dart';
import 'package:meAccounting/src/models/account_model.dart';
import 'package:meAccounting/src/res/repo.dart';

class AccountsBloc extends Object with AccountValidator {
  /*
   * AccountsBloc Class to provide business logic 
   * in order to handle states of app
   */

  // create an instance of repository in order to intract with databse
  // inside Accounts bloc class
  final _repo = Repo();

  // create streams for every state wanted to be controlled
  final StreamController _accountsController =
      StreamController<List<AccountModel>>();
  final StreamController _titleController = StreamController<String>();
  final StreamController _initialAmountController = StreamController<int>();
  final StreamController _cardNumberController = StreamController<int>();

  final StreamController _totalBankAmountController = StreamController<int>();

  AccountsBloc() {
    getAllAccounts();
  }

  // ============ getters section
  Stream<List<AccountModel>> get accounts => _accountsController.stream;

  Stream<String> get titleStream =>
      _titleController.stream.transform(titleValidator);
  Function(String) get addTitle => _titleController.sink.add;

  Stream<int> get initialAmountStream =>
      _initialAmountController.stream.transform(amountValidator);
  Function(int) get addInitialAmount => _initialAmountController.sink.add;

  Stream<int> get cardNumberStream =>
      _cardNumberController.stream.transform(cardNumberValidator);
  Function(int) get addCardNumber => _cardNumberController.sink.add;

  Stream<int> get totalBankAmount => _totalBankAmountController.stream;
  // ======== end getters section

  void getAllAccounts() async {
    /*
     * getAllAccounts method will get all accounts from database
     * and add it to accounts sink.
     * NOTE: each time this method calls the StreamBuilder that uses 
     *       _accountsController.stream will be rebuild.
     * 
     * @params
     * @return
     */

    var _accounts = await _repo.getAllAccounts();
    _accountsController.sink.add(_accounts);
  }

  void addAccountToDB(AccountModel account) {
    /*
     * addAccountToDb helper method to add AccountModel to db
     * directly from bloc instances and then update accounts stream
     * 
     * @param AccountModel
     * @return
     */
    _repo.createAccount(account);
    getAllAccounts();
    getTotalBankAmount();
  }

  void deleteAccountFromDB(int id) {
    /*
     * deleteAccountFromDB helper method to directly delete AccountModel 
     * by id from db with created bloc instance and then update accounts stream
     * 
     * @params int
     * @return
     */
    _repo.deleteAccount(id);
    getAllAccounts();
    getTotalBankAmount();
  }

  void updateAccount(AccountModel account) {
    /*
     * updateAccount helper method to directly update AccountModel
     * inside database with created bloc instance and then update accounts stream
     * 
     * @params AccountModel
     * @return 
     */
    _repo.updateAccount(account);
    getAllAccounts();
    getTotalBankAmount();
  }

  void getTotalBankAmount() async {
    /*
     * getTotalBankAmount Helper will get total amount of all accounts from db
     * and add them to _totalBankAmountController stream so streambuilders can
     * build themselvs when new data came out.
     */

    var _totalBankAmount = await _repo.getAllAccountsAmount();
    _totalBankAmountController.sink.add(_totalBankAmount);
  }

  dispose() {
    /*
     * dispose method to close open streams
     * 
     * @params
     * @return
     */

    _accountsController.close();
    _titleController.close();
    _initialAmountController.close();
    _cardNumberController.close();
    _totalBankAmountController.close();
  }
}
