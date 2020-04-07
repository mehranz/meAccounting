import 'dart:async';

class AccountValidator {
  /*
   * AccountsValidator class to provide validator mixins
   * in order to validate textfields which releated to accounts
   */

  // assign getter for each validator transformer helper method
  StreamTransformer<String, String> get titleValidator => _titleTransformer();
  StreamTransformer<int, int> get amountValidator => _amountTransformer();
  StreamTransformer<int, int> get cardNumberValidator =>
      _cardNumberTransformer();

  StreamTransformer<String, String> _titleTransformer() {
    /**
     * Helper method to create validate title transformer
     *
     * @return StreamTransformer<String, String>
     */

    return StreamTransformer<String, String>.fromHandlers(
      handleData: (String enteredTitle, EventSink<String> sink) {
        if (enteredTitle.length < 1) {
          sink.addError("Title Can not be empty");
        } else {
          sink.add(enteredTitle);
        }
      },
    );
  }

  StreamTransformer<int, int> _amountTransformer() {
    /**
     * Helper method to create validate amount transformer
     *
     * @return StreamTransformer<int, int>
     */

    return StreamTransformer<int, int>.fromHandlers(
      handleData: (int enteredAmount, EventSink<int> sink) {
        if (enteredAmount < 1) {
          sink.addError("amount cant be less than one!");
        } else {
          sink.add(enteredAmount);
        }
      },
    );
  }

  StreamTransformer<int, int> _cardNumberTransformer() {
    /**
     * Helper method to create validate card number transformer
     *
     * @return StreamTransformer<int, int>
     */

    return StreamTransformer<int, int>.fromHandlers(
      handleData: (int enteredCardNumber, EventSink<int> sink) {
        if (enteredCardNumber < 999999999999999) {
          sink.addError("Card number cant be shorter than 16 digits");
        } else if (enteredCardNumber > 9999999999999999) {
          sink.addError("Card number cant be longer than 16 digits");
        } else {
          sink.add(enteredCardNumber);
        }
      },
    );
  }
}
