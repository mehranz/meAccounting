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
