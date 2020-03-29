import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';
import 'package:meAccounting/src/screens/add_incomes_screen.dart';
import 'package:meAccounting/src/widgets/bank_account_dropdown.dart';

class EditIncomeScreen extends AddIncomeScreen {
  /*
   * class to hold edit income screen elements
   * 
   * @param IncomeModel
   */

  // get income model that wanted to be edited [with constructor]
  final IncomeModel _income;

  // get income model that wanted to be edited
  EditIncomeScreen(this._income);
  
  @override
  TextEditingController get titleController => super.titleController..text = _income.title;

  @override
  TextEditingController get amountController => super.amountController..text = _income.amount.toString();

  @override
  TextEditingController get descriptionsController => super.descriptionsController..text = _income.descriptions;

  @override
  Widget accountIdField({int currentValue}) {
    return super.accountIdField(currentValue: _income.account_id);
  }
  
  @override
  Widget submitButton(BuildContext context, Function submit) {
    submit = () => bloc.updateIncome(_income);
    return super.submitButton(context, submit);
  }
}
