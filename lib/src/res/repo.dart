import 'dart:async';
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

  Future createAccount(AccountModel account) => dao.createAccount(account);

  Future getAllAccounts() => dao.getAllAccounts();

  Future deleteAccount(int id) => dao.deleteAccount(id);

  Future getAccountByID(int id) => dao.getAccountByID(id);

  Future updateAccount(AccountModel account) => dao.updateAccount(account);
  
}