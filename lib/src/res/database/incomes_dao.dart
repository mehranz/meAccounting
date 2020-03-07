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

