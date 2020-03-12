import 'dart:async';
import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/res/database/expenses_dao.dart';
import 'package:meAccounting/src/res/database/incomes_dao.dart';
import '../models/income_model.dart';

import './database/dao.dart';
import '../models/account_model.dart';

class Repo {
  /*
   * Repo Class to Help access and sync data between sources
   * NOTE: There's just one source in applications for now
   *       and it's database. [but just for now :)]
   * 
   */

  final dao = DAO();
  final expensesDao = ExpensesDAO();
  final incomesDao = IncomesDao();

  Future createAccount(AccountModel account) => dao.createAccount(account);

  Future getAllAccounts() => dao.getAllAccounts();

  Future deleteAccount(int id) => dao.deleteAccount(id);

  Future<AccountModel> getAccountByID(int id) => dao.getAccountByID(id);

  Future updateAccount(AccountModel account) => dao.updateAccount(account);

  Future getAllAccountsAmount() => dao.getAllAccountsAmount();


  // Expenses Section
  Future createExpense(ExpenseModel expense) => expensesDao.createNewExpense(expense);

  Future getAllExpenses() => expensesDao.getAllExpenses();

  Future getTotalExpensesFrom(String from) => expensesDao.getTotalExpensesFrom(from);

  Future deleteExpense(ExpenseModel expense) => expensesDao.deleteExpense(expense); 

  // incomes section
  Future createIncome(IncomeModel income) => incomesDao.createIncome(income);
  Future getAllIncomes() => incomesDao.getAllIncomes();
  Future deleteIncome(IncomeModel income) => incomesDao.deleteIncome(income);
  
}