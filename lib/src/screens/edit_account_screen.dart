import 'package:flutter/material.dart';
import 'package:meAccounting/src/models/account_model.dart';
import 'package:meAccounting/src/screens/add_new_account_screen.dart';

class EditAccountScreen extends AddNewAccountScreen {
  final AccountModel _account;
  EditAccountScreen(this._account);

  @override
  TextEditingController get titleController =>
      super.titleController..text = _account.title;

  @override
  TextEditingController get amountController =>
      super.amountController..text = _account.initalAmount.toString();

  @override
  TextEditingController get cardNumberController =>
      super.cardNumberController..text = _account.cardNumber.toString();
      
  @override
  Widget submitButton(BuildContext context, Function submit) {
    // submit button updates given account
    submit = () => bloc.updateAccount(_account.id);
    return super.submitButton(context, submit);
  }    
}
