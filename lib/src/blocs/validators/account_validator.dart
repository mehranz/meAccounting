import 'dart:async';

class AccountValidator {
  /*
   * AccountsValidator class to provide validator mixins
   * in order to validate textfields which releated to accounts
   */

  // TODO: Create Some Helper Methods to make code cleaner
  //
  final StreamTransformer titleValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length < 1) {
      sink.addError("Title Can not be empty");
    } else {
      sink.add(data);
    }
  });

  final StreamTransformer amountValidator =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    if (data < 1) {
      sink.addError("amount cant be less than one!");
    } else {
      sink.add(data);
    }
  });

  final StreamTransformer cardNumberValidator =
      StreamTransformer<int, int>.fromHandlers(handleData: (int data, sink) {
    if (data < 999999999999999) {
      sink.addError("Card number cant be shorter than 16 digits");
    } else if (data > 9999999999999999) {
      sink.addError("Card number cant be longer than 16 digits");
    } else {
      sink.add(data);
    }
  });
}
