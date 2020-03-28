import 'package:flutter/material.dart';
import 'package:meAccounting/src/models/expense_model.dart';
import 'package:meAccounting/src/screens/add_expense_screen.dart';

class EditExpenseScreen extends AddNewExpensesScreen {

  // get expense model wanted to be edited from constructor
  final ExpenseModel _expense;

  // get expense model wanted to be edited
  EditExpenseScreen(this._expense);

  @override
  TextEditingController get titleFieldController => super.titleFieldController..text = _expense.title;

  @override
  TextEditingController get amountFieldController => super.amountFieldController..text = _expense.amount.toString();

  @override
  TextEditingController get descriptionsFieldController => super.descriptionsFieldController..text = _expense.descriptions;

  @override
  Widget accountsFieldDropdown({int currentValue}) {
    return super.accountsFieldDropdown(currentValue: _expense.accountId);
  }

  @override
  Widget submitButton(BuildContext context, Function submit) {
    submit = () => bloc.updateExpense(_expense);
    return super.submitButton(context, submit);
  }
}
