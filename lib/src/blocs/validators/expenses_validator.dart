import 'dart:async';

class ExpensesValidator {
  StreamTransformer<String, String> _titleTransformer() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (String title, EventSink sink) {
        if (title.length < 1)
          sink.addError("Title Can not be Empty");
        else
          sink.add(title);
      },
    );
  }

  StreamTransformer<int, int> _amountTransformer() {
    return StreamTransformer<int, int>.fromHandlers(
      handleData: (int amount, EventSink sink) {
        if (amount < 1)
          sink.addError("Amount Can not be less than zero");
        else
          sink.add(amount);
      },
    );
  }

  StreamTransformer<String, String> get validateTitle => _titleTransformer();
  StreamTransformer<int, int> get validateAmount => _amountTransformer();
}
