import 'dart:async';

import '../../res/repo.dart';

class IncomesValidator {
  /*
   * class to provider validators releated to incomes
   * 
   */

  // create a StreamTransformer for each field want to be validated
  final StreamTransformer titleValidator =
      StreamTransformer<String, String>.fromHandlers(
    handleData: _titleValidatorHandler,
  );

  final StreamTransformer amountValidator =
      StreamTransformer<int, int>.fromHandlers(
    handleData: _amountValidatorHandler,
  );

  final StreamTransformer accountIdValidator =
      StreamTransformer<int, int>.fromHandlers(
    handleData: _accountIdValidatorHandler,
  );

  static void _titleValidatorHandler(String value, EventSink sink) {
    /*
      * method to handle validation of title field
      * @params String, EventSink
      */

    if (value.length < 1) {
      sink.addError("Title Can't be less than one character");
    } else {
      sink.add(value);
    }
  }

  static void _amountValidatorHandler(int value, EventSink sink) {
    /*
     * method to handle validation of amount field 
     * 
     * @params int, EventSink 
     */
    
    if (value < 1) {
      sink.addError("Amount Can't be less than one!");
    }
    else {
      sink.add(value);
    }
  }

  static void _accountIdValidatorHandler(int accountID, EventSink sink) async {
    /*
     * method to handle validation of account id field
     * it checks if account id entered exist in database
     * 
     * @params int, EventSink
     */

    if ( await Repo().getAccountByID(accountID) != null ){
      sink.add(accountID);
    }
    else {
      sink.addError("Account with ID $accountID not Found!");
    }
  }
}
